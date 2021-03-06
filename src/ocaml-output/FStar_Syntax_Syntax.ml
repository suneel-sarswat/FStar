open Prims
type 'a withinfo_t = {
  v: 'a ;
  p: FStar_Range.range }[@@deriving yojson,show]
let __proj__Mkwithinfo_t__item__v : 'a . 'a withinfo_t -> 'a =
  fun projectee -> match projectee with | { v; p;_} -> v
let __proj__Mkwithinfo_t__item__p : 'a . 'a withinfo_t -> FStar_Range.range =
  fun projectee -> match projectee with | { v; p;_} -> p
type var = FStar_Ident.lident withinfo_t[@@deriving yojson,show]
type sconst = FStar_Const.sconst[@@deriving yojson,show]
type pragma =
  | SetOptions of Prims.string 
  | ResetOptions of Prims.string FStar_Pervasives_Native.option 
  | PushOptions of Prims.string FStar_Pervasives_Native.option 
  | PopOptions 
  | RestartSolver 
  | LightOff [@@deriving yojson,show]
let (uu___is_SetOptions : pragma -> Prims.bool) =
  fun projectee ->
    match projectee with | SetOptions _0 -> true | uu____179 -> false
let (__proj__SetOptions__item___0 : pragma -> Prims.string) =
  fun projectee -> match projectee with | SetOptions _0 -> _0
let (uu___is_ResetOptions : pragma -> Prims.bool) =
  fun projectee ->
    match projectee with | ResetOptions _0 -> true | uu____204 -> false
let (__proj__ResetOptions__item___0 :
  pragma -> Prims.string FStar_Pervasives_Native.option) =
  fun projectee -> match projectee with | ResetOptions _0 -> _0
let (uu___is_PushOptions : pragma -> Prims.bool) =
  fun projectee ->
    match projectee with | PushOptions _0 -> true | uu____235 -> false
let (__proj__PushOptions__item___0 :
  pragma -> Prims.string FStar_Pervasives_Native.option) =
  fun projectee -> match projectee with | PushOptions _0 -> _0
let (uu___is_PopOptions : pragma -> Prims.bool) =
  fun projectee ->
    match projectee with | PopOptions -> true | uu____262 -> false
let (uu___is_RestartSolver : pragma -> Prims.bool) =
  fun projectee ->
    match projectee with | RestartSolver -> true | uu____273 -> false
let (uu___is_LightOff : pragma -> Prims.bool) =
  fun projectee ->
    match projectee with | LightOff -> true | uu____284 -> false
type 'a memo =
  (('a FStar_Pervasives_Native.option FStar_ST.ref)[@printer
                                                     fun fmt ->
                                                       fun _ ->
                                                         Format.pp_print_string
                                                           fmt "None"])
[@@deriving yojson,show]
type emb_typ =
  | ET_abstract 
  | ET_fun of (emb_typ * emb_typ) 
  | ET_app of (Prims.string * emb_typ Prims.list) 
let (uu___is_ET_abstract : emb_typ -> Prims.bool) =
  fun projectee ->
    match projectee with | ET_abstract -> true | uu____324 -> false
let (uu___is_ET_fun : emb_typ -> Prims.bool) =
  fun projectee ->
    match projectee with | ET_fun _0 -> true | uu____340 -> false
let (__proj__ET_fun__item___0 : emb_typ -> (emb_typ * emb_typ)) =
  fun projectee -> match projectee with | ET_fun _0 -> _0
let (uu___is_ET_app : emb_typ -> Prims.bool) =
  fun projectee ->
    match projectee with | ET_app _0 -> true | uu____378 -> false
let (__proj__ET_app__item___0 :
  emb_typ -> (Prims.string * emb_typ Prims.list)) =
  fun projectee -> match projectee with | ET_app _0 -> _0
type version = {
  major: Prims.int ;
  minor: Prims.int }[@@deriving yojson,show]
let (__proj__Mkversion__item__major : version -> Prims.int) =
  fun projectee -> match projectee with | { major; minor;_} -> major
let (__proj__Mkversion__item__minor : version -> Prims.int) =
  fun projectee -> match projectee with | { major; minor;_} -> minor
type universe =
  | U_zero 
  | U_succ of universe 
  | U_max of universe Prims.list 
  | U_bvar of Prims.int 
  | U_name of FStar_Ident.ident 
  | U_unif of (universe FStar_Pervasives_Native.option FStar_Unionfind.p_uvar
  * version * FStar_Range.range) 
  | U_unknown [@@deriving yojson,show]
let (uu___is_U_zero : universe -> Prims.bool) =
  fun projectee -> match projectee with | U_zero -> true | uu____491 -> false
let (uu___is_U_succ : universe -> Prims.bool) =
  fun projectee ->
    match projectee with | U_succ _0 -> true | uu____503 -> false
let (__proj__U_succ__item___0 : universe -> universe) =
  fun projectee -> match projectee with | U_succ _0 -> _0
let (uu___is_U_max : universe -> Prims.bool) =
  fun projectee ->
    match projectee with | U_max _0 -> true | uu____524 -> false
let (__proj__U_max__item___0 : universe -> universe Prims.list) =
  fun projectee -> match projectee with | U_max _0 -> _0
let (uu___is_U_bvar : universe -> Prims.bool) =
  fun projectee ->
    match projectee with | U_bvar _0 -> true | uu____550 -> false
let (__proj__U_bvar__item___0 : universe -> Prims.int) =
  fun projectee -> match projectee with | U_bvar _0 -> _0
let (uu___is_U_name : universe -> Prims.bool) =
  fun projectee ->
    match projectee with | U_name _0 -> true | uu____572 -> false
let (__proj__U_name__item___0 : universe -> FStar_Ident.ident) =
  fun projectee -> match projectee with | U_name _0 -> _0
let (uu___is_U_unif : universe -> Prims.bool) =
  fun projectee ->
    match projectee with | U_unif _0 -> true | uu____601 -> false
let (__proj__U_unif__item___0 :
  universe ->
    (universe FStar_Pervasives_Native.option FStar_Unionfind.p_uvar * version
      * FStar_Range.range))
  = fun projectee -> match projectee with | U_unif _0 -> _0
let (uu___is_U_unknown : universe -> Prims.bool) =
  fun projectee ->
    match projectee with | U_unknown -> true | uu____649 -> false
type univ_name = FStar_Ident.ident[@@deriving yojson,show]
type universe_uvar =
  (universe FStar_Pervasives_Native.option FStar_Unionfind.p_uvar * version *
    FStar_Range.range)[@@deriving yojson,show]
type univ_names = univ_name Prims.list[@@deriving yojson,show]
type universes = universe Prims.list[@@deriving yojson,show]
type monad_name = FStar_Ident.lident[@@deriving yojson,show]
type quote_kind =
  | Quote_static 
  | Quote_dynamic [@@deriving yojson,show]
let (uu___is_Quote_static : quote_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Quote_static -> true | uu____674 -> false
let (uu___is_Quote_dynamic : quote_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Quote_dynamic -> true | uu____685 -> false
type maybe_set_use_range =
  | NoUseRange 
  | SomeUseRange of FStar_Range.range [@@deriving yojson,show]
let (uu___is_NoUseRange : maybe_set_use_range -> Prims.bool) =
  fun projectee ->
    match projectee with | NoUseRange -> true | uu____701 -> false
let (uu___is_SomeUseRange : maybe_set_use_range -> Prims.bool) =
  fun projectee ->
    match projectee with | SomeUseRange _0 -> true | uu____713 -> false
let (__proj__SomeUseRange__item___0 :
  maybe_set_use_range -> FStar_Range.range) =
  fun projectee -> match projectee with | SomeUseRange _0 -> _0
type delta_depth =
  | Delta_constant_at_level of Prims.int 
  | Delta_equational_at_level of Prims.int 
  | Delta_abstract of delta_depth [@@deriving yojson,show]
let (uu___is_Delta_constant_at_level : delta_depth -> Prims.bool) =
  fun projectee ->
    match projectee with
    | Delta_constant_at_level _0 -> true
    | uu____750 -> false
let (__proj__Delta_constant_at_level__item___0 : delta_depth -> Prims.int) =
  fun projectee -> match projectee with | Delta_constant_at_level _0 -> _0
let (uu___is_Delta_equational_at_level : delta_depth -> Prims.bool) =
  fun projectee ->
    match projectee with
    | Delta_equational_at_level _0 -> true
    | uu____773 -> false
let (__proj__Delta_equational_at_level__item___0 : delta_depth -> Prims.int)
  =
  fun projectee -> match projectee with | Delta_equational_at_level _0 -> _0
let (uu___is_Delta_abstract : delta_depth -> Prims.bool) =
  fun projectee ->
    match projectee with | Delta_abstract _0 -> true | uu____795 -> false
let (__proj__Delta_abstract__item___0 : delta_depth -> delta_depth) =
  fun projectee -> match projectee with | Delta_abstract _0 -> _0
type should_check_uvar =
  | Allow_unresolved 
  | Allow_untyped 
  | Strict [@@deriving yojson,show]
let (uu___is_Allow_unresolved : should_check_uvar -> Prims.bool) =
  fun projectee ->
    match projectee with | Allow_unresolved -> true | uu____813 -> false
let (uu___is_Allow_untyped : should_check_uvar -> Prims.bool) =
  fun projectee ->
    match projectee with | Allow_untyped -> true | uu____824 -> false
let (uu___is_Strict : should_check_uvar -> Prims.bool) =
  fun projectee -> match projectee with | Strict -> true | uu____835 -> false
type term' =
  | Tm_bvar of bv 
  | Tm_name of bv 
  | Tm_fvar of fv 
  | Tm_uinst of (term' syntax * universes) 
  | Tm_constant of sconst 
  | Tm_type of universe 
  | Tm_abs of ((bv * arg_qualifier FStar_Pervasives_Native.option) Prims.list
  * term' syntax * residual_comp FStar_Pervasives_Native.option) 
  | Tm_arrow of ((bv * arg_qualifier FStar_Pervasives_Native.option)
  Prims.list * comp' syntax) 
  | Tm_refine of (bv * term' syntax) 
  | Tm_app of (term' syntax * (term' syntax * arg_qualifier
  FStar_Pervasives_Native.option) Prims.list) 
  | Tm_match of (term' syntax * (pat' withinfo_t * term' syntax
  FStar_Pervasives_Native.option * term' syntax) Prims.list) 
  | Tm_ascribed of (term' syntax * ((term' syntax, comp' syntax)
  FStar_Util.either * term' syntax FStar_Pervasives_Native.option) *
  FStar_Ident.lident FStar_Pervasives_Native.option) 
  | Tm_let of ((Prims.bool * letbinding Prims.list) * term' syntax) 
  | Tm_uvar of (ctx_uvar * (subst_elt Prims.list Prims.list *
  maybe_set_use_range)) 
  | Tm_delayed of (term' syntax * (subst_elt Prims.list Prims.list *
  maybe_set_use_range)) 
  | Tm_meta of (term' syntax * metadata) 
  | Tm_lazy of lazyinfo 
  | Tm_quoted of (term' syntax * quoteinfo) 
  | Tm_unknown 
and ctx_uvar =
  {
  ctx_uvar_head:
    (term' syntax FStar_Pervasives_Native.option FStar_Unionfind.p_uvar *
      version * FStar_Range.range)
    ;
  ctx_uvar_gamma: binding Prims.list ;
  ctx_uvar_binders:
    (bv * arg_qualifier FStar_Pervasives_Native.option) Prims.list ;
  ctx_uvar_typ: term' syntax ;
  ctx_uvar_reason: Prims.string ;
  ctx_uvar_should_check: should_check_uvar ;
  ctx_uvar_range: FStar_Range.range ;
  ctx_uvar_meta: ctx_uvar_meta_t FStar_Pervasives_Native.option }
and ctx_uvar_meta_t =
  | Ctx_uvar_meta_tac of (FStar_Dyn.dyn * term' syntax) 
  | Ctx_uvar_meta_attr of term' syntax 
and pat' =
  | Pat_constant of sconst 
  | Pat_cons of (fv * (pat' withinfo_t * Prims.bool) Prims.list) 
  | Pat_var of bv 
  | Pat_wild of bv 
  | Pat_dot_term of (bv * term' syntax) 
and letbinding =
  {
  lbname: (bv, fv) FStar_Util.either ;
  lbunivs: univ_name Prims.list ;
  lbtyp: term' syntax ;
  lbeff: FStar_Ident.lident ;
  lbdef: term' syntax ;
  lbattrs: term' syntax Prims.list ;
  lbpos: FStar_Range.range }
and quoteinfo =
  {
  qkind: quote_kind ;
  antiquotes: (bv * term' syntax) Prims.list }
and comp_typ =
  {
  comp_univs: universes ;
  effect_name: FStar_Ident.lident ;
  result_typ: term' syntax ;
  effect_args:
    (term' syntax * arg_qualifier FStar_Pervasives_Native.option) Prims.list ;
  flags: cflag Prims.list }
and comp' =
  | Total of (term' syntax * universe FStar_Pervasives_Native.option) 
  | GTotal of (term' syntax * universe FStar_Pervasives_Native.option) 
  | Comp of comp_typ 
and cflag =
  | TOTAL 
  | MLEFFECT 
  | LEMMA 
  | RETURN 
  | PARTIAL_RETURN 
  | SOMETRIVIAL 
  | TRIVIAL_POSTCONDITION 
  | SHOULD_NOT_INLINE 
  | CPS 
  | DECREASES of term' syntax 
and metadata =
  | Meta_pattern of (term' syntax Prims.list * (term' syntax * arg_qualifier
  FStar_Pervasives_Native.option) Prims.list Prims.list) 
  | Meta_named of FStar_Ident.lident 
  | Meta_labeled of (Prims.string * FStar_Range.range * Prims.bool) 
  | Meta_desugared of meta_source_info 
  | Meta_monadic of (monad_name * term' syntax) 
  | Meta_monadic_lift of (monad_name * monad_name * term' syntax) 
and meta_source_info =
  | Sequence 
  | Primop 
  | Masked_effect 
  | Meta_smt_pat 
and fv_qual =
  | Data_ctor 
  | Record_projector of (FStar_Ident.lident * FStar_Ident.ident) 
  | Record_ctor of (FStar_Ident.lident * FStar_Ident.ident Prims.list) 
and subst_elt =
  | DB of (Prims.int * bv) 
  | NM of (bv * Prims.int) 
  | NT of (bv * term' syntax) 
  | UN of (Prims.int * universe) 
  | UD of (univ_name * Prims.int) 
and 'a syntax = {
  n: 'a ;
  pos: FStar_Range.range ;
  vars: free_vars memo }
and bv = {
  ppname: FStar_Ident.ident ;
  index: Prims.int ;
  sort: term' syntax }
and fv =
  {
  fv_name: var ;
  fv_delta: delta_depth ;
  fv_qual: fv_qual FStar_Pervasives_Native.option }
and free_vars =
  {
  free_names: bv Prims.list ;
  free_uvars: ctx_uvar Prims.list ;
  free_univs: universe_uvar Prims.list ;
  free_univ_names: univ_name Prims.list }
and residual_comp =
  {
  residual_effect: FStar_Ident.lident ;
  residual_typ: term' syntax FStar_Pervasives_Native.option ;
  residual_flags: cflag Prims.list }
and lazyinfo =
  {
  blob: FStar_Dyn.dyn ;
  lkind: lazy_kind ;
  ltyp: term' syntax ;
  rng: FStar_Range.range }
and lazy_kind =
  | BadLazy 
  | Lazy_bv 
  | Lazy_binder 
  | Lazy_optionstate 
  | Lazy_fvar 
  | Lazy_comp 
  | Lazy_env 
  | Lazy_proofstate 
  | Lazy_goal 
  | Lazy_sigelt 
  | Lazy_uvar 
  | Lazy_embedding of (emb_typ * term' syntax FStar_Thunk.t) 
and binding =
  | Binding_var of bv 
  | Binding_lid of (FStar_Ident.lident * (univ_name Prims.list * term'
  syntax)) 
  | Binding_univ of univ_name 
and arg_qualifier =
  | Implicit of Prims.bool 
  | Meta of arg_qualifier_meta_t 
  | Equality 
and arg_qualifier_meta_t =
  | Arg_qualifier_meta_tac of term' syntax 
  | Arg_qualifier_meta_attr of term' syntax 
let (uu___is_Tm_bvar : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_bvar _0 -> true | uu____1711 -> false
let (__proj__Tm_bvar__item___0 : term' -> bv) =
  fun projectee -> match projectee with | Tm_bvar _0 -> _0
let (uu___is_Tm_name : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_name _0 -> true | uu____1730 -> false
let (__proj__Tm_name__item___0 : term' -> bv) =
  fun projectee -> match projectee with | Tm_name _0 -> _0
let (uu___is_Tm_fvar : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_fvar _0 -> true | uu____1749 -> false
let (__proj__Tm_fvar__item___0 : term' -> fv) =
  fun projectee -> match projectee with | Tm_fvar _0 -> _0
let (uu___is_Tm_uinst : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_uinst _0 -> true | uu____1774 -> false
let (__proj__Tm_uinst__item___0 : term' -> (term' syntax * universes)) =
  fun projectee -> match projectee with | Tm_uinst _0 -> _0
let (uu___is_Tm_constant : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_constant _0 -> true | uu____1811 -> false
let (__proj__Tm_constant__item___0 : term' -> sconst) =
  fun projectee -> match projectee with | Tm_constant _0 -> _0
let (uu___is_Tm_type : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_type _0 -> true | uu____1830 -> false
let (__proj__Tm_type__item___0 : term' -> universe) =
  fun projectee -> match projectee with | Tm_type _0 -> _0
let (uu___is_Tm_abs : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_abs _0 -> true | uu____1867 -> false
let (__proj__Tm_abs__item___0 :
  term' ->
    ((bv * arg_qualifier FStar_Pervasives_Native.option) Prims.list * term'
      syntax * residual_comp FStar_Pervasives_Native.option))
  = fun projectee -> match projectee with | Tm_abs _0 -> _0
let (uu___is_Tm_arrow : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_arrow _0 -> true | uu____1954 -> false
let (__proj__Tm_arrow__item___0 :
  term' ->
    ((bv * arg_qualifier FStar_Pervasives_Native.option) Prims.list * comp'
      syntax))
  = fun projectee -> match projectee with | Tm_arrow _0 -> _0
let (uu___is_Tm_refine : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_refine _0 -> true | uu____2021 -> false
let (__proj__Tm_refine__item___0 : term' -> (bv * term' syntax)) =
  fun projectee -> match projectee with | Tm_refine _0 -> _0
let (uu___is_Tm_app : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_app _0 -> true | uu____2074 -> false
let (__proj__Tm_app__item___0 :
  term' ->
    (term' syntax * (term' syntax * arg_qualifier
      FStar_Pervasives_Native.option) Prims.list))
  = fun projectee -> match projectee with | Tm_app _0 -> _0
let (uu___is_Tm_match : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_match _0 -> true | uu____2163 -> false
let (__proj__Tm_match__item___0 :
  term' ->
    (term' syntax * (pat' withinfo_t * term' syntax
      FStar_Pervasives_Native.option * term' syntax) Prims.list))
  = fun projectee -> match projectee with | Tm_match _0 -> _0
let (uu___is_Tm_ascribed : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_ascribed _0 -> true | uu____2274 -> false
let (__proj__Tm_ascribed__item___0 :
  term' ->
    (term' syntax * ((term' syntax, comp' syntax) FStar_Util.either * term'
      syntax FStar_Pervasives_Native.option) * FStar_Ident.lident
      FStar_Pervasives_Native.option))
  = fun projectee -> match projectee with | Tm_ascribed _0 -> _0
let (uu___is_Tm_let : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_let _0 -> true | uu____2384 -> false
let (__proj__Tm_let__item___0 :
  term' -> ((Prims.bool * letbinding Prims.list) * term' syntax)) =
  fun projectee -> match projectee with | Tm_let _0 -> _0
let (uu___is_Tm_uvar : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_uvar _0 -> true | uu____2454 -> false
let (__proj__Tm_uvar__item___0 :
  term' ->
    (ctx_uvar * (subst_elt Prims.list Prims.list * maybe_set_use_range)))
  = fun projectee -> match projectee with | Tm_uvar _0 -> _0
let (uu___is_Tm_delayed : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_delayed _0 -> true | uu____2523 -> false
let (__proj__Tm_delayed__item___0 :
  term' ->
    (term' syntax * (subst_elt Prims.list Prims.list * maybe_set_use_range)))
  = fun projectee -> match projectee with | Tm_delayed _0 -> _0
let (uu___is_Tm_meta : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_meta _0 -> true | uu____2590 -> false
let (__proj__Tm_meta__item___0 : term' -> (term' syntax * metadata)) =
  fun projectee -> match projectee with | Tm_meta _0 -> _0
let (uu___is_Tm_lazy : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_lazy _0 -> true | uu____2627 -> false
let (__proj__Tm_lazy__item___0 : term' -> lazyinfo) =
  fun projectee -> match projectee with | Tm_lazy _0 -> _0
let (uu___is_Tm_quoted : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_quoted _0 -> true | uu____2652 -> false
let (__proj__Tm_quoted__item___0 : term' -> (term' syntax * quoteinfo)) =
  fun projectee -> match projectee with | Tm_quoted _0 -> _0
let (uu___is_Tm_unknown : term' -> Prims.bool) =
  fun projectee ->
    match projectee with | Tm_unknown -> true | uu____2688 -> false
let (__proj__Mkctx_uvar__item__ctx_uvar_head :
  ctx_uvar ->
    (term' syntax FStar_Pervasives_Native.option FStar_Unionfind.p_uvar *
      version * FStar_Range.range))
  =
  fun projectee ->
    match projectee with
    | { ctx_uvar_head; ctx_uvar_gamma; ctx_uvar_binders; ctx_uvar_typ;
        ctx_uvar_reason; ctx_uvar_should_check; ctx_uvar_range;
        ctx_uvar_meta;_} -> ctx_uvar_head
let (__proj__Mkctx_uvar__item__ctx_uvar_gamma :
  ctx_uvar -> binding Prims.list) =
  fun projectee ->
    match projectee with
    | { ctx_uvar_head; ctx_uvar_gamma; ctx_uvar_binders; ctx_uvar_typ;
        ctx_uvar_reason; ctx_uvar_should_check; ctx_uvar_range;
        ctx_uvar_meta;_} -> ctx_uvar_gamma
let (__proj__Mkctx_uvar__item__ctx_uvar_binders :
  ctx_uvar -> (bv * arg_qualifier FStar_Pervasives_Native.option) Prims.list)
  =
  fun projectee ->
    match projectee with
    | { ctx_uvar_head; ctx_uvar_gamma; ctx_uvar_binders; ctx_uvar_typ;
        ctx_uvar_reason; ctx_uvar_should_check; ctx_uvar_range;
        ctx_uvar_meta;_} -> ctx_uvar_binders
let (__proj__Mkctx_uvar__item__ctx_uvar_typ : ctx_uvar -> term' syntax) =
  fun projectee ->
    match projectee with
    | { ctx_uvar_head; ctx_uvar_gamma; ctx_uvar_binders; ctx_uvar_typ;
        ctx_uvar_reason; ctx_uvar_should_check; ctx_uvar_range;
        ctx_uvar_meta;_} -> ctx_uvar_typ
let (__proj__Mkctx_uvar__item__ctx_uvar_reason : ctx_uvar -> Prims.string) =
  fun projectee ->
    match projectee with
    | { ctx_uvar_head; ctx_uvar_gamma; ctx_uvar_binders; ctx_uvar_typ;
        ctx_uvar_reason; ctx_uvar_should_check; ctx_uvar_range;
        ctx_uvar_meta;_} -> ctx_uvar_reason
let (__proj__Mkctx_uvar__item__ctx_uvar_should_check :
  ctx_uvar -> should_check_uvar) =
  fun projectee ->
    match projectee with
    | { ctx_uvar_head; ctx_uvar_gamma; ctx_uvar_binders; ctx_uvar_typ;
        ctx_uvar_reason; ctx_uvar_should_check; ctx_uvar_range;
        ctx_uvar_meta;_} -> ctx_uvar_should_check
let (__proj__Mkctx_uvar__item__ctx_uvar_range :
  ctx_uvar -> FStar_Range.range) =
  fun projectee ->
    match projectee with
    | { ctx_uvar_head; ctx_uvar_gamma; ctx_uvar_binders; ctx_uvar_typ;
        ctx_uvar_reason; ctx_uvar_should_check; ctx_uvar_range;
        ctx_uvar_meta;_} -> ctx_uvar_range
let (__proj__Mkctx_uvar__item__ctx_uvar_meta :
  ctx_uvar -> ctx_uvar_meta_t FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with
    | { ctx_uvar_head; ctx_uvar_gamma; ctx_uvar_binders; ctx_uvar_typ;
        ctx_uvar_reason; ctx_uvar_should_check; ctx_uvar_range;
        ctx_uvar_meta;_} -> ctx_uvar_meta
let (uu___is_Ctx_uvar_meta_tac : ctx_uvar_meta_t -> Prims.bool) =
  fun projectee ->
    match projectee with | Ctx_uvar_meta_tac _0 -> true | uu____3088 -> false
let (__proj__Ctx_uvar_meta_tac__item___0 :
  ctx_uvar_meta_t -> (FStar_Dyn.dyn * term' syntax)) =
  fun projectee -> match projectee with | Ctx_uvar_meta_tac _0 -> _0
let (uu___is_Ctx_uvar_meta_attr : ctx_uvar_meta_t -> Prims.bool) =
  fun projectee ->
    match projectee with
    | Ctx_uvar_meta_attr _0 -> true
    | uu____3127 -> false
let (__proj__Ctx_uvar_meta_attr__item___0 : ctx_uvar_meta_t -> term' syntax)
  = fun projectee -> match projectee with | Ctx_uvar_meta_attr _0 -> _0
let (uu___is_Pat_constant : pat' -> Prims.bool) =
  fun projectee ->
    match projectee with | Pat_constant _0 -> true | uu____3152 -> false
let (__proj__Pat_constant__item___0 : pat' -> sconst) =
  fun projectee -> match projectee with | Pat_constant _0 -> _0
let (uu___is_Pat_cons : pat' -> Prims.bool) =
  fun projectee ->
    match projectee with | Pat_cons _0 -> true | uu____3184 -> false
let (__proj__Pat_cons__item___0 :
  pat' -> (fv * (pat' withinfo_t * Prims.bool) Prims.list)) =
  fun projectee -> match projectee with | Pat_cons _0 -> _0
let (uu___is_Pat_var : pat' -> Prims.bool) =
  fun projectee ->
    match projectee with | Pat_var _0 -> true | uu____3242 -> false
let (__proj__Pat_var__item___0 : pat' -> bv) =
  fun projectee -> match projectee with | Pat_var _0 -> _0
let (uu___is_Pat_wild : pat' -> Prims.bool) =
  fun projectee ->
    match projectee with | Pat_wild _0 -> true | uu____3261 -> false
let (__proj__Pat_wild__item___0 : pat' -> bv) =
  fun projectee -> match projectee with | Pat_wild _0 -> _0
let (uu___is_Pat_dot_term : pat' -> Prims.bool) =
  fun projectee ->
    match projectee with | Pat_dot_term _0 -> true | uu____3286 -> false
let (__proj__Pat_dot_term__item___0 : pat' -> (bv * term' syntax)) =
  fun projectee -> match projectee with | Pat_dot_term _0 -> _0
let (__proj__Mkletbinding__item__lbname :
  letbinding -> (bv, fv) FStar_Util.either) =
  fun projectee ->
    match projectee with
    | { lbname; lbunivs; lbtyp; lbeff; lbdef; lbattrs; lbpos;_} -> lbname
let (__proj__Mkletbinding__item__lbunivs :
  letbinding -> univ_name Prims.list) =
  fun projectee ->
    match projectee with
    | { lbname; lbunivs; lbtyp; lbeff; lbdef; lbattrs; lbpos;_} -> lbunivs
let (__proj__Mkletbinding__item__lbtyp : letbinding -> term' syntax) =
  fun projectee ->
    match projectee with
    | { lbname; lbunivs; lbtyp; lbeff; lbdef; lbattrs; lbpos;_} -> lbtyp
let (__proj__Mkletbinding__item__lbeff : letbinding -> FStar_Ident.lident) =
  fun projectee ->
    match projectee with
    | { lbname; lbunivs; lbtyp; lbeff; lbdef; lbattrs; lbpos;_} -> lbeff
let (__proj__Mkletbinding__item__lbdef : letbinding -> term' syntax) =
  fun projectee ->
    match projectee with
    | { lbname; lbunivs; lbtyp; lbeff; lbdef; lbattrs; lbpos;_} -> lbdef
let (__proj__Mkletbinding__item__lbattrs :
  letbinding -> term' syntax Prims.list) =
  fun projectee ->
    match projectee with
    | { lbname; lbunivs; lbtyp; lbeff; lbdef; lbattrs; lbpos;_} -> lbattrs
let (__proj__Mkletbinding__item__lbpos : letbinding -> FStar_Range.range) =
  fun projectee ->
    match projectee with
    | { lbname; lbunivs; lbtyp; lbeff; lbdef; lbattrs; lbpos;_} -> lbpos
let (__proj__Mkquoteinfo__item__qkind : quoteinfo -> quote_kind) =
  fun projectee -> match projectee with | { qkind; antiquotes;_} -> qkind
let (__proj__Mkquoteinfo__item__antiquotes :
  quoteinfo -> (bv * term' syntax) Prims.list) =
  fun projectee ->
    match projectee with | { qkind; antiquotes;_} -> antiquotes
let (__proj__Mkcomp_typ__item__comp_univs : comp_typ -> universes) =
  fun projectee ->
    match projectee with
    | { comp_univs; effect_name; result_typ; effect_args; flags;_} ->
        comp_univs
let (__proj__Mkcomp_typ__item__effect_name : comp_typ -> FStar_Ident.lident)
  =
  fun projectee ->
    match projectee with
    | { comp_univs; effect_name; result_typ; effect_args; flags;_} ->
        effect_name
let (__proj__Mkcomp_typ__item__result_typ : comp_typ -> term' syntax) =
  fun projectee ->
    match projectee with
    | { comp_univs; effect_name; result_typ; effect_args; flags;_} ->
        result_typ
let (__proj__Mkcomp_typ__item__effect_args :
  comp_typ ->
    (term' syntax * arg_qualifier FStar_Pervasives_Native.option) Prims.list)
  =
  fun projectee ->
    match projectee with
    | { comp_univs; effect_name; result_typ; effect_args; flags;_} ->
        effect_args
let (__proj__Mkcomp_typ__item__flags : comp_typ -> cflag Prims.list) =
  fun projectee ->
    match projectee with
    | { comp_univs; effect_name; result_typ; effect_args; flags;_} -> flags
let (uu___is_Total : comp' -> Prims.bool) =
  fun projectee ->
    match projectee with | Total _0 -> true | uu____3749 -> false
let (__proj__Total__item___0 :
  comp' -> (term' syntax * universe FStar_Pervasives_Native.option)) =
  fun projectee -> match projectee with | Total _0 -> _0
let (uu___is_GTotal : comp' -> Prims.bool) =
  fun projectee ->
    match projectee with | GTotal _0 -> true | uu____3800 -> false
let (__proj__GTotal__item___0 :
  comp' -> (term' syntax * universe FStar_Pervasives_Native.option)) =
  fun projectee -> match projectee with | GTotal _0 -> _0
let (uu___is_Comp : comp' -> Prims.bool) =
  fun projectee ->
    match projectee with | Comp _0 -> true | uu____3843 -> false
let (__proj__Comp__item___0 : comp' -> comp_typ) =
  fun projectee -> match projectee with | Comp _0 -> _0
let (uu___is_TOTAL : cflag -> Prims.bool) =
  fun projectee -> match projectee with | TOTAL -> true | uu____3861 -> false
let (uu___is_MLEFFECT : cflag -> Prims.bool) =
  fun projectee ->
    match projectee with | MLEFFECT -> true | uu____3872 -> false
let (uu___is_LEMMA : cflag -> Prims.bool) =
  fun projectee -> match projectee with | LEMMA -> true | uu____3883 -> false
let (uu___is_RETURN : cflag -> Prims.bool) =
  fun projectee ->
    match projectee with | RETURN -> true | uu____3894 -> false
let (uu___is_PARTIAL_RETURN : cflag -> Prims.bool) =
  fun projectee ->
    match projectee with | PARTIAL_RETURN -> true | uu____3905 -> false
let (uu___is_SOMETRIVIAL : cflag -> Prims.bool) =
  fun projectee ->
    match projectee with | SOMETRIVIAL -> true | uu____3916 -> false
let (uu___is_TRIVIAL_POSTCONDITION : cflag -> Prims.bool) =
  fun projectee ->
    match projectee with
    | TRIVIAL_POSTCONDITION -> true
    | uu____3927 -> false
let (uu___is_SHOULD_NOT_INLINE : cflag -> Prims.bool) =
  fun projectee ->
    match projectee with | SHOULD_NOT_INLINE -> true | uu____3938 -> false
let (uu___is_CPS : cflag -> Prims.bool) =
  fun projectee -> match projectee with | CPS -> true | uu____3949 -> false
let (uu___is_DECREASES : cflag -> Prims.bool) =
  fun projectee ->
    match projectee with | DECREASES _0 -> true | uu____3963 -> false
let (__proj__DECREASES__item___0 : cflag -> term' syntax) =
  fun projectee -> match projectee with | DECREASES _0 -> _0
let (uu___is_Meta_pattern : metadata -> Prims.bool) =
  fun projectee ->
    match projectee with | Meta_pattern _0 -> true | uu____4008 -> false
let (__proj__Meta_pattern__item___0 :
  metadata ->
    (term' syntax Prims.list * (term' syntax * arg_qualifier
      FStar_Pervasives_Native.option) Prims.list Prims.list))
  = fun projectee -> match projectee with | Meta_pattern _0 -> _0
let (uu___is_Meta_named : metadata -> Prims.bool) =
  fun projectee ->
    match projectee with | Meta_named _0 -> true | uu____4087 -> false
let (__proj__Meta_named__item___0 : metadata -> FStar_Ident.lident) =
  fun projectee -> match projectee with | Meta_named _0 -> _0
let (uu___is_Meta_labeled : metadata -> Prims.bool) =
  fun projectee ->
    match projectee with | Meta_labeled _0 -> true | uu____4114 -> false
let (__proj__Meta_labeled__item___0 :
  metadata -> (Prims.string * FStar_Range.range * Prims.bool)) =
  fun projectee -> match projectee with | Meta_labeled _0 -> _0
let (uu___is_Meta_desugared : metadata -> Prims.bool) =
  fun projectee ->
    match projectee with | Meta_desugared _0 -> true | uu____4157 -> false
let (__proj__Meta_desugared__item___0 : metadata -> meta_source_info) =
  fun projectee -> match projectee with | Meta_desugared _0 -> _0
let (uu___is_Meta_monadic : metadata -> Prims.bool) =
  fun projectee ->
    match projectee with | Meta_monadic _0 -> true | uu____4182 -> false
let (__proj__Meta_monadic__item___0 :
  metadata -> (monad_name * term' syntax)) =
  fun projectee -> match projectee with | Meta_monadic _0 -> _0
let (uu___is_Meta_monadic_lift : metadata -> Prims.bool) =
  fun projectee ->
    match projectee with | Meta_monadic_lift _0 -> true | uu____4227 -> false
let (__proj__Meta_monadic_lift__item___0 :
  metadata -> (monad_name * monad_name * term' syntax)) =
  fun projectee -> match projectee with | Meta_monadic_lift _0 -> _0
let (uu___is_Sequence : meta_source_info -> Prims.bool) =
  fun projectee ->
    match projectee with | Sequence -> true | uu____4269 -> false
let (uu___is_Primop : meta_source_info -> Prims.bool) =
  fun projectee ->
    match projectee with | Primop -> true | uu____4280 -> false
let (uu___is_Masked_effect : meta_source_info -> Prims.bool) =
  fun projectee ->
    match projectee with | Masked_effect -> true | uu____4291 -> false
let (uu___is_Meta_smt_pat : meta_source_info -> Prims.bool) =
  fun projectee ->
    match projectee with | Meta_smt_pat -> true | uu____4302 -> false
let (uu___is_Data_ctor : fv_qual -> Prims.bool) =
  fun projectee ->
    match projectee with | Data_ctor -> true | uu____4313 -> false
let (uu___is_Record_projector : fv_qual -> Prims.bool) =
  fun projectee ->
    match projectee with | Record_projector _0 -> true | uu____4329 -> false
let (__proj__Record_projector__item___0 :
  fv_qual -> (FStar_Ident.lident * FStar_Ident.ident)) =
  fun projectee -> match projectee with | Record_projector _0 -> _0
let (uu___is_Record_ctor : fv_qual -> Prims.bool) =
  fun projectee ->
    match projectee with | Record_ctor _0 -> true | uu____4366 -> false
let (__proj__Record_ctor__item___0 :
  fv_qual -> (FStar_Ident.lident * FStar_Ident.ident Prims.list)) =
  fun projectee -> match projectee with | Record_ctor _0 -> _0
let (uu___is_DB : subst_elt -> Prims.bool) =
  fun projectee -> match projectee with | DB _0 -> true | uu____4408 -> false
let (__proj__DB__item___0 : subst_elt -> (Prims.int * bv)) =
  fun projectee -> match projectee with | DB _0 -> _0
let (uu___is_NM : subst_elt -> Prims.bool) =
  fun projectee -> match projectee with | NM _0 -> true | uu____4447 -> false
let (__proj__NM__item___0 : subst_elt -> (bv * Prims.int)) =
  fun projectee -> match projectee with | NM _0 -> _0
let (uu___is_NT : subst_elt -> Prims.bool) =
  fun projectee -> match projectee with | NT _0 -> true | uu____4487 -> false
let (__proj__NT__item___0 : subst_elt -> (bv * term' syntax)) =
  fun projectee -> match projectee with | NT _0 -> _0
let (uu___is_UN : subst_elt -> Prims.bool) =
  fun projectee -> match projectee with | UN _0 -> true | uu____4529 -> false
let (__proj__UN__item___0 : subst_elt -> (Prims.int * universe)) =
  fun projectee -> match projectee with | UN _0 -> _0
let (uu___is_UD : subst_elt -> Prims.bool) =
  fun projectee -> match projectee with | UD _0 -> true | uu____4568 -> false
let (__proj__UD__item___0 : subst_elt -> (univ_name * Prims.int)) =
  fun projectee -> match projectee with | UD _0 -> _0
let __proj__Mksyntax__item__n : 'a . 'a syntax -> 'a =
  fun projectee -> match projectee with | { n; pos; vars;_} -> n
let __proj__Mksyntax__item__pos : 'a . 'a syntax -> FStar_Range.range =
  fun projectee -> match projectee with | { n; pos; vars;_} -> pos
let __proj__Mksyntax__item__vars : 'a . 'a syntax -> free_vars memo =
  fun projectee -> match projectee with | { n; pos; vars;_} -> vars
let (__proj__Mkbv__item__ppname : bv -> FStar_Ident.ident) =
  fun projectee -> match projectee with | { ppname; index; sort;_} -> ppname
let (__proj__Mkbv__item__index : bv -> Prims.int) =
  fun projectee -> match projectee with | { ppname; index; sort;_} -> index
let (__proj__Mkbv__item__sort : bv -> term' syntax) =
  fun projectee -> match projectee with | { ppname; index; sort;_} -> sort
let (__proj__Mkfv__item__fv_name : fv -> var) =
  fun projectee ->
    match projectee with
    | { fv_name; fv_delta; fv_qual = fv_qual1;_} -> fv_name
let (__proj__Mkfv__item__fv_delta : fv -> delta_depth) =
  fun projectee ->
    match projectee with
    | { fv_name; fv_delta; fv_qual = fv_qual1;_} -> fv_delta
let (__proj__Mkfv__item__fv_qual :
  fv -> fv_qual FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with
    | { fv_name; fv_delta; fv_qual = fv_qual1;_} -> fv_qual1
let (__proj__Mkfree_vars__item__free_names : free_vars -> bv Prims.list) =
  fun projectee ->
    match projectee with
    | { free_names; free_uvars; free_univs; free_univ_names;_} -> free_names
let (__proj__Mkfree_vars__item__free_uvars :
  free_vars -> ctx_uvar Prims.list) =
  fun projectee ->
    match projectee with
    | { free_names; free_uvars; free_univs; free_univ_names;_} -> free_uvars
let (__proj__Mkfree_vars__item__free_univs :
  free_vars -> universe_uvar Prims.list) =
  fun projectee ->
    match projectee with
    | { free_names; free_uvars; free_univs; free_univ_names;_} -> free_univs
let (__proj__Mkfree_vars__item__free_univ_names :
  free_vars -> univ_name Prims.list) =
  fun projectee ->
    match projectee with
    | { free_names; free_uvars; free_univs; free_univ_names;_} ->
        free_univ_names
let (__proj__Mkresidual_comp__item__residual_effect :
  residual_comp -> FStar_Ident.lident) =
  fun projectee ->
    match projectee with
    | { residual_effect; residual_typ; residual_flags;_} -> residual_effect
let (__proj__Mkresidual_comp__item__residual_typ :
  residual_comp -> term' syntax FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with
    | { residual_effect; residual_typ; residual_flags;_} -> residual_typ
let (__proj__Mkresidual_comp__item__residual_flags :
  residual_comp -> cflag Prims.list) =
  fun projectee ->
    match projectee with
    | { residual_effect; residual_typ; residual_flags;_} -> residual_flags
let (__proj__Mklazyinfo__item__blob : lazyinfo -> FStar_Dyn.dyn) =
  fun projectee -> match projectee with | { blob; lkind; ltyp; rng;_} -> blob
let (__proj__Mklazyinfo__item__lkind : lazyinfo -> lazy_kind) =
  fun projectee ->
    match projectee with | { blob; lkind; ltyp; rng;_} -> lkind
let (__proj__Mklazyinfo__item__ltyp : lazyinfo -> term' syntax) =
  fun projectee -> match projectee with | { blob; lkind; ltyp; rng;_} -> ltyp
let (__proj__Mklazyinfo__item__rng : lazyinfo -> FStar_Range.range) =
  fun projectee -> match projectee with | { blob; lkind; ltyp; rng;_} -> rng
let (uu___is_BadLazy : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | BadLazy -> true | uu____4939 -> false
let (uu___is_Lazy_bv : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_bv -> true | uu____4950 -> false
let (uu___is_Lazy_binder : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_binder -> true | uu____4961 -> false
let (uu___is_Lazy_optionstate : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_optionstate -> true | uu____4972 -> false
let (uu___is_Lazy_fvar : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_fvar -> true | uu____4983 -> false
let (uu___is_Lazy_comp : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_comp -> true | uu____4994 -> false
let (uu___is_Lazy_env : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_env -> true | uu____5005 -> false
let (uu___is_Lazy_proofstate : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_proofstate -> true | uu____5016 -> false
let (uu___is_Lazy_goal : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_goal -> true | uu____5027 -> false
let (uu___is_Lazy_sigelt : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_sigelt -> true | uu____5038 -> false
let (uu___is_Lazy_uvar : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_uvar -> true | uu____5049 -> false
let (uu___is_Lazy_embedding : lazy_kind -> Prims.bool) =
  fun projectee ->
    match projectee with | Lazy_embedding _0 -> true | uu____5069 -> false
let (__proj__Lazy_embedding__item___0 :
  lazy_kind -> (emb_typ * term' syntax FStar_Thunk.t)) =
  fun projectee -> match projectee with | Lazy_embedding _0 -> _0
let (uu___is_Binding_var : binding -> Prims.bool) =
  fun projectee ->
    match projectee with | Binding_var _0 -> true | uu____5112 -> false
let (__proj__Binding_var__item___0 : binding -> bv) =
  fun projectee -> match projectee with | Binding_var _0 -> _0
let (uu___is_Binding_lid : binding -> Prims.bool) =
  fun projectee ->
    match projectee with | Binding_lid _0 -> true | uu____5143 -> false
let (__proj__Binding_lid__item___0 :
  binding -> (FStar_Ident.lident * (univ_name Prims.list * term' syntax))) =
  fun projectee -> match projectee with | Binding_lid _0 -> _0
let (uu___is_Binding_univ : binding -> Prims.bool) =
  fun projectee ->
    match projectee with | Binding_univ _0 -> true | uu____5198 -> false
let (__proj__Binding_univ__item___0 : binding -> univ_name) =
  fun projectee -> match projectee with | Binding_univ _0 -> _0
let (uu___is_Implicit : arg_qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Implicit _0 -> true | uu____5218 -> false
let (__proj__Implicit__item___0 : arg_qualifier -> Prims.bool) =
  fun projectee -> match projectee with | Implicit _0 -> _0
let (uu___is_Meta : arg_qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Meta _0 -> true | uu____5240 -> false
let (__proj__Meta__item___0 : arg_qualifier -> arg_qualifier_meta_t) =
  fun projectee -> match projectee with | Meta _0 -> _0
let (uu___is_Equality : arg_qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Equality -> true | uu____5258 -> false
let (uu___is_Arg_qualifier_meta_tac : arg_qualifier_meta_t -> Prims.bool) =
  fun projectee ->
    match projectee with
    | Arg_qualifier_meta_tac _0 -> true
    | uu____5272 -> false
let (__proj__Arg_qualifier_meta_tac__item___0 :
  arg_qualifier_meta_t -> term' syntax) =
  fun projectee -> match projectee with | Arg_qualifier_meta_tac _0 -> _0
let (uu___is_Arg_qualifier_meta_attr : arg_qualifier_meta_t -> Prims.bool) =
  fun projectee ->
    match projectee with
    | Arg_qualifier_meta_attr _0 -> true
    | uu____5299 -> false
let (__proj__Arg_qualifier_meta_attr__item___0 :
  arg_qualifier_meta_t -> term' syntax) =
  fun projectee -> match projectee with | Arg_qualifier_meta_attr _0 -> _0
type subst_ts = (subst_elt Prims.list Prims.list * maybe_set_use_range)
type ctx_uvar_and_subst =
  (ctx_uvar * (subst_elt Prims.list Prims.list * maybe_set_use_range))
type term = term' syntax
type uvar =
  (term' syntax FStar_Pervasives_Native.option FStar_Unionfind.p_uvar *
    version * FStar_Range.range)
type uvars = ctx_uvar FStar_Util.set
type pat = pat' withinfo_t
type branch =
  (pat' withinfo_t * term' syntax FStar_Pervasives_Native.option * term'
    syntax)
type comp = comp' syntax
type ascription =
  ((term' syntax, comp' syntax) FStar_Util.either * term' syntax
    FStar_Pervasives_Native.option)
type antiquotations = (bv * term' syntax) Prims.list
type typ = term' syntax
type aqual = arg_qualifier FStar_Pervasives_Native.option
type arg = (term' syntax * arg_qualifier FStar_Pervasives_Native.option)
type args =
  (term' syntax * arg_qualifier FStar_Pervasives_Native.option) Prims.list
type binder = (bv * arg_qualifier FStar_Pervasives_Native.option)
type binders = (bv * arg_qualifier FStar_Pervasives_Native.option) Prims.list
type lbname = (bv, fv) FStar_Util.either
type letbindings = (Prims.bool * letbinding Prims.list)
type freenames = bv FStar_Util.set
type attribute = term' syntax
type tscheme = (univ_name Prims.list * term' syntax)
type gamma = binding Prims.list
let (lazy_chooser :
  (lazy_kind -> lazyinfo -> term) FStar_Pervasives_Native.option FStar_ST.ref)
  = FStar_Util.mk_ref FStar_Pervasives_Native.None
type freenames_l = bv Prims.list
type formula = typ
type formulae = typ Prims.list
type qualifier =
  | Assumption 
  | New 
  | Private 
  | Unfold_for_unification_and_vcgen 
  | Visible_default 
  | Irreducible 
  | Abstract 
  | Inline_for_extraction 
  | NoExtract 
  | Noeq 
  | Unopteq 
  | TotalEffect 
  | Logic 
  | Reifiable 
  | Reflectable of FStar_Ident.lident 
  | Discriminator of FStar_Ident.lident 
  | Projector of (FStar_Ident.lident * FStar_Ident.ident) 
  | RecordType of (FStar_Ident.ident Prims.list * FStar_Ident.ident
  Prims.list) 
  | RecordConstructor of (FStar_Ident.ident Prims.list * FStar_Ident.ident
  Prims.list) 
  | Action of FStar_Ident.lident 
  | ExceptionConstructor 
  | HasMaskedEffect 
  | Effect 
  | OnlyName 
let (uu___is_Assumption : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Assumption -> true | uu____5551 -> false
let (uu___is_New : qualifier -> Prims.bool) =
  fun projectee -> match projectee with | New -> true | uu____5562 -> false
let (uu___is_Private : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Private -> true | uu____5573 -> false
let (uu___is_Unfold_for_unification_and_vcgen : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with
    | Unfold_for_unification_and_vcgen -> true
    | uu____5584 -> false
let (uu___is_Visible_default : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Visible_default -> true | uu____5595 -> false
let (uu___is_Irreducible : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Irreducible -> true | uu____5606 -> false
let (uu___is_Abstract : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Abstract -> true | uu____5617 -> false
let (uu___is_Inline_for_extraction : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with
    | Inline_for_extraction -> true
    | uu____5628 -> false
let (uu___is_NoExtract : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | NoExtract -> true | uu____5639 -> false
let (uu___is_Noeq : qualifier -> Prims.bool) =
  fun projectee -> match projectee with | Noeq -> true | uu____5650 -> false
let (uu___is_Unopteq : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Unopteq -> true | uu____5661 -> false
let (uu___is_TotalEffect : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | TotalEffect -> true | uu____5672 -> false
let (uu___is_Logic : qualifier -> Prims.bool) =
  fun projectee -> match projectee with | Logic -> true | uu____5683 -> false
let (uu___is_Reifiable : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Reifiable -> true | uu____5694 -> false
let (uu___is_Reflectable : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Reflectable _0 -> true | uu____5706 -> false
let (__proj__Reflectable__item___0 : qualifier -> FStar_Ident.lident) =
  fun projectee -> match projectee with | Reflectable _0 -> _0
let (uu___is_Discriminator : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Discriminator _0 -> true | uu____5725 -> false
let (__proj__Discriminator__item___0 : qualifier -> FStar_Ident.lident) =
  fun projectee -> match projectee with | Discriminator _0 -> _0
let (uu___is_Projector : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Projector _0 -> true | uu____5748 -> false
let (__proj__Projector__item___0 :
  qualifier -> (FStar_Ident.lident * FStar_Ident.ident)) =
  fun projectee -> match projectee with | Projector _0 -> _0
let (uu___is_RecordType : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | RecordType _0 -> true | uu____5787 -> false
let (__proj__RecordType__item___0 :
  qualifier -> (FStar_Ident.ident Prims.list * FStar_Ident.ident Prims.list))
  = fun projectee -> match projectee with | RecordType _0 -> _0
let (uu___is_RecordConstructor : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | RecordConstructor _0 -> true | uu____5838 -> false
let (__proj__RecordConstructor__item___0 :
  qualifier -> (FStar_Ident.ident Prims.list * FStar_Ident.ident Prims.list))
  = fun projectee -> match projectee with | RecordConstructor _0 -> _0
let (uu___is_Action : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Action _0 -> true | uu____5881 -> false
let (__proj__Action__item___0 : qualifier -> FStar_Ident.lident) =
  fun projectee -> match projectee with | Action _0 -> _0
let (uu___is_ExceptionConstructor : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | ExceptionConstructor -> true | uu____5899 -> false
let (uu___is_HasMaskedEffect : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | HasMaskedEffect -> true | uu____5910 -> false
let (uu___is_Effect : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | Effect -> true | uu____5921 -> false
let (uu___is_OnlyName : qualifier -> Prims.bool) =
  fun projectee ->
    match projectee with | OnlyName -> true | uu____5932 -> false
type tycon = (FStar_Ident.lident * binders * typ)
type monad_abbrev = {
  mabbrev: FStar_Ident.lident ;
  parms: binders ;
  def: typ }
let (__proj__Mkmonad_abbrev__item__mabbrev :
  monad_abbrev -> FStar_Ident.lident) =
  fun projectee -> match projectee with | { mabbrev; parms; def;_} -> mabbrev
let (__proj__Mkmonad_abbrev__item__parms : monad_abbrev -> binders) =
  fun projectee -> match projectee with | { mabbrev; parms; def;_} -> parms
let (__proj__Mkmonad_abbrev__item__def : monad_abbrev -> typ) =
  fun projectee -> match projectee with | { mabbrev; parms; def;_} -> def
type sub_eff =
  {
  source: FStar_Ident.lident ;
  target: FStar_Ident.lident ;
  lift_wp: tscheme FStar_Pervasives_Native.option ;
  lift: tscheme FStar_Pervasives_Native.option }
let (__proj__Mksub_eff__item__source : sub_eff -> FStar_Ident.lident) =
  fun projectee ->
    match projectee with | { source; target; lift_wp; lift;_} -> source
let (__proj__Mksub_eff__item__target : sub_eff -> FStar_Ident.lident) =
  fun projectee ->
    match projectee with | { source; target; lift_wp; lift;_} -> target
let (__proj__Mksub_eff__item__lift_wp :
  sub_eff -> tscheme FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with | { source; target; lift_wp; lift;_} -> lift_wp
let (__proj__Mksub_eff__item__lift :
  sub_eff -> tscheme FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with | { source; target; lift_wp; lift;_} -> lift
type action =
  {
  action_name: FStar_Ident.lident ;
  action_unqualified_name: FStar_Ident.ident ;
  action_univs: univ_names ;
  action_params: binders ;
  action_defn: term ;
  action_typ: typ }
let (__proj__Mkaction__item__action_name : action -> FStar_Ident.lident) =
  fun projectee ->
    match projectee with
    | { action_name; action_unqualified_name; action_univs; action_params;
        action_defn; action_typ;_} -> action_name
let (__proj__Mkaction__item__action_unqualified_name :
  action -> FStar_Ident.ident) =
  fun projectee ->
    match projectee with
    | { action_name; action_unqualified_name; action_univs; action_params;
        action_defn; action_typ;_} -> action_unqualified_name
let (__proj__Mkaction__item__action_univs : action -> univ_names) =
  fun projectee ->
    match projectee with
    | { action_name; action_unqualified_name; action_univs; action_params;
        action_defn; action_typ;_} -> action_univs
let (__proj__Mkaction__item__action_params : action -> binders) =
  fun projectee ->
    match projectee with
    | { action_name; action_unqualified_name; action_univs; action_params;
        action_defn; action_typ;_} -> action_params
let (__proj__Mkaction__item__action_defn : action -> term) =
  fun projectee ->
    match projectee with
    | { action_name; action_unqualified_name; action_univs; action_params;
        action_defn; action_typ;_} -> action_defn
let (__proj__Mkaction__item__action_typ : action -> typ) =
  fun projectee ->
    match projectee with
    | { action_name; action_unqualified_name; action_univs; action_params;
        action_defn; action_typ;_} -> action_typ
type wp_eff_combinators =
  {
  ret_wp: tscheme ;
  bind_wp: tscheme ;
  stronger: tscheme ;
  if_then_else: tscheme ;
  ite_wp: tscheme ;
  close_wp: tscheme ;
  trivial: tscheme ;
  repr: tscheme FStar_Pervasives_Native.option ;
  return_repr: tscheme FStar_Pervasives_Native.option ;
  bind_repr: tscheme FStar_Pervasives_Native.option }
let (__proj__Mkwp_eff_combinators__item__ret_wp :
  wp_eff_combinators -> tscheme) =
  fun projectee ->
    match projectee with
    | { ret_wp; bind_wp; stronger; if_then_else; ite_wp; close_wp; trivial;
        repr; return_repr; bind_repr;_} -> ret_wp
let (__proj__Mkwp_eff_combinators__item__bind_wp :
  wp_eff_combinators -> tscheme) =
  fun projectee ->
    match projectee with
    | { ret_wp; bind_wp; stronger; if_then_else; ite_wp; close_wp; trivial;
        repr; return_repr; bind_repr;_} -> bind_wp
let (__proj__Mkwp_eff_combinators__item__stronger :
  wp_eff_combinators -> tscheme) =
  fun projectee ->
    match projectee with
    | { ret_wp; bind_wp; stronger; if_then_else; ite_wp; close_wp; trivial;
        repr; return_repr; bind_repr;_} -> stronger
let (__proj__Mkwp_eff_combinators__item__if_then_else :
  wp_eff_combinators -> tscheme) =
  fun projectee ->
    match projectee with
    | { ret_wp; bind_wp; stronger; if_then_else; ite_wp; close_wp; trivial;
        repr; return_repr; bind_repr;_} -> if_then_else
let (__proj__Mkwp_eff_combinators__item__ite_wp :
  wp_eff_combinators -> tscheme) =
  fun projectee ->
    match projectee with
    | { ret_wp; bind_wp; stronger; if_then_else; ite_wp; close_wp; trivial;
        repr; return_repr; bind_repr;_} -> ite_wp
let (__proj__Mkwp_eff_combinators__item__close_wp :
  wp_eff_combinators -> tscheme) =
  fun projectee ->
    match projectee with
    | { ret_wp; bind_wp; stronger; if_then_else; ite_wp; close_wp; trivial;
        repr; return_repr; bind_repr;_} -> close_wp
let (__proj__Mkwp_eff_combinators__item__trivial :
  wp_eff_combinators -> tscheme) =
  fun projectee ->
    match projectee with
    | { ret_wp; bind_wp; stronger; if_then_else; ite_wp; close_wp; trivial;
        repr; return_repr; bind_repr;_} -> trivial
let (__proj__Mkwp_eff_combinators__item__repr :
  wp_eff_combinators -> tscheme FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with
    | { ret_wp; bind_wp; stronger; if_then_else; ite_wp; close_wp; trivial;
        repr; return_repr; bind_repr;_} -> repr
let (__proj__Mkwp_eff_combinators__item__return_repr :
  wp_eff_combinators -> tscheme FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with
    | { ret_wp; bind_wp; stronger; if_then_else; ite_wp; close_wp; trivial;
        repr; return_repr; bind_repr;_} -> return_repr
let (__proj__Mkwp_eff_combinators__item__bind_repr :
  wp_eff_combinators -> tscheme FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with
    | { ret_wp; bind_wp; stronger; if_then_else; ite_wp; close_wp; trivial;
        repr; return_repr; bind_repr;_} -> bind_repr
type layered_eff_combinators =
  {
  l_repr: (tscheme * tscheme) ;
  l_return: (tscheme * tscheme) ;
  l_bind: (tscheme * tscheme) ;
  l_subcomp: (tscheme * tscheme) ;
  l_if_then_else: (tscheme * tscheme) }
let (__proj__Mklayered_eff_combinators__item__l_repr :
  layered_eff_combinators -> (tscheme * tscheme)) =
  fun projectee ->
    match projectee with
    | { l_repr; l_return; l_bind; l_subcomp; l_if_then_else;_} -> l_repr
let (__proj__Mklayered_eff_combinators__item__l_return :
  layered_eff_combinators -> (tscheme * tscheme)) =
  fun projectee ->
    match projectee with
    | { l_repr; l_return; l_bind; l_subcomp; l_if_then_else;_} -> l_return
let (__proj__Mklayered_eff_combinators__item__l_bind :
  layered_eff_combinators -> (tscheme * tscheme)) =
  fun projectee ->
    match projectee with
    | { l_repr; l_return; l_bind; l_subcomp; l_if_then_else;_} -> l_bind
let (__proj__Mklayered_eff_combinators__item__l_subcomp :
  layered_eff_combinators -> (tscheme * tscheme)) =
  fun projectee ->
    match projectee with
    | { l_repr; l_return; l_bind; l_subcomp; l_if_then_else;_} -> l_subcomp
let (__proj__Mklayered_eff_combinators__item__l_if_then_else :
  layered_eff_combinators -> (tscheme * tscheme)) =
  fun projectee ->
    match projectee with
    | { l_repr; l_return; l_bind; l_subcomp; l_if_then_else;_} ->
        l_if_then_else
type eff_combinators =
  | Primitive_eff of wp_eff_combinators 
  | DM4F_eff of wp_eff_combinators 
  | Layered_eff of layered_eff_combinators 
let (uu___is_Primitive_eff : eff_combinators -> Prims.bool) =
  fun projectee ->
    match projectee with | Primitive_eff _0 -> true | uu____6725 -> false
let (__proj__Primitive_eff__item___0 : eff_combinators -> wp_eff_combinators)
  = fun projectee -> match projectee with | Primitive_eff _0 -> _0
let (uu___is_DM4F_eff : eff_combinators -> Prims.bool) =
  fun projectee ->
    match projectee with | DM4F_eff _0 -> true | uu____6744 -> false
let (__proj__DM4F_eff__item___0 : eff_combinators -> wp_eff_combinators) =
  fun projectee -> match projectee with | DM4F_eff _0 -> _0
let (uu___is_Layered_eff : eff_combinators -> Prims.bool) =
  fun projectee ->
    match projectee with | Layered_eff _0 -> true | uu____6763 -> false
let (__proj__Layered_eff__item___0 :
  eff_combinators -> layered_eff_combinators) =
  fun projectee -> match projectee with | Layered_eff _0 -> _0
type eff_decl =
  {
  mname: FStar_Ident.lident ;
  cattributes: cflag Prims.list ;
  univs: univ_names ;
  binders: binders ;
  signature: tscheme ;
  combinators: eff_combinators ;
  actions: action Prims.list ;
  eff_attrs: attribute Prims.list }
let (__proj__Mkeff_decl__item__mname : eff_decl -> FStar_Ident.lident) =
  fun projectee ->
    match projectee with
    | { mname; cattributes; univs; binders = binders1; signature;
        combinators; actions; eff_attrs;_} -> mname
let (__proj__Mkeff_decl__item__cattributes : eff_decl -> cflag Prims.list) =
  fun projectee ->
    match projectee with
    | { mname; cattributes; univs; binders = binders1; signature;
        combinators; actions; eff_attrs;_} -> cattributes
let (__proj__Mkeff_decl__item__univs : eff_decl -> univ_names) =
  fun projectee ->
    match projectee with
    | { mname; cattributes; univs; binders = binders1; signature;
        combinators; actions; eff_attrs;_} -> univs
let (__proj__Mkeff_decl__item__binders : eff_decl -> binders) =
  fun projectee ->
    match projectee with
    | { mname; cattributes; univs; binders = binders1; signature;
        combinators; actions; eff_attrs;_} -> binders1
let (__proj__Mkeff_decl__item__signature : eff_decl -> tscheme) =
  fun projectee ->
    match projectee with
    | { mname; cattributes; univs; binders = binders1; signature;
        combinators; actions; eff_attrs;_} -> signature
let (__proj__Mkeff_decl__item__combinators : eff_decl -> eff_combinators) =
  fun projectee ->
    match projectee with
    | { mname; cattributes; univs; binders = binders1; signature;
        combinators; actions; eff_attrs;_} -> combinators
let (__proj__Mkeff_decl__item__actions : eff_decl -> action Prims.list) =
  fun projectee ->
    match projectee with
    | { mname; cattributes; univs; binders = binders1; signature;
        combinators; actions; eff_attrs;_} -> actions
let (__proj__Mkeff_decl__item__eff_attrs : eff_decl -> attribute Prims.list)
  =
  fun projectee ->
    match projectee with
    | { mname; cattributes; univs; binders = binders1; signature;
        combinators; actions; eff_attrs;_} -> eff_attrs
type sig_metadata =
  {
  sigmeta_active: Prims.bool ;
  sigmeta_fact_db_ids: Prims.string Prims.list ;
  sigmeta_admit: Prims.bool }
let (__proj__Mksig_metadata__item__sigmeta_active :
  sig_metadata -> Prims.bool) =
  fun projectee ->
    match projectee with
    | { sigmeta_active; sigmeta_fact_db_ids; sigmeta_admit;_} ->
        sigmeta_active
let (__proj__Mksig_metadata__item__sigmeta_fact_db_ids :
  sig_metadata -> Prims.string Prims.list) =
  fun projectee ->
    match projectee with
    | { sigmeta_active; sigmeta_fact_db_ids; sigmeta_admit;_} ->
        sigmeta_fact_db_ids
let (__proj__Mksig_metadata__item__sigmeta_admit :
  sig_metadata -> Prims.bool) =
  fun projectee ->
    match projectee with
    | { sigmeta_active; sigmeta_fact_db_ids; sigmeta_admit;_} ->
        sigmeta_admit
type sigelt' =
  | Sig_inductive_typ of (FStar_Ident.lident * univ_names * binders * typ *
  FStar_Ident.lident Prims.list * FStar_Ident.lident Prims.list) 
  | Sig_bundle of (sigelt Prims.list * FStar_Ident.lident Prims.list) 
  | Sig_datacon of (FStar_Ident.lident * univ_names * typ *
  FStar_Ident.lident * Prims.int * FStar_Ident.lident Prims.list) 
  | Sig_declare_typ of (FStar_Ident.lident * univ_names * typ) 
  | Sig_let of (letbindings * FStar_Ident.lident Prims.list) 
  | Sig_assume of (FStar_Ident.lident * univ_names * formula) 
  | Sig_new_effect of eff_decl 
  | Sig_sub_effect of sub_eff 
  | Sig_effect_abbrev of (FStar_Ident.lident * univ_names * binders * comp *
  cflag Prims.list) 
  | Sig_pragma of pragma 
  | Sig_splice of (FStar_Ident.lident Prims.list * term) 
  | Sig_polymonadic_bind of (FStar_Ident.lident * FStar_Ident.lident *
  FStar_Ident.lident * tscheme * tscheme) 
  | Sig_polymonadic_subcomp of (FStar_Ident.lident * FStar_Ident.lident *
  tscheme * tscheme) 
  | Sig_fail of (Prims.int Prims.list * Prims.bool * sigelt Prims.list) 
and sigelt =
  {
  sigel: sigelt' ;
  sigrng: FStar_Range.range ;
  sigquals: qualifier Prims.list ;
  sigmeta: sig_metadata ;
  sigattrs: attribute Prims.list ;
  sigopts: FStar_Options.optionstate FStar_Pervasives_Native.option }
let (uu___is_Sig_inductive_typ : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_inductive_typ _0 -> true | uu____7299 -> false
let (__proj__Sig_inductive_typ__item___0 :
  sigelt' ->
    (FStar_Ident.lident * univ_names * binders * typ * FStar_Ident.lident
      Prims.list * FStar_Ident.lident Prims.list))
  = fun projectee -> match projectee with | Sig_inductive_typ _0 -> _0
let (uu___is_Sig_bundle : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_bundle _0 -> true | uu____7374 -> false
let (__proj__Sig_bundle__item___0 :
  sigelt' -> (sigelt Prims.list * FStar_Ident.lident Prims.list)) =
  fun projectee -> match projectee with | Sig_bundle _0 -> _0
let (uu___is_Sig_datacon : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_datacon _0 -> true | uu____7432 -> false
let (__proj__Sig_datacon__item___0 :
  sigelt' ->
    (FStar_Ident.lident * univ_names * typ * FStar_Ident.lident * Prims.int *
      FStar_Ident.lident Prims.list))
  = fun projectee -> match projectee with | Sig_datacon _0 -> _0
let (uu___is_Sig_declare_typ : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_declare_typ _0 -> true | uu____7502 -> false
let (__proj__Sig_declare_typ__item___0 :
  sigelt' -> (FStar_Ident.lident * univ_names * typ)) =
  fun projectee -> match projectee with | Sig_declare_typ _0 -> _0
let (uu___is_Sig_let : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_let _0 -> true | uu____7545 -> false
let (__proj__Sig_let__item___0 :
  sigelt' -> (letbindings * FStar_Ident.lident Prims.list)) =
  fun projectee -> match projectee with | Sig_let _0 -> _0
let (uu___is_Sig_assume : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_assume _0 -> true | uu____7588 -> false
let (__proj__Sig_assume__item___0 :
  sigelt' -> (FStar_Ident.lident * univ_names * formula)) =
  fun projectee -> match projectee with | Sig_assume _0 -> _0
let (uu___is_Sig_new_effect : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_new_effect _0 -> true | uu____7625 -> false
let (__proj__Sig_new_effect__item___0 : sigelt' -> eff_decl) =
  fun projectee -> match projectee with | Sig_new_effect _0 -> _0
let (uu___is_Sig_sub_effect : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_sub_effect _0 -> true | uu____7644 -> false
let (__proj__Sig_sub_effect__item___0 : sigelt' -> sub_eff) =
  fun projectee -> match projectee with | Sig_sub_effect _0 -> _0
let (uu___is_Sig_effect_abbrev : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_effect_abbrev _0 -> true | uu____7675 -> false
let (__proj__Sig_effect_abbrev__item___0 :
  sigelt' ->
    (FStar_Ident.lident * univ_names * binders * comp * cflag Prims.list))
  = fun projectee -> match projectee with | Sig_effect_abbrev _0 -> _0
let (uu___is_Sig_pragma : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_pragma _0 -> true | uu____7730 -> false
let (__proj__Sig_pragma__item___0 : sigelt' -> pragma) =
  fun projectee -> match projectee with | Sig_pragma _0 -> _0
let (uu___is_Sig_splice : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_splice _0 -> true | uu____7755 -> false
let (__proj__Sig_splice__item___0 :
  sigelt' -> (FStar_Ident.lident Prims.list * term)) =
  fun projectee -> match projectee with | Sig_splice _0 -> _0
let (uu___is_Sig_polymonadic_bind : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with
    | Sig_polymonadic_bind _0 -> true
    | uu____7802 -> false
let (__proj__Sig_polymonadic_bind__item___0 :
  sigelt' ->
    (FStar_Ident.lident * FStar_Ident.lident * FStar_Ident.lident * tscheme *
      tscheme))
  = fun projectee -> match projectee with | Sig_polymonadic_bind _0 -> _0
let (uu___is_Sig_polymonadic_subcomp : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with
    | Sig_polymonadic_subcomp _0 -> true
    | uu____7859 -> false
let (__proj__Sig_polymonadic_subcomp__item___0 :
  sigelt' -> (FStar_Ident.lident * FStar_Ident.lident * tscheme * tscheme)) =
  fun projectee -> match projectee with | Sig_polymonadic_subcomp _0 -> _0
let (uu___is_Sig_fail : sigelt' -> Prims.bool) =
  fun projectee ->
    match projectee with | Sig_fail _0 -> true | uu____7914 -> false
let (__proj__Sig_fail__item___0 :
  sigelt' -> (Prims.int Prims.list * Prims.bool * sigelt Prims.list)) =
  fun projectee -> match projectee with | Sig_fail _0 -> _0
let (__proj__Mksigelt__item__sigel : sigelt -> sigelt') =
  fun projectee ->
    match projectee with
    | { sigel; sigrng; sigquals; sigmeta; sigattrs; sigopts;_} -> sigel
let (__proj__Mksigelt__item__sigrng : sigelt -> FStar_Range.range) =
  fun projectee ->
    match projectee with
    | { sigel; sigrng; sigquals; sigmeta; sigattrs; sigopts;_} -> sigrng
let (__proj__Mksigelt__item__sigquals : sigelt -> qualifier Prims.list) =
  fun projectee ->
    match projectee with
    | { sigel; sigrng; sigquals; sigmeta; sigattrs; sigopts;_} -> sigquals
let (__proj__Mksigelt__item__sigmeta : sigelt -> sig_metadata) =
  fun projectee ->
    match projectee with
    | { sigel; sigrng; sigquals; sigmeta; sigattrs; sigopts;_} -> sigmeta
let (__proj__Mksigelt__item__sigattrs : sigelt -> attribute Prims.list) =
  fun projectee ->
    match projectee with
    | { sigel; sigrng; sigquals; sigmeta; sigattrs; sigopts;_} -> sigattrs
let (__proj__Mksigelt__item__sigopts :
  sigelt -> FStar_Options.optionstate FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with
    | { sigel; sigrng; sigquals; sigmeta; sigattrs; sigopts;_} -> sigopts
type sigelts = sigelt Prims.list
type modul =
  {
  name: FStar_Ident.lident ;
  declarations: sigelts ;
  exports: sigelts ;
  is_interface: Prims.bool }
let (__proj__Mkmodul__item__name : modul -> FStar_Ident.lident) =
  fun projectee ->
    match projectee with
    | { name; declarations; exports; is_interface;_} -> name
let (__proj__Mkmodul__item__declarations : modul -> sigelts) =
  fun projectee ->
    match projectee with
    | { name; declarations; exports; is_interface;_} -> declarations
let (__proj__Mkmodul__item__exports : modul -> sigelts) =
  fun projectee ->
    match projectee with
    | { name; declarations; exports; is_interface;_} -> exports
let (__proj__Mkmodul__item__is_interface : modul -> Prims.bool) =
  fun projectee ->
    match projectee with
    | { name; declarations; exports; is_interface;_} -> is_interface
let (mod_name : modul -> FStar_Ident.lident) = fun m -> m.name
type path = Prims.string Prims.list
type subst_t = subst_elt Prims.list
let (contains_reflectable : qualifier Prims.list -> Prims.bool) =
  fun l ->
    FStar_Util.for_some
      (fun uu___0_8173 ->
         match uu___0_8173 with
         | Reflectable uu____8175 -> true
         | uu____8177 -> false) l
let withinfo : 'a . 'a -> FStar_Range.range -> 'a withinfo_t =
  fun v -> fun r -> { v; p = r }
let withsort : 'a . 'a -> 'a withinfo_t =
  fun v -> withinfo v FStar_Range.dummyRange
let (bv_eq : bv -> bv -> Prims.bool) =
  fun bv1 ->
    fun bv2 ->
      (FStar_Ident.ident_equals bv1.ppname bv2.ppname) &&
        (bv1.index = bv2.index)
let (order_bv : bv -> bv -> Prims.int) =
  fun x ->
    fun y ->
      let i =
        let uu____8239 = FStar_Ident.string_of_id x.ppname in
        let uu____8241 = FStar_Ident.string_of_id y.ppname in
        FStar_String.compare uu____8239 uu____8241 in
      if i = Prims.int_zero then x.index - y.index else i
let (order_ident : FStar_Ident.ident -> FStar_Ident.ident -> Prims.int) =
  fun x ->
    fun y ->
      let uu____8261 = FStar_Ident.string_of_id x in
      let uu____8263 = FStar_Ident.string_of_id y in
      FStar_String.compare uu____8261 uu____8263
let (order_fv : FStar_Ident.lident -> FStar_Ident.lident -> Prims.int) =
  fun x ->
    fun y ->
      let uu____8277 = FStar_Ident.string_of_lid x in
      let uu____8279 = FStar_Ident.string_of_lid y in
      FStar_String.compare uu____8277 uu____8279
let (range_of_lbname : lbname -> FStar_Range.range) =
  fun l ->
    match l with
    | FStar_Util.Inl x -> FStar_Ident.range_of_id x.ppname
    | FStar_Util.Inr fv1 -> FStar_Ident.range_of_lid (fv1.fv_name).v
let (range_of_bv : bv -> FStar_Range.range) =
  fun x -> FStar_Ident.range_of_id x.ppname
let (set_range_of_bv : bv -> FStar_Range.range -> bv) =
  fun x ->
    fun r ->
      let uu___417_8306 = x in
      let uu____8307 = FStar_Ident.set_id_range r x.ppname in
      {
        ppname = uu____8307;
        index = (uu___417_8306.index);
        sort = (uu___417_8306.sort)
      }
let (on_antiquoted : (term -> term) -> quoteinfo -> quoteinfo) =
  fun f ->
    fun qi ->
      let aq =
        FStar_List.map
          (fun uu____8343 ->
             match uu____8343 with
             | (bv1, t) -> let uu____8354 = f t in (bv1, uu____8354))
          qi.antiquotes in
      let uu___425_8355 = qi in
      { qkind = (uu___425_8355.qkind); antiquotes = aq }
let (lookup_aq : bv -> antiquotations -> term FStar_Pervasives_Native.option)
  =
  fun bv1 ->
    fun aq ->
      let uu____8371 =
        FStar_List.tryFind
          (fun uu____8389 ->
             match uu____8389 with | (bv', uu____8398) -> bv_eq bv1 bv') aq in
      match uu____8371 with
      | FStar_Pervasives_Native.Some (uu____8405, e) ->
          FStar_Pervasives_Native.Some e
      | FStar_Pervasives_Native.None -> FStar_Pervasives_Native.None
let syn :
  'uuuuuu8436 'uuuuuu8437 'uuuuuu8438 .
    'uuuuuu8436 ->
      'uuuuuu8437 ->
        ('uuuuuu8437 -> 'uuuuuu8436 -> 'uuuuuu8438) -> 'uuuuuu8438
  = fun p -> fun k -> fun f -> f k p
let mk_fvs :
  'uuuuuu8469 .
    unit -> 'uuuuuu8469 FStar_Pervasives_Native.option FStar_ST.ref
  = fun uu____8478 -> FStar_Util.mk_ref FStar_Pervasives_Native.None
let mk_uvs :
  'uuuuuu8486 .
    unit -> 'uuuuuu8486 FStar_Pervasives_Native.option FStar_ST.ref
  = fun uu____8495 -> FStar_Util.mk_ref FStar_Pervasives_Native.None
let (new_bv_set : unit -> bv FStar_Util.set) =
  fun uu____8505 -> FStar_Util.new_set order_bv
let (new_id_set : unit -> FStar_Ident.ident FStar_Util.set) =
  fun uu____8515 -> FStar_Util.new_set order_ident
let (new_fv_set : unit -> FStar_Ident.lident FStar_Util.set) =
  fun uu____8525 -> FStar_Util.new_set order_fv
let (order_univ_name : univ_name -> univ_name -> Prims.int) =
  fun x ->
    fun y ->
      let uu____8540 = FStar_Ident.string_of_id x in
      let uu____8542 = FStar_Ident.string_of_id y in
      FStar_String.compare uu____8540 uu____8542
let (new_universe_names_set : unit -> univ_name FStar_Util.set) =
  fun uu____8551 -> FStar_Util.new_set order_univ_name
let (eq_binding : binding -> binding -> Prims.bool) =
  fun b1 ->
    fun b2 ->
      match (b1, b2) with
      | (Binding_var bv1, Binding_var bv2) -> bv_eq bv1 bv2
      | (Binding_lid (lid1, uu____8570), Binding_lid (lid2, uu____8572)) ->
          FStar_Ident.lid_equals lid1 lid2
      | (Binding_univ u1, Binding_univ u2) -> FStar_Ident.ident_equals u1 u2
      | uu____8607 -> false
let (no_names : freenames) = new_bv_set ()
let (no_fvars : FStar_Ident.lident FStar_Util.set) = new_fv_set ()
let (no_universe_names : univ_name FStar_Util.set) =
  new_universe_names_set ()
let (freenames_of_list : bv Prims.list -> freenames) =
  fun l -> FStar_List.fold_right FStar_Util.set_add l no_names
let (list_of_freenames : freenames -> bv Prims.list) =
  fun fvs -> FStar_Util.set_elements fvs
let mk : 'a . 'a -> FStar_Range.range -> 'a syntax =
  fun t ->
    fun r ->
      let uu____8660 = FStar_Util.mk_ref FStar_Pervasives_Native.None in
      { n = t; pos = r; vars = uu____8660 }
let (bv_to_tm : bv -> term) =
  fun bv1 -> let uu____8671 = range_of_bv bv1 in mk (Tm_bvar bv1) uu____8671
let (bv_to_name : bv -> term) =
  fun bv1 -> let uu____8678 = range_of_bv bv1 in mk (Tm_name bv1) uu____8678
let (binders_to_names : binders -> term Prims.list) =
  fun bs ->
    FStar_All.pipe_right bs
      (FStar_List.map
         (fun uu____8708 ->
            match uu____8708 with | (x, uu____8716) -> bv_to_name x))
let (mk_Tm_app : term -> args -> FStar_Range.range -> term) =
  fun t1 ->
    fun args1 ->
      fun p ->
        match args1 with | [] -> t1 | uu____8739 -> mk (Tm_app (t1, args1)) p
let (mk_Tm_uinst : term -> universes -> term) =
  fun t ->
    fun us ->
      match t.n with
      | Tm_fvar uu____8765 ->
          (match us with | [] -> t | us1 -> mk (Tm_uinst (t, us1)) t.pos)
      | uu____8769 -> failwith "Unexpected universe instantiation"
let (extend_app_n : term -> args -> FStar_Range.range -> term) =
  fun t ->
    fun args' ->
      fun r ->
        match t.n with
        | Tm_app (head, args1) ->
            mk_Tm_app head (FStar_List.append args1 args') r
        | uu____8821 -> mk_Tm_app t args' r
let (extend_app : term -> arg -> FStar_Range.range -> term) =
  fun t -> fun arg1 -> fun r -> extend_app_n t [arg1] r
let (mk_Tm_delayed : (term * subst_ts) -> FStar_Range.range -> term) =
  fun lr -> fun pos -> mk (Tm_delayed lr) pos
let (mk_Total' : typ -> universe FStar_Pervasives_Native.option -> comp) =
  fun t -> fun u -> mk (Total (t, u)) t.pos
let (mk_GTotal' : typ -> universe FStar_Pervasives_Native.option -> comp) =
  fun t -> fun u -> mk (GTotal (t, u)) t.pos
let (mk_Total : typ -> comp) =
  fun t -> mk_Total' t FStar_Pervasives_Native.None
let (mk_GTotal : typ -> comp) =
  fun t -> mk_GTotal' t FStar_Pervasives_Native.None
let (mk_Comp : comp_typ -> comp) = fun ct -> mk (Comp ct) (ct.result_typ).pos
let (mk_lb :
  (lbname * univ_name Prims.list * FStar_Ident.lident * typ * term *
    attribute Prims.list * FStar_Range.range) -> letbinding)
  =
  fun uu____8952 ->
    match uu____8952 with
    | (x, univs, eff, t, e, attrs, pos) ->
        {
          lbname = x;
          lbunivs = univs;
          lbtyp = t;
          lbeff = eff;
          lbdef = e;
          lbattrs = attrs;
          lbpos = pos
        }
let (mk_Tac : typ -> comp) =
  fun t ->
    mk_Comp
      {
        comp_univs = [U_zero];
        effect_name = FStar_Parser_Const.effect_Tac_lid;
        result_typ = t;
        effect_args = [];
        flags = [SOMETRIVIAL; TRIVIAL_POSTCONDITION]
      }
let (default_sigmeta : sig_metadata) =
  { sigmeta_active = true; sigmeta_fact_db_ids = []; sigmeta_admit = false }
let (mk_sigelt : sigelt' -> sigelt) =
  fun e ->
    {
      sigel = e;
      sigrng = FStar_Range.dummyRange;
      sigquals = [];
      sigmeta = default_sigmeta;
      sigattrs = [];
      sigopts = FStar_Pervasives_Native.None
    }
let (mk_subst : subst_t -> subst_t) = fun s -> s
let (extend_subst : subst_elt -> subst_elt Prims.list -> subst_t) =
  fun x -> fun s -> x :: s
let (argpos : arg -> FStar_Range.range) =
  fun x -> (FStar_Pervasives_Native.fst x).pos
let (tun : term) = mk Tm_unknown FStar_Range.dummyRange
let (teff : term) =
  mk (Tm_constant FStar_Const.Const_effect) FStar_Range.dummyRange
let (is_teff : term -> Prims.bool) =
  fun t ->
    match t.n with
    | Tm_constant (FStar_Const.Const_effect) -> true
    | uu____9052 -> false
let (is_type : term -> Prims.bool) =
  fun t -> match t.n with | Tm_type uu____9062 -> true | uu____9064 -> false
let (null_id : FStar_Ident.ident) =
  FStar_Ident.mk_ident ("_", FStar_Range.dummyRange)
let (null_bv : term -> bv) =
  fun k -> { ppname = null_id; index = Prims.int_zero; sort = k }
let (mk_binder : bv -> binder) = fun a -> (a, FStar_Pervasives_Native.None)
let (null_binder : term -> binder) =
  fun t ->
    let uu____9090 = null_bv t in (uu____9090, FStar_Pervasives_Native.None)
let (imp_tag : arg_qualifier) = Implicit false
let (iarg : term -> arg) =
  fun t -> (t, (FStar_Pervasives_Native.Some imp_tag))
let (as_arg : term -> arg) = fun t -> (t, FStar_Pervasives_Native.None)
let (is_null_bv : bv -> Prims.bool) =
  fun b ->
    let uu____9122 = FStar_Ident.string_of_id b.ppname in
    let uu____9124 = FStar_Ident.string_of_id null_id in
    uu____9122 = uu____9124
let (is_null_binder : binder -> Prims.bool) =
  fun b -> is_null_bv (FStar_Pervasives_Native.fst b)
let (is_top_level : letbinding Prims.list -> Prims.bool) =
  fun uu___1_9144 ->
    match uu___1_9144 with
    | { lbname = FStar_Util.Inr uu____9148; lbunivs = uu____9149;
        lbtyp = uu____9150; lbeff = uu____9151; lbdef = uu____9152;
        lbattrs = uu____9153; lbpos = uu____9154;_}::uu____9155 -> true
    | uu____9169 -> false
let (freenames_of_binders : binders -> freenames) =
  fun bs ->
    FStar_List.fold_right
      (fun uu____9191 ->
         fun out ->
           match uu____9191 with
           | (x, uu____9204) -> FStar_Util.set_add x out) bs no_names
let (binders_of_list : bv Prims.list -> binders) =
  fun fvs ->
    FStar_All.pipe_right fvs
      (FStar_List.map (fun t -> (t, FStar_Pervasives_Native.None)))
let (binders_of_freenames : freenames -> binders) =
  fun fvs ->
    let uu____9237 = FStar_Util.set_elements fvs in
    FStar_All.pipe_right uu____9237 binders_of_list
let (is_implicit : aqual -> Prims.bool) =
  fun uu___2_9248 ->
    match uu___2_9248 with
    | FStar_Pervasives_Native.Some (Implicit uu____9250) -> true
    | uu____9253 -> false
let (is_implicit_or_meta : aqual -> Prims.bool) =
  fun uu___3_9261 ->
    match uu___3_9261 with
    | FStar_Pervasives_Native.Some (Implicit uu____9263) -> true
    | FStar_Pervasives_Native.Some (Meta uu____9266) -> true
    | uu____9268 -> false
let (as_implicit : Prims.bool -> aqual) =
  fun uu___4_9276 ->
    if uu___4_9276
    then FStar_Pervasives_Native.Some imp_tag
    else FStar_Pervasives_Native.None
let (pat_bvs : pat -> bv Prims.list) =
  fun p ->
    let rec aux b p1 =
      match p1.v with
      | Pat_dot_term uu____9314 -> b
      | Pat_constant uu____9321 -> b
      | Pat_wild x -> x :: b
      | Pat_var x -> x :: b
      | Pat_cons (uu____9324, pats) ->
          FStar_List.fold_left
            (fun b1 ->
               fun uu____9358 ->
                 match uu____9358 with | (p2, uu____9371) -> aux b1 p2) b
            pats in
    let uu____9378 = aux [] p in
    FStar_All.pipe_left FStar_List.rev uu____9378
let (range_of_ropt :
  FStar_Range.range FStar_Pervasives_Native.option -> FStar_Range.range) =
  fun uu___5_9392 ->
    match uu___5_9392 with
    | FStar_Pervasives_Native.None -> FStar_Range.dummyRange
    | FStar_Pervasives_Native.Some r -> r
let (gen_bv :
  Prims.string ->
    FStar_Range.range FStar_Pervasives_Native.option -> typ -> bv)
  =
  fun s ->
    fun r ->
      fun t ->
        let id = FStar_Ident.mk_ident (s, (range_of_ropt r)) in
        let uu____9432 = FStar_Ident.next_id () in
        { ppname = id; index = uu____9432; sort = t }
let (new_bv : FStar_Range.range FStar_Pervasives_Native.option -> typ -> bv)
  = fun ropt -> fun t -> gen_bv FStar_Ident.reserved_prefix ropt t
let (freshen_bv : bv -> bv) =
  fun bv1 ->
    let uu____9455 = is_null_bv bv1 in
    if uu____9455
    then
      let uu____9458 =
        let uu____9461 = range_of_bv bv1 in
        FStar_Pervasives_Native.Some uu____9461 in
      new_bv uu____9458 bv1.sort
    else
      (let uu___611_9464 = bv1 in
       let uu____9465 = FStar_Ident.next_id () in
       {
         ppname = (uu___611_9464.ppname);
         index = uu____9465;
         sort = (uu___611_9464.sort)
       })
let (freshen_binder : binder -> binder) =
  fun b ->
    let uu____9473 = b in
    match uu____9473 with
    | (bv1, aq) -> let uu____9480 = freshen_bv bv1 in (uu____9480, aq)
let (new_univ_name :
  FStar_Range.range FStar_Pervasives_Native.option -> univ_name) =
  fun ropt ->
    let id = FStar_Ident.next_id () in
    let uu____9495 =
      let uu____9501 =
        let uu____9503 = FStar_Util.string_of_int id in
        Prims.op_Hat FStar_Ident.reserved_prefix uu____9503 in
      (uu____9501, (range_of_ropt ropt)) in
    FStar_Ident.mk_ident uu____9495
let (lbname_eq :
  (bv, FStar_Ident.lident) FStar_Util.either ->
    (bv, FStar_Ident.lident) FStar_Util.either -> Prims.bool)
  =
  fun l1 ->
    fun l2 ->
      match (l1, l2) with
      | (FStar_Util.Inl x, FStar_Util.Inl y) -> bv_eq x y
      | (FStar_Util.Inr l, FStar_Util.Inr m) -> FStar_Ident.lid_equals l m
      | uu____9563 -> false
let (fv_eq : fv -> fv -> Prims.bool) =
  fun fv1 ->
    fun fv2 -> FStar_Ident.lid_equals (fv1.fv_name).v (fv2.fv_name).v
let (fv_eq_lid : fv -> FStar_Ident.lident -> Prims.bool) =
  fun fv1 -> fun lid -> FStar_Ident.lid_equals (fv1.fv_name).v lid
let (set_bv_range : bv -> FStar_Range.range -> bv) =
  fun bv1 ->
    fun r ->
      let uu___638_9612 = bv1 in
      let uu____9613 = FStar_Ident.set_id_range r bv1.ppname in
      {
        ppname = uu____9613;
        index = (uu___638_9612.index);
        sort = (uu___638_9612.sort)
      }
let (lid_as_fv :
  FStar_Ident.lident ->
    delta_depth -> fv_qual FStar_Pervasives_Native.option -> fv)
  =
  fun l ->
    fun dd ->
      fun dq ->
        let uu____9634 =
          let uu____9635 = FStar_Ident.range_of_lid l in
          withinfo l uu____9635 in
        { fv_name = uu____9634; fv_delta = dd; fv_qual = dq }
let (fv_to_tm : fv -> term) =
  fun fv1 ->
    let uu____9642 = FStar_Ident.range_of_lid (fv1.fv_name).v in
    mk (Tm_fvar fv1) uu____9642
let (fvar :
  FStar_Ident.lident ->
    delta_depth -> fv_qual FStar_Pervasives_Native.option -> term)
  =
  fun l ->
    fun dd ->
      fun dq -> let uu____9663 = lid_as_fv l dd dq in fv_to_tm uu____9663
let (lid_of_fv : fv -> FStar_Ident.lid) = fun fv1 -> (fv1.fv_name).v
let (range_of_fv : fv -> FStar_Range.range) =
  fun fv1 ->
    let uu____9676 = lid_of_fv fv1 in FStar_Ident.range_of_lid uu____9676
let (set_range_of_fv : fv -> FStar_Range.range -> fv) =
  fun fv1 ->
    fun r ->
      let uu___651_9688 = fv1 in
      let uu____9689 =
        let uu___653_9690 = fv1.fv_name in
        let uu____9691 =
          let uu____9692 = lid_of_fv fv1 in
          FStar_Ident.set_lid_range uu____9692 r in
        { v = uu____9691; p = (uu___653_9690.p) } in
      {
        fv_name = uu____9689;
        fv_delta = (uu___651_9688.fv_delta);
        fv_qual = (uu___651_9688.fv_qual)
      }
let (has_simple_attribute : term Prims.list -> Prims.string -> Prims.bool) =
  fun l ->
    fun s ->
      FStar_List.existsb
        (fun uu___6_9718 ->
           match uu___6_9718 with
           | { n = Tm_constant (FStar_Const.Const_string (data, uu____9723));
               pos = uu____9724; vars = uu____9725;_} when data = s -> true
           | uu____9732 -> false) l
let rec (eq_pat : pat -> pat -> Prims.bool) =
  fun p1 ->
    fun p2 ->
      match ((p1.v), (p2.v)) with
      | (Pat_constant c1, Pat_constant c2) -> FStar_Const.eq_const c1 c2
      | (Pat_cons (fv1, as1), Pat_cons (fv2, as2)) ->
          let uu____9791 = fv_eq fv1 fv2 in
          if uu____9791
          then
            let uu____9796 = FStar_List.zip as1 as2 in
            FStar_All.pipe_right uu____9796
              (FStar_List.for_all
                 (fun uu____9863 ->
                    match uu____9863 with
                    | ((p11, b1), (p21, b2)) -> (b1 = b2) && (eq_pat p11 p21)))
          else false
      | (Pat_var uu____9901, Pat_var uu____9902) -> true
      | (Pat_wild uu____9904, Pat_wild uu____9905) -> true
      | (Pat_dot_term (bv1, t1), Pat_dot_term (bv2, t2)) -> true
      | (uu____9920, uu____9921) -> false
let (delta_constant : delta_depth) = Delta_constant_at_level Prims.int_zero
let (delta_equational : delta_depth) =
  Delta_equational_at_level Prims.int_zero
let (fvconst : FStar_Ident.lident -> fv) =
  fun l -> lid_as_fv l delta_constant FStar_Pervasives_Native.None
let (tconst : FStar_Ident.lident -> term) =
  fun l ->
    let uu____9939 = let uu____9940 = fvconst l in Tm_fvar uu____9940 in
    mk uu____9939 FStar_Range.dummyRange
let (tabbrev : FStar_Ident.lident -> term) =
  fun l ->
    let uu____9947 =
      let uu____9948 =
        lid_as_fv l (Delta_constant_at_level Prims.int_one)
          FStar_Pervasives_Native.None in
      Tm_fvar uu____9948 in
    mk uu____9947 FStar_Range.dummyRange
let (tdataconstr : FStar_Ident.lident -> term) =
  fun l ->
    let uu____9956 =
      lid_as_fv l delta_constant (FStar_Pervasives_Native.Some Data_ctor) in
    fv_to_tm uu____9956
let (t_unit : term) = tconst FStar_Parser_Const.unit_lid
let (t_bool : term) = tconst FStar_Parser_Const.bool_lid
let (t_int : term) = tconst FStar_Parser_Const.int_lid
let (t_string : term) = tconst FStar_Parser_Const.string_lid
let (t_exn : term) = tconst FStar_Parser_Const.exn_lid
let (t_real : term) = tconst FStar_Parser_Const.real_lid
let (t_float : term) = tconst FStar_Parser_Const.float_lid
let (t_char : term) = tabbrev FStar_Parser_Const.char_lid
let (t_range : term) = tconst FStar_Parser_Const.range_lid
let (t_term : term) = tconst FStar_Parser_Const.term_lid
let (t_term_view : term) = tabbrev FStar_Parser_Const.term_view_lid
let (t_order : term) = tconst FStar_Parser_Const.order_lid
let (t_decls : term) = tabbrev FStar_Parser_Const.decls_lid
let (t_binder : term) = tconst FStar_Parser_Const.binder_lid
let (t_binders : term) = tconst FStar_Parser_Const.binders_lid
let (t_bv : term) = tconst FStar_Parser_Const.bv_lid
let (t_fv : term) = tconst FStar_Parser_Const.fv_lid
let (t_norm_step : term) = tconst FStar_Parser_Const.norm_step_lid
let (t_tac_of : term -> term -> term) =
  fun a ->
    fun b ->
      let uu____9986 =
        let uu____9987 = tabbrev FStar_Parser_Const.tac_lid in
        mk_Tm_uinst uu____9987 [U_zero; U_zero] in
      let uu____9988 =
        let uu____9989 = as_arg a in
        let uu____9998 = let uu____10009 = as_arg b in [uu____10009] in
        uu____9989 :: uu____9998 in
      mk_Tm_app uu____9986 uu____9988 FStar_Range.dummyRange
let (t_tactic_of : term -> term) =
  fun t ->
    let uu____10048 =
      let uu____10049 = tabbrev FStar_Parser_Const.tactic_lid in
      mk_Tm_uinst uu____10049 [U_zero] in
    let uu____10050 = let uu____10051 = as_arg t in [uu____10051] in
    mk_Tm_app uu____10048 uu____10050 FStar_Range.dummyRange
let (t_tactic_unit : term) = t_tactic_of t_unit
let (t_list_of : term -> term) =
  fun t ->
    let uu____10083 =
      let uu____10084 = tabbrev FStar_Parser_Const.list_lid in
      mk_Tm_uinst uu____10084 [U_zero] in
    let uu____10085 = let uu____10086 = as_arg t in [uu____10086] in
    mk_Tm_app uu____10083 uu____10085 FStar_Range.dummyRange
let (t_option_of : term -> term) =
  fun t ->
    let uu____10117 =
      let uu____10118 = tabbrev FStar_Parser_Const.option_lid in
      mk_Tm_uinst uu____10118 [U_zero] in
    let uu____10119 = let uu____10120 = as_arg t in [uu____10120] in
    mk_Tm_app uu____10117 uu____10119 FStar_Range.dummyRange
let (t_tuple2_of : term -> term -> term) =
  fun t1 ->
    fun t2 ->
      let uu____10156 =
        let uu____10157 = tabbrev FStar_Parser_Const.lid_tuple2 in
        mk_Tm_uinst uu____10157 [U_zero; U_zero] in
      let uu____10158 =
        let uu____10159 = as_arg t1 in
        let uu____10168 = let uu____10179 = as_arg t2 in [uu____10179] in
        uu____10159 :: uu____10168 in
      mk_Tm_app uu____10156 uu____10158 FStar_Range.dummyRange
let (t_either_of : term -> term -> term) =
  fun t1 ->
    fun t2 ->
      let uu____10223 =
        let uu____10224 = tabbrev FStar_Parser_Const.either_lid in
        mk_Tm_uinst uu____10224 [U_zero; U_zero] in
      let uu____10225 =
        let uu____10226 = as_arg t1 in
        let uu____10235 = let uu____10246 = as_arg t2 in [uu____10246] in
        uu____10226 :: uu____10235 in
      mk_Tm_app uu____10223 uu____10225 FStar_Range.dummyRange
let (unit_const_with_range : FStar_Range.range -> term) =
  fun r -> mk (Tm_constant FStar_Const.Const_unit) r
let (unit_const : term) = unit_const_with_range FStar_Range.dummyRange