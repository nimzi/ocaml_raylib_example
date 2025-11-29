module C = Configurator.V1

let realpath path =
  try
    let cmd = Printf.sprintf "realpath %s" (Filename.quote path) in
    let ic = Unix.open_process_in cmd in
    let result = input_line ic in
    ignore (Unix.close_process_in ic);
    result
  with _ -> path

let () =
  C.main ~name:"raylib-config" (fun _c ->
    (* The rule runs from the build directory (_build/default).
       We need to find the source directory by going up from current dir.
       We go up from _build/default to get to the source root. *)
    let current = Sys.getcwd () in
    (* If we're in _build/default, go up 2 levels to source root *)
    let source_dir = 
      if Filename.basename current = "default" then
        Filename.dirname (Filename.dirname current)
      else
        (* Fallback: search up for static_raylib/libraylib.a, but skip _build directories *)
        let rec find_source_dir dir =
          if Filename.basename dir = "_build" then
            find_source_dir (Filename.dirname dir)
          else
            let raylib_path = Filename.concat dir "static_raylib/libraylib.a" in
            if Sys.file_exists raylib_path then
              dir
            else
              let parent = Filename.dirname dir in
              if parent = dir then (* Reached root *)
                C.die "Could not find static_raylib/libraylib.a. Make sure you're running from the project root."
              else
                find_source_dir parent
        in
        find_source_dir current
    in
    let raylib_dir = Filename.concat source_dir "static_raylib" in
    let raylib_lib = Filename.concat raylib_dir "libraylib.a" in
    let glfw_lib = Filename.concat raylib_dir "libglfw3.a" in
    
    (* Verify both libraries exist *)
    if not (Sys.file_exists raylib_lib) then
      C.die "Could not find libraylib.a at %s. Make sure static_raylib/ directory exists." raylib_lib;
    if not (Sys.file_exists glfw_lib) then
      C.die "Could not find libglfw3.a at %s. Make sure static_raylib/ directory exists." glfw_lib;
    
    (* Both libraries are in the same directory, so we only need one -L flag *)
    let lib_path = realpath raylib_dir in
    
    (* Write flags in the format expected by dune's flags field.
       Each flag must be a separate string. *)
    let flags = [
      "-ccopt"; Printf.sprintf "-L%s" lib_path;
    ] in
    C.Flags.write_sexp "c_library_flags.sexp" flags
  )
