module MLInterop

(** ** `public` and `tainted` classes *)
(* Intuition, without extra checking and wrapping:
- the types we can safely assume for malicious ML values have to be `tainted`
- the types we can safely export to malicious ML code have to be `public` *)

class public (t:Type) = { pdummy : unit }
class tainted (t:Type) = { tdummy : unit }
// TODO: How to properly declare empty type classes?
// TODO: Any way to declare "sealed type classes"? Or more generally,
//       restricting who can add new instances, since it's a dangerous operation

let is_public t [| public t |] = ()
let is_tainted t [| tainted t |] = ()

// Basic ML types are all public and tainted
instance public_unit : public unit = { pdummy = () }
instance tainted_unit : tainted unit = { tdummy = () }
instance public_bool : public bool = { pdummy = () }
instance tainted_bool : tainted bool = { tdummy = () }
instance public_int : public int = { pdummy = () }
instance tainted_int : tainted int = { tdummy = () }
instance public_string : public string = { pdummy = () }
instance tainted_string : tainted string = { tdummy = () }

// Refinement types are public, but only trivial refinements are tainted
instance public_refined t p [| public t |] : public (x:t{p x}) = { pdummy = () }
instance tainted_refined t [| tainted t |] : tainted (x:t{True}) = { tdummy = () }
let untainted = x:int{x = 42}
let _ = is_public (x:int{x = 42}); is_tainted (x:int{True})
(* let _ = is_public untainted -- TODO: this should work, why are things not unfolded *)
(* [@(expect_failure)] -- TODO: the code below does fail, but this expect_failure blows up
let _ = is_tainted untainted *)

// Non-dependent pairs work pointwise
instance public_pair t1 t2 [| public t1 |] [| public t2 |] : public (t1 * t2) = { pdummy = () }
instance tainted_pair t1 t2 [| tainted t1 |] [| tainted t2 |] : tainted (t1 * t2) = { tdummy = () }
let _ = is_public (int*bool); is_tainted (int*bool)
(* let _ = is_tainted (int*untainted) -- fails as it should *)

// Dependent pairs are not tainted
(* let _ = is_tainted (x:int & (y:int{True})) -- fails as it should *)

// Dependent pairs could in principle be made public
// TODO: provided we find a way to make this actually work in practice:
(* instance public_dpair t1 t2 [| public t1 |] [| (x:t1 -> public (t2 x)) |] : public (x:t1 & (t2 x)) *)
(*   = { pdummy = () } *)
(* let _ = is_public (x:int & (y:int{True})) -- try to make this work *)

// Simple inductives like lists are also co-variant
instance public_list t [| public t |] : public (list t) = { pdummy = () }
instance tainted_list t [| tainted t |] : tainted (list t) = { tdummy = () }
let _ = is_public (list int); is_tainted (list bool)
(* let _ = is_tainted (list untainted) -- fails as it should *)
// TODO: any kind of "deriving" mechanism that could give us instances for all ML-like inductives?

// Non-dependent arrows are contravariant in arguments and covariant in results, as usual
instance public_arrow t1 t2 [| tainted t1 |] [| public t2 |] : public (t1 -> t2) = { pdummy = () }
instance tainted_arrow t1 t2 [| public t1 |] [| tainted t2 |] : tainted (t1 -> t2) = { tdummy = () }
let _ = is_public (int -> bool); is_tainted (bool -> int)
let _ = is_public (bool -> x:int{x = 42}); is_tainted (x:int{x = 42} -> int)
(* let _ = is_public ((x:int{x = 42}) -> bool) -- fails as it should *)
(* let _ = is_tainted (int -> x:int{x = 42}) -- fails as it should *)

// Dependent arrows are neither public not tainted ? TODO: think a bit more
(* let _ = is_public (x:int -> y:int{x=42}) -- fails as it should? *)
(* let _ = is_tainted (x:int -> y:int{x=42}) -- fails as it should? *)


(** ** `exportable` and `importable` classes *)

open FStar.Tactics.Typeclasses
open FStar.Exn

exception Contract_failure

class exportable (t1 t2 : Type) = { export : t1 -> t2; public_super : public t2 }
class importable (t1 t2 : Type) = { import : t1 -> Ex t2; tainted_super : tainted t1 }
(* TODO: This style of defining subclasses is quite a mouthful;
         could define "smart constructors" like in
         https://github.com/FStarLang/FStar/blob/master/examples/typeclasses/Num.fst#L38 *)

(* TODO: Superclass projectors should be autogenerated *)
instance public_exportable (#t1 #t2 : Type) (d : exportable t1 t2) : public t2 = d.public_super
instance tainted_importable (#t1 #t2 : Type) (d : importable t1 t2) : tainted t1 = d.tainted_super

instance exportable_public t [| public t|] : exportable t t = {
  export = (fun x -> x);
  public_super = solve
}

instance importable_tainted t [| tainted t|] : importable t t = {
  import = (fun x -> x);
  tainted_super = solve
}

class decidable (t:Type) (p : t -> Type0) = { dec : (x:t -> b:bool{b <==> p x}) }

instance importable_refinement t [| tainted t |] (p : t -> Type0) [| decidable t p |] : importable t (x:t{p x}) = {
  import = (fun (x:t) -> if dec #t #p x then x <: (x:t{p x}) else raise Contract_failure );
    (* TODO: quite a few type annotations needed above *)
  tainted_super = solve
}

instance exportable_pair t1 u1 t2 u2 [| exportable t1 t2 |] [| exportable u1 u2 |]
      [| public t2 |] [| public u2 |] (* -- TODO: These two shouldn't be needed, but they are *)
    : exportable (t1 * u1) (t2 * u2) = {
  export = (fun (x,y) -> (export x, export y));
  public_super = solve
}

instance importable_pair t1 u1 t2 u2 [| importable t1 t2 |] [| importable u1 u2 |]
      [| tainted t1 |] [| tainted u1 |] (* -- TODO: These two shouldn't be needed, but they are *)
    : importable (t1 * u1) (t2 * u2) = {
  import = (fun (x,y) -> (import x, import y));
  tainted_super = solve
}

instance public_exarrow t1 t2 [| tainted t1 |] [| public t2 |] : public (t1 -> Ex t2) = { pdummy = () }
instance tainted_exarrow t1 t2 [| public t1 |] [| tainted t2 |] : tainted (t1 -> Ex t2) = { tdummy = () }

(* TODO: dual version below works, how can this be? *)
(* instance exportable_arrow t1 u1 t2 u2 [| importable t2 t1 |] [| exportable u1 u2 |] *)
(*       [| tainted t2 |] [| public u2 |] (\* -- TODO: These two shouldn't be needed, but they are *\) *)
(*       [| public (t2 -> Ex u2) |] (\* -- TODO: not even this solves the error below asking about this instance *\) *)
(*     : exportable (t1 -> u1) (t2 -> Ex u2) = { *)
(*   export = (fun (f:(t1->u1)) -> (fun (x:t2) -> export (f (import x)))); *)
(*   public_super = solve *)
(* } *)

instance importable_arrow t1 u1 t2 u2 [| exportable t2 t1 |] [| importable u1 u2 |]
      [| public t1 |] [| tainted u1 |] (* -- TODO: These two shouldn't be needed, but they are *)
    : importable (t1 -> u1) (t2 -> Ex u2) = {
  import = (fun (f:(t1->u1)) -> (fun (x:t2) -> import (f (export x))));
  tainted_super = solve
}