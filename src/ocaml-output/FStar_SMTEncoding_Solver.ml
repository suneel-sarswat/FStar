open Prims
type z3_replay_result =
  (FStar_SMTEncoding_Z3.unsat_core, FStar_SMTEncoding_Term.error_labels)
    FStar_Util.either
let z3_result_as_replay_result :
  'uuuuuu35 'uuuuuu36 'uuuuuu37 .
    ('uuuuuu35, ('uuuuuu36 * 'uuuuuu37)) FStar_Util.either ->
      ('uuuuuu35, 'uuuuuu36) FStar_Util.either
  =
  fun uu___0_54 ->
    match uu___0_54 with
    | FStar_Util.Inl l -> FStar_Util.Inl l
    | FStar_Util.Inr (r, uu____69) -> FStar_Util.Inr r
let (recorded_hints :
  FStar_Util.hints FStar_Pervasives_Native.option FStar_ST.ref) =
  FStar_Util.mk_ref FStar_Pervasives_Native.None
let (replaying_hints :
  FStar_Util.hints FStar_Pervasives_Native.option FStar_ST.ref) =
  FStar_Util.mk_ref FStar_Pervasives_Native.None
let initialize_hints_db : 'uuuuuu95 . Prims.string -> 'uuuuuu95 -> unit =
  fun src_filename ->
    fun format_filename ->
      (let uu____109 = FStar_Options.record_hints () in
       if uu____109
       then
         FStar_ST.op_Colon_Equals recorded_hints
           (FStar_Pervasives_Native.Some [])
       else ());
      (let norm_src_filename = FStar_Util.normalize_file_path src_filename in
       let val_filename = FStar_Options.hint_file_for_src norm_src_filename in
       let uu____143 = FStar_Util.read_hints val_filename in
       match uu____143 with
       | FStar_Util.HintsOK hints ->
           let expected_digest = FStar_Util.digest_of_file norm_src_filename in
           ((let uu____148 = FStar_Options.hint_info () in
             if uu____148
             then
               FStar_Util.print3 "(%s) digest is %s from %s.\n"
                 norm_src_filename
                 (if hints.FStar_Util.module_digest = expected_digest
                  then "valid; using hints"
                  else "invalid; using potentially stale hints") val_filename
             else ());
            FStar_ST.op_Colon_Equals replaying_hints
              (FStar_Pervasives_Native.Some (hints.FStar_Util.hints)))
       | FStar_Util.MalformedJson ->
           let uu____185 = FStar_Options.use_hints () in
           if uu____185
           then
             let uu____188 =
               let uu____194 =
                 FStar_Util.format1
                   "Malformed JSON hints file: %s; ran without hints\n"
                   val_filename in
               (FStar_Errors.Warning_CouldNotReadHints, uu____194) in
             FStar_Errors.log_issue FStar_Range.dummyRange uu____188
           else ()
       | FStar_Util.UnableToOpen ->
           let uu____201 = FStar_Options.use_hints () in
           if uu____201
           then
             let uu____204 =
               let uu____210 =
                 FStar_Util.format1
                   "Unable to open hints file: %s; ran without hints\n"
                   val_filename in
               (FStar_Errors.Warning_CouldNotReadHints, uu____210) in
             FStar_Errors.log_issue FStar_Range.dummyRange uu____204
           else ())
let (finalize_hints_db : Prims.string -> unit) =
  fun src_filename ->
    (let uu____225 = FStar_Options.record_hints () in
     if uu____225
     then
       let hints =
         let uu____229 = FStar_ST.op_Bang recorded_hints in
         FStar_Option.get uu____229 in
       let hints_db =
         let uu____256 = FStar_Util.digest_of_file src_filename in
         { FStar_Util.module_digest = uu____256; FStar_Util.hints = hints } in
       let norm_src_filename = FStar_Util.normalize_file_path src_filename in
       let val_filename = FStar_Options.hint_file_for_src norm_src_filename in
       FStar_Util.write_hints val_filename hints_db
     else ());
    FStar_ST.op_Colon_Equals recorded_hints FStar_Pervasives_Native.None;
    FStar_ST.op_Colon_Equals replaying_hints FStar_Pervasives_Native.None
let with_hints_db : 'a . Prims.string -> (unit -> 'a) -> 'a =
  fun fname ->
    fun f ->
      initialize_hints_db fname false;
      (let result = f () in finalize_hints_db fname; result)
let (filter_using_facts_from :
  FStar_TypeChecker_Env.env ->
    FStar_SMTEncoding_Term.decl Prims.list ->
      FStar_SMTEncoding_Term.decl Prims.list)
  =
  fun e ->
    fun theory ->
      let matches_fact_ids include_assumption_names a =
        match a.FStar_SMTEncoding_Term.assumption_fact_ids with
        | [] -> true
        | uu____378 ->
            (FStar_All.pipe_right
               a.FStar_SMTEncoding_Term.assumption_fact_ids
               (FStar_Util.for_some
                  (fun uu___1_386 ->
                     match uu___1_386 with
                     | FStar_SMTEncoding_Term.Name lid ->
                         FStar_TypeChecker_Env.should_enc_lid e lid
                     | uu____389 -> false)))
              ||
              (let uu____392 =
                 FStar_Util.smap_try_find include_assumption_names
                   a.FStar_SMTEncoding_Term.assumption_name in
               FStar_Option.isSome uu____392) in
      let theory_rev = FStar_List.rev theory in
      let pruned_theory =
        let include_assumption_names =
          FStar_Util.smap_create (Prims.of_int (10000)) in
        let keep_decl uu___2_416 =
          match uu___2_416 with
          | FStar_SMTEncoding_Term.Assume a ->
              matches_fact_ids include_assumption_names a
          | FStar_SMTEncoding_Term.RetainAssumptions names ->
              (FStar_List.iter
                 (fun x ->
                    FStar_Util.smap_add include_assumption_names x true)
                 names;
               true)
          | FStar_SMTEncoding_Term.Module uu____431 ->
              failwith
                "Solver.fs::keep_decl should never have been called with a Module decl"
          | uu____441 -> true in
        FStar_List.fold_left
          (fun out ->
             fun d ->
               match d with
               | FStar_SMTEncoding_Term.Module (name, decls) ->
                   let uu____464 =
                     FStar_All.pipe_right decls (FStar_List.filter keep_decl) in
                   FStar_All.pipe_right uu____464
                     (fun decls1 ->
                        (FStar_SMTEncoding_Term.Module (name, decls1)) :: out)
               | uu____482 ->
                   let uu____483 = keep_decl d in
                   if uu____483 then d :: out else out) [] theory_rev in
      pruned_theory
let rec (filter_assertions_with_stats :
  FStar_TypeChecker_Env.env ->
    FStar_SMTEncoding_Z3.unsat_core ->
      FStar_SMTEncoding_Term.decl Prims.list ->
        (FStar_SMTEncoding_Term.decl Prims.list * Prims.bool * Prims.int *
          Prims.int))
  =
  fun e ->
    fun core ->
      fun theory ->
        match core with
        | FStar_Pervasives_Native.None ->
            let uu____539 = filter_using_facts_from e theory in
            (uu____539, false, Prims.int_zero, Prims.int_zero)
        | FStar_Pervasives_Native.Some core1 ->
            let theory_rev = FStar_List.rev theory in
            let uu____560 =
              let uu____571 =
                let uu____582 =
                  let uu____585 =
                    let uu____586 =
                      let uu____588 =
                        FStar_All.pipe_right core1 (FStar_String.concat ", ") in
                      Prims.op_Hat "UNSAT CORE: " uu____588 in
                    FStar_SMTEncoding_Term.Caption uu____586 in
                  [uu____585] in
                (uu____582, Prims.int_zero, Prims.int_zero) in
              FStar_List.fold_left
                (fun uu____618 ->
                   fun d ->
                     match uu____618 with
                     | (theory1, n_retained, n_pruned) ->
                         (match d with
                          | FStar_SMTEncoding_Term.Assume a ->
                              if
                                FStar_List.contains
                                  a.FStar_SMTEncoding_Term.assumption_name
                                  core1
                              then
                                ((d :: theory1),
                                  (n_retained + Prims.int_one), n_pruned)
                              else
                                if
                                  FStar_Util.starts_with
                                    a.FStar_SMTEncoding_Term.assumption_name
                                    "@"
                                then ((d :: theory1), n_retained, n_pruned)
                                else
                                  (theory1, n_retained,
                                    (n_pruned + Prims.int_one))
                          | FStar_SMTEncoding_Term.Module (name, decls) ->
                              let uu____712 =
                                FStar_All.pipe_right decls
                                  (filter_assertions_with_stats e
                                     (FStar_Pervasives_Native.Some core1)) in
                              FStar_All.pipe_right uu____712
                                (fun uu____772 ->
                                   match uu____772 with
                                   | (decls1, uu____797, r, p) ->
                                       (((FStar_SMTEncoding_Term.Module
                                            (name, decls1)) :: theory1),
                                         (n_retained + r), (n_pruned + p)))
                          | uu____817 ->
                              ((d :: theory1), n_retained, n_pruned)))
                uu____571 theory_rev in
            (match uu____560 with
             | (theory', n_retained, n_pruned) ->
                 (theory', true, n_retained, n_pruned))
let (filter_assertions :
  FStar_TypeChecker_Env.env ->
    FStar_SMTEncoding_Z3.unsat_core ->
      FStar_SMTEncoding_Term.decl Prims.list ->
        (FStar_SMTEncoding_Term.decl Prims.list * Prims.bool))
  =
  fun e ->
    fun core ->
      fun theory ->
        let uu____879 = filter_assertions_with_stats e core theory in
        match uu____879 with
        | (theory1, b, uu____902, uu____903) -> (theory1, b)
let (filter_facts_without_core :
  FStar_TypeChecker_Env.env ->
    FStar_SMTEncoding_Term.decl Prims.list ->
      (FStar_SMTEncoding_Term.decl Prims.list * Prims.bool))
  =
  fun e ->
    fun x ->
      let uu____939 = filter_using_facts_from e x in (uu____939, false)
type errors =
  {
  error_reason: Prims.string ;
  error_fuel: Prims.int ;
  error_ifuel: Prims.int ;
  error_hint: Prims.string Prims.list FStar_Pervasives_Native.option ;
  error_messages:
    (FStar_Errors.raw_error * Prims.string * FStar_Range.range) Prims.list }
let (__proj__Mkerrors__item__error_reason : errors -> Prims.string) =
  fun projectee ->
    match projectee with
    | { error_reason; error_fuel; error_ifuel; error_hint; error_messages;_}
        -> error_reason
let (__proj__Mkerrors__item__error_fuel : errors -> Prims.int) =
  fun projectee ->
    match projectee with
    | { error_reason; error_fuel; error_ifuel; error_hint; error_messages;_}
        -> error_fuel
let (__proj__Mkerrors__item__error_ifuel : errors -> Prims.int) =
  fun projectee ->
    match projectee with
    | { error_reason; error_fuel; error_ifuel; error_hint; error_messages;_}
        -> error_ifuel
let (__proj__Mkerrors__item__error_hint :
  errors -> Prims.string Prims.list FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with
    | { error_reason; error_fuel; error_ifuel; error_hint; error_messages;_}
        -> error_hint
let (__proj__Mkerrors__item__error_messages :
  errors ->
    (FStar_Errors.raw_error * Prims.string * FStar_Range.range) Prims.list)
  =
  fun projectee ->
    match projectee with
    | { error_reason; error_fuel; error_ifuel; error_hint; error_messages;_}
        -> error_messages
let (error_to_short_string : errors -> Prims.string) =
  fun err ->
    let uu____1169 = FStar_Util.string_of_int err.error_fuel in
    let uu____1171 = FStar_Util.string_of_int err.error_ifuel in
    FStar_Util.format4 "%s (fuel=%s; ifuel=%s%s)" err.error_reason uu____1169
      uu____1171
      (if FStar_Option.isSome err.error_hint then "; with hint" else "")
let (error_to_is_timeout : errors -> Prims.string Prims.list) =
  fun err ->
    if FStar_Util.ends_with err.error_reason "canceled"
    then
      let uu____1197 =
        let uu____1199 = FStar_Util.string_of_int err.error_fuel in
        let uu____1201 = FStar_Util.string_of_int err.error_ifuel in
        FStar_Util.format4 "timeout (fuel=%s; ifuel=%s; %s)" err.error_reason
          uu____1199 uu____1201
          (if FStar_Option.isSome err.error_hint then "with hint" else "") in
      [uu____1197]
    else []
type query_settings =
  {
  query_env: FStar_TypeChecker_Env.env ;
  query_decl: FStar_SMTEncoding_Term.decl ;
  query_name: Prims.string ;
  query_index: Prims.int ;
  query_range: FStar_Range.range ;
  query_fuel: Prims.int ;
  query_ifuel: Prims.int ;
  query_rlimit: Prims.int ;
  query_hint: FStar_SMTEncoding_Z3.unsat_core ;
  query_errors: errors Prims.list ;
  query_all_labels: FStar_SMTEncoding_Term.error_labels ;
  query_suffix: FStar_SMTEncoding_Term.decl Prims.list ;
  query_hash: Prims.string FStar_Pervasives_Native.option }
let (__proj__Mkquery_settings__item__query_env :
  query_settings -> FStar_TypeChecker_Env.env) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_env
let (__proj__Mkquery_settings__item__query_decl :
  query_settings -> FStar_SMTEncoding_Term.decl) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_decl
let (__proj__Mkquery_settings__item__query_name :
  query_settings -> Prims.string) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_name
let (__proj__Mkquery_settings__item__query_index :
  query_settings -> Prims.int) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_index
let (__proj__Mkquery_settings__item__query_range :
  query_settings -> FStar_Range.range) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_range
let (__proj__Mkquery_settings__item__query_fuel :
  query_settings -> Prims.int) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_fuel
let (__proj__Mkquery_settings__item__query_ifuel :
  query_settings -> Prims.int) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_ifuel
let (__proj__Mkquery_settings__item__query_rlimit :
  query_settings -> Prims.int) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_rlimit
let (__proj__Mkquery_settings__item__query_hint :
  query_settings -> FStar_SMTEncoding_Z3.unsat_core) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_hint
let (__proj__Mkquery_settings__item__query_errors :
  query_settings -> errors Prims.list) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_errors
let (__proj__Mkquery_settings__item__query_all_labels :
  query_settings -> FStar_SMTEncoding_Term.error_labels) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_all_labels
let (__proj__Mkquery_settings__item__query_suffix :
  query_settings -> FStar_SMTEncoding_Term.decl Prims.list) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_suffix
let (__proj__Mkquery_settings__item__query_hash :
  query_settings -> Prims.string FStar_Pervasives_Native.option) =
  fun projectee ->
    match projectee with
    | { query_env; query_decl; query_name; query_index; query_range;
        query_fuel; query_ifuel; query_rlimit; query_hint; query_errors;
        query_all_labels; query_suffix; query_hash;_} -> query_hash
let (with_fuel_and_diagnostics :
  query_settings ->
    FStar_SMTEncoding_Term.decl Prims.list ->
      FStar_SMTEncoding_Term.decl Prims.list)
  =
  fun settings ->
    fun label_assumptions ->
      let n = settings.query_fuel in
      let i = settings.query_ifuel in
      let rlimit = settings.query_rlimit in
      let uu____1745 =
        let uu____1748 =
          let uu____1749 =
            let uu____1751 = FStar_Util.string_of_int n in
            let uu____1753 = FStar_Util.string_of_int i in
            FStar_Util.format2 "<fuel='%s' ifuel='%s'>" uu____1751 uu____1753 in
          FStar_SMTEncoding_Term.Caption uu____1749 in
        let uu____1756 =
          let uu____1759 =
            let uu____1760 =
              let uu____1768 =
                let uu____1769 =
                  let uu____1774 =
                    FStar_SMTEncoding_Util.mkApp ("MaxFuel", []) in
                  let uu____1779 = FStar_SMTEncoding_Term.n_fuel n in
                  (uu____1774, uu____1779) in
                FStar_SMTEncoding_Util.mkEq uu____1769 in
              (uu____1768, FStar_Pervasives_Native.None,
                "@MaxFuel_assumption") in
            FStar_SMTEncoding_Util.mkAssume uu____1760 in
          let uu____1783 =
            let uu____1786 =
              let uu____1787 =
                let uu____1795 =
                  let uu____1796 =
                    let uu____1801 =
                      FStar_SMTEncoding_Util.mkApp ("MaxIFuel", []) in
                    let uu____1806 = FStar_SMTEncoding_Term.n_fuel i in
                    (uu____1801, uu____1806) in
                  FStar_SMTEncoding_Util.mkEq uu____1796 in
                (uu____1795, FStar_Pervasives_Native.None,
                  "@MaxIFuel_assumption") in
              FStar_SMTEncoding_Util.mkAssume uu____1787 in
            [uu____1786; settings.query_decl] in
          uu____1759 :: uu____1783 in
        uu____1748 :: uu____1756 in
      let uu____1810 =
        let uu____1813 =
          let uu____1816 =
            let uu____1819 =
              let uu____1820 =
                let uu____1827 = FStar_Util.string_of_int rlimit in
                ("rlimit", uu____1827) in
              FStar_SMTEncoding_Term.SetOption uu____1820 in
            [uu____1819;
            FStar_SMTEncoding_Term.CheckSat;
            FStar_SMTEncoding_Term.SetOption ("rlimit", "0");
            FStar_SMTEncoding_Term.GetReasonUnknown;
            FStar_SMTEncoding_Term.GetUnsatCore] in
          let uu____1836 =
            let uu____1839 =
              let uu____1842 =
                (FStar_Options.print_z3_statistics ()) ||
                  (FStar_Options.query_stats ()) in
              if uu____1842
              then [FStar_SMTEncoding_Term.GetStatistics]
              else [] in
            FStar_List.append uu____1839 settings.query_suffix in
          FStar_List.append uu____1816 uu____1836 in
        FStar_List.append label_assumptions uu____1813 in
      FStar_List.append uu____1745 uu____1810
let (used_hint : query_settings -> Prims.bool) =
  fun s -> FStar_Option.isSome s.query_hint
let (get_hint_for :
  Prims.string -> Prims.int -> FStar_Util.hint FStar_Pervasives_Native.option)
  =
  fun qname ->
    fun qindex ->
      let uu____1876 = FStar_ST.op_Bang replaying_hints in
      match uu____1876 with
      | FStar_Pervasives_Native.Some hints ->
          FStar_Util.find_map hints
            (fun uu___3_1909 ->
               match uu___3_1909 with
               | FStar_Pervasives_Native.Some hint when
                   (hint.FStar_Util.hint_name = qname) &&
                     (hint.FStar_Util.hint_index = qindex)
                   -> FStar_Pervasives_Native.Some hint
               | uu____1917 -> FStar_Pervasives_Native.None)
      | uu____1920 -> FStar_Pervasives_Native.None
let (query_errors :
  query_settings ->
    FStar_SMTEncoding_Z3.z3result -> errors FStar_Pervasives_Native.option)
  =
  fun settings ->
    fun z3result ->
      match z3result.FStar_SMTEncoding_Z3.z3result_status with
      | FStar_SMTEncoding_Z3.UNSAT uu____1938 -> FStar_Pervasives_Native.None
      | uu____1939 ->
          let uu____1940 =
            FStar_SMTEncoding_Z3.status_string_and_errors
              z3result.FStar_SMTEncoding_Z3.z3result_status in
          (match uu____1940 with
           | (msg, error_labels) ->
               let err =
                 let uu____1953 =
                   FStar_List.map
                     (fun uu____1981 ->
                        match uu____1981 with
                        | (uu____1996, x, y) ->
                            (FStar_Errors.Error_Z3SolverError, x, y))
                     error_labels in
                 {
                   error_reason = msg;
                   error_fuel = (settings.query_fuel);
                   error_ifuel = (settings.query_ifuel);
                   error_hint = (settings.query_hint);
                   error_messages = uu____1953
                 } in
               FStar_Pervasives_Native.Some err)
let (detail_hint_replay :
  query_settings -> FStar_SMTEncoding_Z3.z3result -> unit) =
  fun settings ->
    fun z3result ->
      let uu____2013 =
        (used_hint settings) && (FStar_Options.detail_hint_replay ()) in
      if uu____2013
      then
        match z3result.FStar_SMTEncoding_Z3.z3result_status with
        | FStar_SMTEncoding_Z3.UNSAT uu____2016 -> ()
        | _failed ->
            let ask_z3 label_assumptions =
              let uu____2028 =
                with_fuel_and_diagnostics settings label_assumptions in
              FStar_SMTEncoding_Z3.ask settings.query_range
                (filter_assertions settings.query_env settings.query_hint)
                settings.query_hash settings.query_all_labels uu____2028
                FStar_Pervasives_Native.None false in
            FStar_SMTEncoding_ErrorReporting.detail_errors true
              settings.query_env settings.query_all_labels ask_z3
      else ()
let (find_localized_errors :
  errors Prims.list -> errors FStar_Pervasives_Native.option) =
  fun errs ->
    FStar_All.pipe_right errs
      (FStar_List.tryFind
         (fun err ->
            match err.error_messages with | [] -> false | uu____2062 -> true))
let (errors_to_report : query_settings -> FStar_Errors.error Prims.list) =
  fun settings ->
    let format_smt_error msg =
      FStar_Util.format1
        "SMT solver says:\n\t%s;\n\tNote: 'canceled' or 'resource limits reached' means the SMT query timed out, so you might want to increase the rlimit;\n\t'incomplete quantifiers' means a (partial) counterexample was found, so try to spell your proof out in greater detail, increase fuel or ifuel\n\t'unknown' means Z3 provided no further reason for the proof failing"
        msg in
    let basic_errors =
      let smt_error =
        let uu____2103 = FStar_Options.query_stats () in
        if uu____2103
        then
          let uu____2112 =
            let uu____2114 =
              let uu____2116 =
                FStar_All.pipe_right settings.query_errors
                  (FStar_List.map error_to_short_string) in
              FStar_All.pipe_right uu____2116 (FStar_String.concat ";\n\t") in
            FStar_All.pipe_right uu____2114 format_smt_error in
          FStar_All.pipe_right uu____2112
            (fun uu____2142 -> FStar_Util.Inr uu____2142)
        else
          (let uu____2145 =
             FStar_List.fold_left
               (fun uu____2170 ->
                  fun err ->
                    match uu____2170 with
                    | (ic, cc, uc) ->
                        let err1 =
                          FStar_Util.substring_from err.error_reason
                            (FStar_String.length "unknown because ") in
                        if
                          ((FStar_Util.starts_with err1 "canceled") ||
                             (FStar_Util.starts_with err1 "(resource"))
                            || (FStar_Util.starts_with err1 "timeout")
                        then (ic, (cc + Prims.int_one), uc)
                        else
                          if FStar_Util.starts_with err1 "(incomplete"
                          then ((ic + Prims.int_one), cc, uc)
                          else (ic, cc, (uc + Prims.int_one)))
               (Prims.int_zero, Prims.int_zero, Prims.int_zero)
               settings.query_errors in
           match uu____2145 with
           | (incomplete_count, canceled_count, unknown_count) ->
               FStar_All.pipe_right
                 (match (incomplete_count, canceled_count, unknown_count)
                  with
                  | (uu____2275, uu____2280, uu____2281) when
                      ((uu____2280 = Prims.int_zero) &&
                         (uu____2281 = Prims.int_zero))
                        && (incomplete_count > Prims.int_zero)
                      ->
                      "The solver found a (partial) counterexample, try to spell your proof in more detail or increase fuel/ifuel"
                  | (uu____2288, uu____2284, uu____2290) when
                      ((uu____2288 = Prims.int_zero) &&
                         (uu____2290 = Prims.int_zero))
                        && (canceled_count > Prims.int_zero)
                      ->
                      "The SMT query timed out, you might want to increase the rlimit"
                  | (uu____2293, uu____2294, uu____2295) ->
                      "Try with --query_stats to get more details")
                 (fun uu____2305 -> FStar_Util.Inl uu____2305)) in
      let uu____2306 = find_localized_errors settings.query_errors in
      match uu____2306 with
      | FStar_Pervasives_Native.Some err ->
          FStar_TypeChecker_Err.errors_smt_detail settings.query_env
            err.error_messages smt_error
      | FStar_Pervasives_Native.None ->
          FStar_TypeChecker_Err.errors_smt_detail settings.query_env
            [(FStar_Errors.Error_UnknownFatal_AssertionFailure,
               "Unknown assertion failed", (settings.query_range))] smt_error in
    (let uu____2329 = FStar_Options.detail_errors () in
     if uu____2329
     then
       let initial_fuel =
         let uu___252_2333 = settings in
         let uu____2334 = FStar_Options.initial_fuel () in
         let uu____2336 = FStar_Options.initial_ifuel () in
         {
           query_env = (uu___252_2333.query_env);
           query_decl = (uu___252_2333.query_decl);
           query_name = (uu___252_2333.query_name);
           query_index = (uu___252_2333.query_index);
           query_range = (uu___252_2333.query_range);
           query_fuel = uu____2334;
           query_ifuel = uu____2336;
           query_rlimit = (uu___252_2333.query_rlimit);
           query_hint = FStar_Pervasives_Native.None;
           query_errors = (uu___252_2333.query_errors);
           query_all_labels = (uu___252_2333.query_all_labels);
           query_suffix = (uu___252_2333.query_suffix);
           query_hash = (uu___252_2333.query_hash)
         } in
       let ask_z3 label_assumptions =
         let uu____2351 =
           with_fuel_and_diagnostics initial_fuel label_assumptions in
         FStar_SMTEncoding_Z3.ask settings.query_range
           (filter_facts_without_core settings.query_env) settings.query_hash
           settings.query_all_labels uu____2351 FStar_Pervasives_Native.None
           false in
       FStar_SMTEncoding_ErrorReporting.detail_errors false
         settings.query_env settings.query_all_labels ask_z3
     else ());
    basic_errors
let (report_errors : query_settings -> unit) =
  fun qry_settings ->
    let uu____2364 = errors_to_report qry_settings in
    FStar_Errors.add_errors uu____2364
let (query_info : query_settings -> FStar_SMTEncoding_Z3.z3result -> unit) =
  fun settings ->
    fun z3result ->
      let process_unsat_core core =
        let accumulator uu____2410 =
          let r = FStar_Util.mk_ref [] in
          let uu____2421 =
            let module_names = FStar_Util.mk_ref [] in
            ((fun m ->
                let ms = FStar_ST.op_Bang module_names in
                if FStar_List.contains m ms
                then ()
                else FStar_ST.op_Colon_Equals module_names (m :: ms)),
              (fun uu____2521 ->
                 let uu____2522 = FStar_ST.op_Bang module_names in
                 FStar_All.pipe_right uu____2522
                   (FStar_Util.sort_with FStar_String.compare))) in
          match uu____2421 with | (add, get) -> (add, get) in
        let uu____2604 = accumulator () in
        match uu____2604 with
        | (add_module_name, get_module_names) ->
            let uu____2641 = accumulator () in
            (match uu____2641 with
             | (add_discarded_name, get_discarded_names) ->
                 let parse_axiom_name s =
                   let chars = FStar_String.list_of_string s in
                   let first_upper_index =
                     FStar_Util.try_find_index FStar_Util.is_upper chars in
                   match first_upper_index with
                   | FStar_Pervasives_Native.None ->
                       (add_discarded_name s; [])
                   | FStar_Pervasives_Native.Some first_upper_index1 ->
                       let name_and_suffix =
                         FStar_Util.substring_from s first_upper_index1 in
                       let components =
                         FStar_String.split [46] name_and_suffix in
                       let excluded_suffixes =
                         ["fuel_instrumented";
                         "_pretyping";
                         "_Tm_refine";
                         "_Tm_abs";
                         "@";
                         "_interpretation_Tm_arrow";
                         "MaxFuel_assumption";
                         "MaxIFuel_assumption"] in
                       let exclude_suffix s1 =
                         let s2 = FStar_Util.trim_string s1 in
                         let sopt =
                           FStar_Util.find_map excluded_suffixes
                             (fun sfx ->
                                if FStar_Util.contains s2 sfx
                                then
                                  let uu____2764 =
                                    FStar_List.hd (FStar_Util.split s2 sfx) in
                                  FStar_Pervasives_Native.Some uu____2764
                                else FStar_Pervasives_Native.None) in
                         match sopt with
                         | FStar_Pervasives_Native.None ->
                             if s2 = "" then [] else [s2]
                         | FStar_Pervasives_Native.Some s3 ->
                             if s3 = "" then [] else [s3] in
                       let components1 =
                         match components with
                         | [] -> []
                         | uu____2809 ->
                             let uu____2813 = FStar_Util.prefix components in
                             (match uu____2813 with
                              | (module_name, last) ->
                                  let components1 =
                                    let uu____2840 = exclude_suffix last in
                                    FStar_List.append module_name uu____2840 in
                                  ((match components1 with
                                    | [] -> ()
                                    | uu____2847::[] -> ()
                                    | uu____2851 ->
                                        add_module_name
                                          (FStar_String.concat "."
                                             module_name));
                                   components1)) in
                       if components1 = []
                       then (add_discarded_name s; [])
                       else
                         (let uu____2868 =
                            FStar_All.pipe_right components1
                              (FStar_String.concat ".") in
                          [uu____2868]) in
                 (match core with
                  | FStar_Pervasives_Native.None ->
                      FStar_Util.print_string "no unsat core\n"
                  | FStar_Pervasives_Native.Some core1 ->
                      let core2 = FStar_List.collect parse_axiom_name core1 in
                      ((let uu____2895 =
                          let uu____2897 = get_module_names () in
                          FStar_All.pipe_right uu____2897
                            (FStar_String.concat "\nZ3 Proof Stats:\t") in
                        FStar_Util.print1
                          "Z3 Proof Stats: Modules relevant to this proof:\nZ3 Proof Stats:\t%s\n"
                          uu____2895);
                       FStar_Util.print1
                         "Z3 Proof Stats (Detail 1): Specifically:\nZ3 Proof Stats (Detail 1):\t%s\n"
                         (FStar_String.concat
                            "\nZ3 Proof Stats (Detail 1):\t" core2);
                       (let uu____2910 =
                          let uu____2912 = get_discarded_names () in
                          FStar_All.pipe_right uu____2912
                            (FStar_String.concat ", ") in
                        FStar_Util.print1
                          "Z3 Proof Stats (Detail 2): Note, this report ignored the following names in the context: %s\n"
                          uu____2910)))) in
      let uu____2922 =
        (FStar_Options.hint_info ()) || (FStar_Options.query_stats ()) in
      if uu____2922
      then
        let uu____2925 =
          FStar_SMTEncoding_Z3.status_string_and_errors
            z3result.FStar_SMTEncoding_Z3.z3result_status in
        match uu____2925 with
        | (status_string, errs) ->
            let at_log_file =
              match z3result.FStar_SMTEncoding_Z3.z3result_log_file with
              | FStar_Pervasives_Native.None -> ""
              | FStar_Pervasives_Native.Some s -> Prims.op_Hat "@" s in
            let uu____2944 =
              match z3result.FStar_SMTEncoding_Z3.z3result_status with
              | FStar_SMTEncoding_Z3.UNSAT core -> ("succeeded", core)
              | uu____2958 ->
                  ((Prims.op_Hat "failed {reason-unknown="
                      (Prims.op_Hat status_string "}")),
                    FStar_Pervasives_Native.None) in
            (match uu____2944 with
             | (tag, core) ->
                 let range =
                   let uu____2971 =
                     let uu____2973 =
                       FStar_Range.string_of_range settings.query_range in
                     Prims.op_Hat uu____2973 (Prims.op_Hat at_log_file ")") in
                   Prims.op_Hat "(" uu____2971 in
                 let used_hint_tag =
                   if used_hint settings then " (with hint)" else "" in
                 let stats =
                   let uu____2987 = FStar_Options.query_stats () in
                   if uu____2987
                   then
                     let f k v a =
                       Prims.op_Hat a
                         (Prims.op_Hat k
                            (Prims.op_Hat "=" (Prims.op_Hat v " "))) in
                     let str =
                       FStar_Util.smap_fold
                         z3result.FStar_SMTEncoding_Z3.z3result_statistics f
                         "statistics={" in
                     let uu____3021 =
                       FStar_Util.substring str Prims.int_zero
                         ((FStar_String.length str) - Prims.int_one) in
                     Prims.op_Hat uu____3021 "}"
                   else "" in
                 ((let uu____3030 =
                     let uu____3034 =
                       let uu____3038 =
                         let uu____3042 =
                           FStar_Util.string_of_int settings.query_index in
                         let uu____3044 =
                           let uu____3048 =
                             let uu____3052 =
                               let uu____3056 =
                                 FStar_Util.string_of_int
                                   z3result.FStar_SMTEncoding_Z3.z3result_time in
                               let uu____3058 =
                                 let uu____3062 =
                                   FStar_Util.string_of_int
                                     settings.query_fuel in
                                 let uu____3064 =
                                   let uu____3068 =
                                     FStar_Util.string_of_int
                                       settings.query_ifuel in
                                   let uu____3070 =
                                     let uu____3074 =
                                       FStar_Util.string_of_int
                                         settings.query_rlimit in
                                     [uu____3074; stats] in
                                   uu____3068 :: uu____3070 in
                                 uu____3062 :: uu____3064 in
                               uu____3056 :: uu____3058 in
                             used_hint_tag :: uu____3052 in
                           tag :: uu____3048 in
                         uu____3042 :: uu____3044 in
                       (settings.query_name) :: uu____3038 in
                     range :: uu____3034 in
                   FStar_Util.print
                     "%s\tQuery-stats (%s, %s)\t%s%s in %s milliseconds with fuel %s and ifuel %s and rlimit %s %s\n"
                     uu____3030);
                  (let uu____3089 = FStar_Options.print_z3_statistics () in
                   if uu____3089 then process_unsat_core core else ());
                  FStar_All.pipe_right errs
                    (FStar_List.iter
                       (fun uu____3115 ->
                          match uu____3115 with
                          | (uu____3123, msg, range1) ->
                              let tag1 =
                                if used_hint settings
                                then "(Hint-replay failed): "
                                else "" in
                              FStar_Errors.log_issue range1
                                (FStar_Errors.Warning_HitReplayFailed,
                                  (Prims.op_Hat tag1 msg))))))
      else ()
let (store_hint : FStar_Util.hint -> unit) =
  fun hint ->
    let uu____3145 = FStar_ST.op_Bang recorded_hints in
    match uu____3145 with
    | FStar_Pervasives_Native.Some l ->
        FStar_ST.op_Colon_Equals recorded_hints
          (FStar_Pervasives_Native.Some
             (FStar_List.append l [FStar_Pervasives_Native.Some hint]))
    | uu____3201 -> ()
let (record_hint : query_settings -> FStar_SMTEncoding_Z3.z3result -> unit) =
  fun settings ->
    fun z3result ->
      let uu____3216 =
        let uu____3218 = FStar_Options.record_hints () in
        Prims.op_Negation uu____3218 in
      if uu____3216
      then ()
      else
        (let mk_hint core =
           {
             FStar_Util.hint_name = (settings.query_name);
             FStar_Util.hint_index = (settings.query_index);
             FStar_Util.fuel = (settings.query_fuel);
             FStar_Util.ifuel = (settings.query_ifuel);
             FStar_Util.unsat_core = core;
             FStar_Util.query_elapsed_time = Prims.int_zero;
             FStar_Util.hash =
               (match z3result.FStar_SMTEncoding_Z3.z3result_status with
                | FStar_SMTEncoding_Z3.UNSAT core1 ->
                    z3result.FStar_SMTEncoding_Z3.z3result_query_hash
                | uu____3245 -> FStar_Pervasives_Native.None)
           } in
         match z3result.FStar_SMTEncoding_Z3.z3result_status with
         | FStar_SMTEncoding_Z3.UNSAT (FStar_Pervasives_Native.None) ->
             let uu____3250 =
               let uu____3251 =
                 get_hint_for settings.query_name settings.query_index in
               FStar_Option.get uu____3251 in
             store_hint uu____3250
         | FStar_SMTEncoding_Z3.UNSAT unsat_core ->
             if used_hint settings
             then store_hint (mk_hint settings.query_hint)
             else store_hint (mk_hint unsat_core)
         | uu____3258 -> ())
let (process_result :
  query_settings ->
    FStar_SMTEncoding_Z3.z3result -> errors FStar_Pervasives_Native.option)
  =
  fun settings ->
    fun result ->
      let errs = query_errors settings result in
      query_info settings result;
      record_hint settings result;
      detail_hint_replay settings result;
      errs
let (fold_queries :
  query_settings Prims.list ->
    (query_settings -> FStar_SMTEncoding_Z3.z3result) ->
      (query_settings ->
         FStar_SMTEncoding_Z3.z3result ->
           errors FStar_Pervasives_Native.option)
        -> (errors Prims.list, query_settings) FStar_Util.either)
  =
  fun qs ->
    fun ask ->
      fun f ->
        let rec aux acc qs1 =
          match qs1 with
          | [] -> FStar_Util.Inl acc
          | q::qs2 ->
              let res = ask q in
              let uu____3369 = f q res in
              (match uu____3369 with
               | FStar_Pervasives_Native.None -> FStar_Util.Inr q
               | FStar_Pervasives_Native.Some errs -> aux (errs :: acc) qs2) in
        aux [] qs
let (full_query_id : query_settings -> Prims.string) =
  fun settings ->
    let uu____3388 =
      let uu____3390 =
        let uu____3392 =
          let uu____3394 = FStar_Util.string_of_int settings.query_index in
          Prims.op_Hat uu____3394 ")" in
        Prims.op_Hat ", " uu____3392 in
      Prims.op_Hat settings.query_name uu____3390 in
    Prims.op_Hat "(" uu____3388
let collect : 'a . 'a Prims.list -> ('a * Prims.int) Prims.list =
  fun l ->
    let acc = [] in
    let rec add_one acc1 x =
      match acc1 with
      | [] -> [(x, Prims.int_one)]
      | (h, n)::t ->
          if h = x
          then (h, (n + Prims.int_one)) :: t
          else (let uu____3524 = add_one t x in (h, n) :: uu____3524) in
    FStar_List.fold_left add_one acc l
let (ask_and_report_errors :
  FStar_TypeChecker_Env.env ->
    FStar_SMTEncoding_Term.error_labels ->
      FStar_SMTEncoding_Term.decl Prims.list ->
        FStar_SMTEncoding_Term.decl ->
          FStar_SMTEncoding_Term.decl Prims.list -> unit)
  =
  fun env ->
    fun all_labels ->
      fun prefix ->
        fun query ->
          fun suffix ->
            FStar_SMTEncoding_Z3.giveZ3 prefix;
            (let uu____3580 =
               let uu____3587 =
                 match env.FStar_TypeChecker_Env.qtbl_name_and_index with
                 | (uu____3600, FStar_Pervasives_Native.None) ->
                     failwith "No query name set!"
                 | (uu____3626, FStar_Pervasives_Native.Some (q, n)) ->
                     let uu____3649 = FStar_Ident.string_of_lid q in
                     (uu____3649, n) in
               match uu____3587 with
               | (qname, index) ->
                   let rlimit =
                     let uu____3667 = FStar_Options.z3_rlimit_factor () in
                     let uu____3669 =
                       let uu____3671 = FStar_Options.z3_rlimit () in
                       uu____3671 * (Prims.parse_int "544656") in
                     uu____3667 * uu____3669 in
                   let next_hint = get_hint_for qname index in
                   let default_settings =
                     let uu____3678 = FStar_TypeChecker_Env.get_range env in
                     let uu____3679 = FStar_Options.initial_fuel () in
                     let uu____3681 = FStar_Options.initial_ifuel () in
                     {
                       query_env = env;
                       query_decl = query;
                       query_name = qname;
                       query_index = index;
                       query_range = uu____3678;
                       query_fuel = uu____3679;
                       query_ifuel = uu____3681;
                       query_rlimit = rlimit;
                       query_hint = FStar_Pervasives_Native.None;
                       query_errors = [];
                       query_all_labels = all_labels;
                       query_suffix = suffix;
                       query_hash =
                         (match next_hint with
                          | FStar_Pervasives_Native.None ->
                              FStar_Pervasives_Native.None
                          | FStar_Pervasives_Native.Some
                              { FStar_Util.hint_name = uu____3690;
                                FStar_Util.hint_index = uu____3691;
                                FStar_Util.fuel = uu____3692;
                                FStar_Util.ifuel = uu____3693;
                                FStar_Util.unsat_core = uu____3694;
                                FStar_Util.query_elapsed_time = uu____3695;
                                FStar_Util.hash = h;_}
                              -> h)
                     } in
                   (default_settings, next_hint) in
             match uu____3580 with
             | (default_settings, next_hint) ->
                 let use_hints_setting =
                   let uu____3721 =
                     (FStar_Options.use_hints ()) &&
                       (FStar_All.pipe_right next_hint FStar_Util.is_some) in
                   if uu____3721
                   then
                     let uu____3729 =
                       FStar_All.pipe_right next_hint FStar_Util.must in
                     match uu____3729 with
                     | { FStar_Util.hint_name = uu____3734;
                         FStar_Util.hint_index = uu____3735;
                         FStar_Util.fuel = i; FStar_Util.ifuel = j;
                         FStar_Util.unsat_core = FStar_Pervasives_Native.Some
                           core;
                         FStar_Util.query_elapsed_time = uu____3739;
                         FStar_Util.hash = h;_} ->
                         [(let uu___452_3756 = default_settings in
                           {
                             query_env = (uu___452_3756.query_env);
                             query_decl = (uu___452_3756.query_decl);
                             query_name = (uu___452_3756.query_name);
                             query_index = (uu___452_3756.query_index);
                             query_range = (uu___452_3756.query_range);
                             query_fuel = i;
                             query_ifuel = j;
                             query_rlimit = (uu___452_3756.query_rlimit);
                             query_hint = (FStar_Pervasives_Native.Some core);
                             query_errors = (uu___452_3756.query_errors);
                             query_all_labels =
                               (uu___452_3756.query_all_labels);
                             query_suffix = (uu___452_3756.query_suffix);
                             query_hash = (uu___452_3756.query_hash)
                           })]
                   else [] in
                 let initial_fuel_max_ifuel =
                   let uu____3765 =
                     let uu____3767 = FStar_Options.max_ifuel () in
                     let uu____3769 = FStar_Options.initial_ifuel () in
                     uu____3767 > uu____3769 in
                   if uu____3765
                   then
                     let uu____3774 =
                       let uu___456_3775 = default_settings in
                       let uu____3776 = FStar_Options.max_ifuel () in
                       {
                         query_env = (uu___456_3775.query_env);
                         query_decl = (uu___456_3775.query_decl);
                         query_name = (uu___456_3775.query_name);
                         query_index = (uu___456_3775.query_index);
                         query_range = (uu___456_3775.query_range);
                         query_fuel = (uu___456_3775.query_fuel);
                         query_ifuel = uu____3776;
                         query_rlimit = (uu___456_3775.query_rlimit);
                         query_hint = (uu___456_3775.query_hint);
                         query_errors = (uu___456_3775.query_errors);
                         query_all_labels = (uu___456_3775.query_all_labels);
                         query_suffix = (uu___456_3775.query_suffix);
                         query_hash = (uu___456_3775.query_hash)
                       } in
                     [uu____3774]
                   else [] in
                 let half_max_fuel_max_ifuel =
                   let uu____3783 =
                     let uu____3785 =
                       let uu____3787 = FStar_Options.max_fuel () in
                       uu____3787 / (Prims.of_int (2)) in
                     let uu____3790 = FStar_Options.initial_fuel () in
                     uu____3785 > uu____3790 in
                   if uu____3783
                   then
                     let uu____3795 =
                       let uu___460_3796 = default_settings in
                       let uu____3797 =
                         let uu____3799 = FStar_Options.max_fuel () in
                         uu____3799 / (Prims.of_int (2)) in
                       let uu____3802 = FStar_Options.max_ifuel () in
                       {
                         query_env = (uu___460_3796.query_env);
                         query_decl = (uu___460_3796.query_decl);
                         query_name = (uu___460_3796.query_name);
                         query_index = (uu___460_3796.query_index);
                         query_range = (uu___460_3796.query_range);
                         query_fuel = uu____3797;
                         query_ifuel = uu____3802;
                         query_rlimit = (uu___460_3796.query_rlimit);
                         query_hint = (uu___460_3796.query_hint);
                         query_errors = (uu___460_3796.query_errors);
                         query_all_labels = (uu___460_3796.query_all_labels);
                         query_suffix = (uu___460_3796.query_suffix);
                         query_hash = (uu___460_3796.query_hash)
                       } in
                     [uu____3795]
                   else [] in
                 let max_fuel_max_ifuel =
                   let uu____3809 =
                     (let uu____3815 = FStar_Options.max_fuel () in
                      let uu____3817 = FStar_Options.initial_fuel () in
                      uu____3815 > uu____3817) &&
                       (let uu____3821 = FStar_Options.max_ifuel () in
                        let uu____3823 = FStar_Options.initial_ifuel () in
                        uu____3821 >= uu____3823) in
                   if uu____3809
                   then
                     let uu____3828 =
                       let uu___464_3829 = default_settings in
                       let uu____3830 = FStar_Options.max_fuel () in
                       let uu____3832 = FStar_Options.max_ifuel () in
                       {
                         query_env = (uu___464_3829.query_env);
                         query_decl = (uu___464_3829.query_decl);
                         query_name = (uu___464_3829.query_name);
                         query_index = (uu___464_3829.query_index);
                         query_range = (uu___464_3829.query_range);
                         query_fuel = uu____3830;
                         query_ifuel = uu____3832;
                         query_rlimit = (uu___464_3829.query_rlimit);
                         query_hint = (uu___464_3829.query_hint);
                         query_errors = (uu___464_3829.query_errors);
                         query_all_labels = (uu___464_3829.query_all_labels);
                         query_suffix = (uu___464_3829.query_suffix);
                         query_hash = (uu___464_3829.query_hash)
                       } in
                     [uu____3828]
                   else [] in
                 let min_fuel =
                   let uu____3839 =
                     let uu____3841 = FStar_Options.min_fuel () in
                     let uu____3843 = FStar_Options.initial_fuel () in
                     uu____3841 < uu____3843 in
                   if uu____3839
                   then
                     let uu____3848 =
                       let uu___468_3849 = default_settings in
                       let uu____3850 = FStar_Options.min_fuel () in
                       {
                         query_env = (uu___468_3849.query_env);
                         query_decl = (uu___468_3849.query_decl);
                         query_name = (uu___468_3849.query_name);
                         query_index = (uu___468_3849.query_index);
                         query_range = (uu___468_3849.query_range);
                         query_fuel = uu____3850;
                         query_ifuel = Prims.int_one;
                         query_rlimit = (uu___468_3849.query_rlimit);
                         query_hint = (uu___468_3849.query_hint);
                         query_errors = (uu___468_3849.query_errors);
                         query_all_labels = (uu___468_3849.query_all_labels);
                         query_suffix = (uu___468_3849.query_suffix);
                         query_hash = (uu___468_3849.query_hash)
                       } in
                     [uu____3848]
                   else [] in
                 let all_configs =
                   FStar_List.append use_hints_setting
                     (FStar_List.append [default_settings]
                        (FStar_List.append initial_fuel_max_ifuel
                           (FStar_List.append half_max_fuel_max_ifuel
                              max_fuel_max_ifuel))) in
                 let check_one_config config =
                   (let uu____3865 = FStar_Options.z3_refresh () in
                    if uu____3865
                    then FStar_SMTEncoding_Z3.refresh ()
                    else ());
                   (let uu____3870 = with_fuel_and_diagnostics config [] in
                    let uu____3873 =
                      let uu____3876 = FStar_SMTEncoding_Z3.mk_fresh_scope () in
                      FStar_Pervasives_Native.Some uu____3876 in
                    FStar_SMTEncoding_Z3.ask config.query_range
                      (filter_assertions config.query_env config.query_hint)
                      config.query_hash config.query_all_labels uu____3870
                      uu____3873 (used_hint config)) in
                 let check_all_configs configs =
                   fold_queries configs check_one_config process_result in
                 let quake_and_check_all_configs configs =
                   let lo = FStar_Options.quake_lo () in
                   let hi = FStar_Options.quake_hi () in
                   let seed = FStar_Options.z3_seed () in
                   let name = full_query_id default_settings in
                   let quaking =
                     (hi > Prims.int_one) &&
                       (let uu____3921 = FStar_Options.retry () in
                        Prims.op_Negation uu____3921) in
                   let quaking_or_retrying = hi > Prims.int_one in
                   let hi1 = if hi < Prims.int_one then Prims.int_one else hi in
                   let lo1 =
                     if lo < Prims.int_one
                     then Prims.int_one
                     else if lo > hi1 then hi1 else lo in
                   let run_one seed1 =
                     let uu____3960 = FStar_Options.z3_refresh () in
                     if uu____3960
                     then
                       FStar_Options.with_saved_options
                         (fun uu____3977 ->
                            FStar_Options.set_option "z3seed"
                              (FStar_Options.Int seed1);
                            check_all_configs configs)
                     else check_all_configs configs in
                   let rec fold_nat' f acc lo2 hi2 =
                     if lo2 > hi2
                     then acc
                     else
                       (let uu____4033 = f acc lo2 in
                        fold_nat' f uu____4033 (lo2 + Prims.int_one) hi2) in
                   let best_fuel =
                     FStar_Util.mk_ref FStar_Pervasives_Native.None in
                   let best_ifuel =
                     FStar_Util.mk_ref FStar_Pervasives_Native.None in
                   let maybe_improve r n =
                     let uu____4156 = FStar_ST.op_Bang r in
                     match uu____4156 with
                     | FStar_Pervasives_Native.None ->
                         FStar_ST.op_Colon_Equals r
                           (FStar_Pervasives_Native.Some n)
                     | FStar_Pervasives_Native.Some m ->
                         if n < m
                         then
                           FStar_ST.op_Colon_Equals r
                             (FStar_Pervasives_Native.Some n)
                         else () in
                   let uu____4244 =
                     fold_nat'
                       (fun uu____4283 ->
                          fun n ->
                            match uu____4283 with
                            | (nsucc, nfail, rs) ->
                                let uu____4341 =
                                  (let uu____4345 =
                                     FStar_Options.quake_keep () in
                                   Prims.op_Negation uu____4345) &&
                                    ((nsucc >= lo1) || (nfail > (hi1 - lo1))) in
                                if uu____4341
                                then (nsucc, nfail, rs)
                                else
                                  ((let uu____4377 =
                                      (quaking_or_retrying &&
                                         ((FStar_Options.interactive ()) ||
                                            (FStar_Options.debug_any ())))
                                        && (n > Prims.int_zero) in
                                    if uu____4377
                                    then
                                      let uu____4381 =
                                        if quaking
                                        then
                                          let uu____4385 =
                                            FStar_Util.string_of_int nsucc in
                                          FStar_Util.format1
                                            "succeeded %s times and "
                                            uu____4385
                                        else "" in
                                      let uu____4391 =
                                        if quaking
                                        then FStar_Util.string_of_int nfail
                                        else
                                          (let uu____4397 =
                                             FStar_Util.string_of_int nfail in
                                           Prims.op_Hat uu____4397 " times") in
                                      let uu____4400 =
                                        FStar_Util.string_of_int (hi1 - n) in
                                      FStar_Util.print5
                                        "%s: so far query %s %sfailed %s (%s runs remain)\n"
                                        (if quaking then "Quake" else "Retry")
                                        name uu____4381 uu____4391 uu____4400
                                    else ());
                                   (let r = run_one (seed + n) in
                                    let uu____4418 =
                                      match r with
                                      | FStar_Util.Inr cfg ->
                                          (maybe_improve best_fuel
                                             cfg.query_fuel;
                                           maybe_improve best_ifuel
                                             cfg.query_ifuel;
                                           ((nsucc + Prims.int_one), nfail))
                                      | uu____4439 ->
                                          (nsucc, (nfail + Prims.int_one)) in
                                    match uu____4418 with
                                    | (nsucc1, nfail1) ->
                                        (nsucc1, nfail1, (r :: rs)))))
                       (Prims.int_zero, Prims.int_zero, []) Prims.int_zero
                       (hi1 - Prims.int_one) in
                   match uu____4244 with
                   | (nsuccess, nfailures, rs) ->
                       let total_ran = nsuccess + nfailures in
                       (if quaking
                        then
                          (let fuel_msg =
                             let uu____4536 =
                               let uu____4547 = FStar_ST.op_Bang best_fuel in
                               let uu____4576 = FStar_ST.op_Bang best_ifuel in
                               (uu____4547, uu____4576) in
                             match uu____4536 with
                             | (FStar_Pervasives_Native.Some f,
                                FStar_Pervasives_Native.Some i) ->
                                 let uu____4624 = FStar_Util.string_of_int f in
                                 let uu____4626 = FStar_Util.string_of_int i in
                                 FStar_Util.format2
                                   " (best fuel=%s, best ifuel=%s)"
                                   uu____4624 uu____4626
                             | (uu____4629, uu____4630) -> "" in
                           let uu____4644 = FStar_Util.string_of_int nsuccess in
                           let uu____4646 =
                             FStar_Util.string_of_int total_ran in
                           FStar_Util.print5
                             "Quake: query %s succeeded %s/%s times%s%s\n"
                             name uu____4644 uu____4646
                             (if total_ran < hi1
                              then " (early finish)"
                              else "") fuel_msg)
                        else ();
                        if nsuccess < lo1
                        then
                          (let all_errs =
                             FStar_List.concatMap
                               (fun uu___4_4673 ->
                                  match uu___4_4673 with
                                  | FStar_Util.Inr uu____4684 -> []
                                  | FStar_Util.Inl es -> [es]) rs in
                           let uu____4698 =
                             quaking_or_retrying &&
                               (let uu____4701 = FStar_Options.query_stats () in
                                Prims.op_Negation uu____4701) in
                           if uu____4698
                           then
                             let errors_to_report1 errs =
                               errors_to_report
                                 (let uu___559_4718 = default_settings in
                                  {
                                    query_env = (uu___559_4718.query_env);
                                    query_decl = (uu___559_4718.query_decl);
                                    query_name = (uu___559_4718.query_name);
                                    query_index = (uu___559_4718.query_index);
                                    query_range = (uu___559_4718.query_range);
                                    query_fuel = (uu___559_4718.query_fuel);
                                    query_ifuel = (uu___559_4718.query_ifuel);
                                    query_rlimit =
                                      (uu___559_4718.query_rlimit);
                                    query_hint = (uu___559_4718.query_hint);
                                    query_errors = errs;
                                    query_all_labels =
                                      (uu___559_4718.query_all_labels);
                                    query_suffix =
                                      (uu___559_4718.query_suffix);
                                    query_hash = (uu___559_4718.query_hash)
                                  }) in
                             let errs =
                               FStar_List.map errors_to_report1 all_errs in
                             let errs1 =
                               let uu____4743 =
                                 FStar_All.pipe_right errs FStar_List.flatten in
                               FStar_All.pipe_right uu____4743 collect in
                             let errs2 =
                               FStar_All.pipe_right errs1
                                 (FStar_List.map
                                    (fun uu____4826 ->
                                       match uu____4826 with
                                       | ((e, m, r), n) ->
                                           if n > Prims.int_one
                                           then
                                             let uu____4870 =
                                               let uu____4872 =
                                                 let uu____4874 =
                                                   FStar_Util.string_of_int n in
                                                 FStar_Util.format1
                                                   " (%s times)" uu____4874 in
                                               Prims.op_Hat m uu____4872 in
                                             (e, uu____4870, r)
                                           else (e, m, r))) in
                             (FStar_Errors.add_errors errs2;
                              (let rng =
                                 match FStar_Pervasives_Native.snd
                                         env.FStar_TypeChecker_Env.qtbl_name_and_index
                                 with
                                 | FStar_Pervasives_Native.Some
                                     (l, uu____4894) ->
                                     FStar_Ident.range_of_lid l
                                 | uu____4902 -> FStar_Range.dummyRange in
                               if quaking
                               then
                                 let uu____4911 =
                                   let uu____4921 =
                                     let uu____4929 =
                                       let uu____4931 =
                                         FStar_Util.string_of_int nsuccess in
                                       let uu____4933 =
                                         FStar_Util.string_of_int total_ran in
                                       let uu____4935 =
                                         FStar_Util.string_of_int lo1 in
                                       let uu____4937 =
                                         FStar_Util.string_of_int hi1 in
                                       FStar_Util.format6
                                         "Query %s failed the quake test, %s out of %s attempts succeded, but the threshold was %s out of %s%s"
                                         name uu____4931 uu____4933
                                         uu____4935 uu____4937
                                         (if total_ran < hi1
                                          then " (early abort)"
                                          else "") in
                                     (FStar_Errors.Error_QuakeFailed,
                                       uu____4929, rng) in
                                   [uu____4921] in
                                 FStar_TypeChecker_Err.add_errors env
                                   uu____4911
                               else ()))
                           else
                             (let report errs =
                                report_errors
                                  (let uu___582_4977 = default_settings in
                                   {
                                     query_env = (uu___582_4977.query_env);
                                     query_decl = (uu___582_4977.query_decl);
                                     query_name = (uu___582_4977.query_name);
                                     query_index =
                                       (uu___582_4977.query_index);
                                     query_range =
                                       (uu___582_4977.query_range);
                                     query_fuel = (uu___582_4977.query_fuel);
                                     query_ifuel =
                                       (uu___582_4977.query_ifuel);
                                     query_rlimit =
                                       (uu___582_4977.query_rlimit);
                                     query_hint = (uu___582_4977.query_hint);
                                     query_errors = errs;
                                     query_all_labels =
                                       (uu___582_4977.query_all_labels);
                                     query_suffix =
                                       (uu___582_4977.query_suffix);
                                     query_hash = (uu___582_4977.query_hash)
                                   }) in
                              FStar_List.iter report all_errs))
                        else ()) in
                 let skip =
                   (FStar_Options.admit_smt_queries ()) ||
                     (let uu____4987 = FStar_Options.admit_except () in
                      match uu____4987 with
                      | FStar_Pervasives_Native.Some id ->
                          if FStar_Util.starts_with id "("
                          then
                            let uu____4998 = full_query_id default_settings in
                            uu____4998 <> id
                          else default_settings.query_name <> id
                      | FStar_Pervasives_Native.None -> false) in
                 if skip
                 then
                   let uu____5007 =
                     (FStar_Options.record_hints ()) &&
                       (FStar_All.pipe_right next_hint FStar_Util.is_some) in
                   (if uu____5007
                    then
                      let uu____5013 =
                        FStar_All.pipe_right next_hint FStar_Util.must in
                      FStar_All.pipe_right uu____5013 store_hint
                    else ())
                 else quake_and_check_all_configs all_configs)
type solver_cfg =
  {
  seed: Prims.int ;
  cliopt: Prims.string Prims.list ;
  facts: (Prims.string Prims.list * Prims.bool) Prims.list ;
  valid_intro: Prims.bool ;
  valid_elim: Prims.bool }
let (__proj__Mksolver_cfg__item__seed : solver_cfg -> Prims.int) =
  fun projectee ->
    match projectee with
    | { seed; cliopt; facts; valid_intro; valid_elim;_} -> seed
let (__proj__Mksolver_cfg__item__cliopt :
  solver_cfg -> Prims.string Prims.list) =
  fun projectee ->
    match projectee with
    | { seed; cliopt; facts; valid_intro; valid_elim;_} -> cliopt
let (__proj__Mksolver_cfg__item__facts :
  solver_cfg -> (Prims.string Prims.list * Prims.bool) Prims.list) =
  fun projectee ->
    match projectee with
    | { seed; cliopt; facts; valid_intro; valid_elim;_} -> facts
let (__proj__Mksolver_cfg__item__valid_intro : solver_cfg -> Prims.bool) =
  fun projectee ->
    match projectee with
    | { seed; cliopt; facts; valid_intro; valid_elim;_} -> valid_intro
let (__proj__Mksolver_cfg__item__valid_elim : solver_cfg -> Prims.bool) =
  fun projectee ->
    match projectee with
    | { seed; cliopt; facts; valid_intro; valid_elim;_} -> valid_elim
let (_last_cfg : solver_cfg FStar_Pervasives_Native.option FStar_ST.ref) =
  FStar_Util.mk_ref FStar_Pervasives_Native.None
let (get_cfg : FStar_TypeChecker_Env.env -> solver_cfg) =
  fun env ->
    let uu____5241 = FStar_Options.z3_seed () in
    let uu____5243 = FStar_Options.z3_cliopt () in
    let uu____5247 = FStar_Options.smtencoding_valid_intro () in
    let uu____5249 = FStar_Options.smtencoding_valid_elim () in
    {
      seed = uu____5241;
      cliopt = uu____5243;
      facts = (env.FStar_TypeChecker_Env.proof_ns);
      valid_intro = uu____5247;
      valid_elim = uu____5249
    }
let (save_cfg : FStar_TypeChecker_Env.env -> unit) =
  fun env ->
    let uu____5257 =
      let uu____5260 = get_cfg env in FStar_Pervasives_Native.Some uu____5260 in
    FStar_ST.op_Colon_Equals _last_cfg uu____5257
let (should_refresh : FStar_TypeChecker_Env.env -> Prims.bool) =
  fun env ->
    let uu____5291 = FStar_ST.op_Bang _last_cfg in
    match uu____5291 with
    | FStar_Pervasives_Native.None -> (save_cfg env; false)
    | FStar_Pervasives_Native.Some cfg ->
        let uu____5321 = let uu____5323 = get_cfg env in cfg = uu____5323 in
        Prims.op_Negation uu____5321
let (do_solve :
  (unit -> Prims.string) FStar_Pervasives_Native.option ->
    FStar_TypeChecker_Env.env -> FStar_Syntax_Syntax.term -> unit)
  =
  fun use_env_msg ->
    fun tcenv ->
      fun q ->
        (let uu____5352 = should_refresh tcenv in
         if uu____5352
         then (save_cfg tcenv; FStar_SMTEncoding_Z3.refresh ())
         else ());
        (let uu____5359 =
           let uu____5361 =
             let uu____5363 = FStar_TypeChecker_Env.get_range tcenv in
             FStar_All.pipe_left FStar_Range.string_of_range uu____5363 in
           FStar_Util.format1 "Starting query at %s" uu____5361 in
         FStar_SMTEncoding_Encode.push uu____5359);
        (let pop uu____5371 =
           let uu____5372 =
             let uu____5374 =
               let uu____5376 = FStar_TypeChecker_Env.get_range tcenv in
               FStar_All.pipe_left FStar_Range.string_of_range uu____5376 in
             FStar_Util.format1 "Ending query at %s" uu____5374 in
           FStar_SMTEncoding_Encode.pop uu____5372 in
         try
           (fun uu___623_5392 ->
              match () with
              | () ->
                  let uu____5393 =
                    FStar_SMTEncoding_Encode.encode_query use_env_msg tcenv q in
                  (match uu____5393 with
                   | (prefix, labels, qry, suffix) ->
                       let tcenv1 =
                         FStar_TypeChecker_Env.incr_query_index tcenv in
                       (match qry with
                        | FStar_SMTEncoding_Term.Assume
                            {
                              FStar_SMTEncoding_Term.assumption_term =
                                {
                                  FStar_SMTEncoding_Term.tm =
                                    FStar_SMTEncoding_Term.App
                                    (FStar_SMTEncoding_Term.FalseOp,
                                     uu____5425);
                                  FStar_SMTEncoding_Term.freevars =
                                    uu____5426;
                                  FStar_SMTEncoding_Term.rng = uu____5427;_};
                              FStar_SMTEncoding_Term.assumption_caption =
                                uu____5428;
                              FStar_SMTEncoding_Term.assumption_name =
                                uu____5429;
                              FStar_SMTEncoding_Term.assumption_fact_ids =
                                uu____5430;_}
                            -> pop ()
                        | uu____5450 when tcenv1.FStar_TypeChecker_Env.admit
                            -> pop ()
                        | FStar_SMTEncoding_Term.Assume uu____5451 ->
                            (ask_and_report_errors tcenv1 labels prefix qry
                               suffix;
                             pop ())
                        | uu____5453 -> failwith "Impossible"))) ()
         with
         | FStar_SMTEncoding_Env.Inner_let_rec names ->
             (pop ();
              (let uu____5469 =
                 let uu____5479 =
                   let uu____5487 =
                     let uu____5489 =
                       let uu____5491 =
                         FStar_List.map FStar_Pervasives_Native.fst names in
                       FStar_String.concat "," uu____5491 in
                     FStar_Util.format1
                       "Could not encode the query since F* does not support precise smtencoding of inner let-recs yet (in this case %s)"
                       uu____5489 in
                   (FStar_Errors.Error_NonTopRecFunctionNotFullyEncoded,
                     uu____5487, (tcenv.FStar_TypeChecker_Env.range)) in
                 [uu____5479] in
               FStar_TypeChecker_Err.add_errors tcenv uu____5469)))
let (solve :
  (unit -> Prims.string) FStar_Pervasives_Native.option ->
    FStar_TypeChecker_Env.env -> FStar_Syntax_Syntax.term -> unit)
  =
  fun use_env_msg ->
    fun tcenv ->
      fun q ->
        let uu____5546 = FStar_Options.no_smt () in
        if uu____5546
        then
          let uu____5549 =
            let uu____5559 =
              let uu____5567 =
                let uu____5569 = FStar_Syntax_Print.term_to_string q in
                FStar_Util.format1
                  "Q = %s\nA query could not be solved internally, and --no_smt was given"
                  uu____5569 in
              (FStar_Errors.Error_NoSMTButNeeded, uu____5567,
                (tcenv.FStar_TypeChecker_Env.range)) in
            [uu____5559] in
          FStar_TypeChecker_Err.add_errors tcenv uu____5549
        else
          (let uu____5589 =
             let uu____5593 =
               let uu____5595 = FStar_TypeChecker_Env.current_module tcenv in
               FStar_Ident.string_of_lid uu____5595 in
             FStar_Pervasives_Native.Some uu____5593 in
           FStar_Profiling.profile
             (fun uu____5598 -> do_solve use_env_msg tcenv q) uu____5589
             "FStar.TypeChecker.SMTEncoding.solve_top_level")
let (solver : FStar_TypeChecker_Env.solver_t) =
  {
    FStar_TypeChecker_Env.init =
      (fun e -> save_cfg e; FStar_SMTEncoding_Encode.init e);
    FStar_TypeChecker_Env.push = FStar_SMTEncoding_Encode.push;
    FStar_TypeChecker_Env.pop = FStar_SMTEncoding_Encode.pop;
    FStar_TypeChecker_Env.snapshot = FStar_SMTEncoding_Encode.snapshot;
    FStar_TypeChecker_Env.rollback = FStar_SMTEncoding_Encode.rollback;
    FStar_TypeChecker_Env.encode_sig = FStar_SMTEncoding_Encode.encode_sig;
    FStar_TypeChecker_Env.preprocess =
      (fun e ->
         fun g ->
           let uu____5612 =
             let uu____5619 = FStar_Options.peek () in (e, g, uu____5619) in
           [uu____5612]);
    FStar_TypeChecker_Env.solve = solve;
    FStar_TypeChecker_Env.finish = FStar_SMTEncoding_Z3.finish;
    FStar_TypeChecker_Env.refresh = FStar_SMTEncoding_Z3.refresh
  }
let (dummy : FStar_TypeChecker_Env.solver_t) =
  {
    FStar_TypeChecker_Env.init = (fun uu____5635 -> ());
    FStar_TypeChecker_Env.push = (fun uu____5637 -> ());
    FStar_TypeChecker_Env.pop = (fun uu____5640 -> ());
    FStar_TypeChecker_Env.snapshot =
      (fun uu____5643 ->
         ((Prims.int_zero, Prims.int_zero, Prims.int_zero), ()));
    FStar_TypeChecker_Env.rollback = (fun uu____5662 -> fun uu____5663 -> ());
    FStar_TypeChecker_Env.encode_sig =
      (fun uu____5678 -> fun uu____5679 -> ());
    FStar_TypeChecker_Env.preprocess =
      (fun e ->
         fun g ->
           let uu____5685 =
             let uu____5692 = FStar_Options.peek () in (e, g, uu____5692) in
           [uu____5685]);
    FStar_TypeChecker_Env.solve =
      (fun uu____5708 -> fun uu____5709 -> fun uu____5710 -> ());
    FStar_TypeChecker_Env.finish = (fun uu____5717 -> ());
    FStar_TypeChecker_Env.refresh = (fun uu____5719 -> ())
  }