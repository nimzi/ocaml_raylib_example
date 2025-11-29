open Raylib

let () =
  (* Initialize a small temporary window to enable monitor queries *)
  init_window 100 100 "";
  
  (* Get the current monitor and its dimensions *)
  let monitor = get_current_monitor () in
  let monitor_width = get_monitor_width monitor in
  let monitor_height = get_monitor_height monitor in
  
  (* Set window to half the monitor size in each dimension *)
  let width = monitor_width / 2 in
  let height = monitor_height / 2 in
  let title = "OCaml Raylib Example" in
  
  (* Resize the window to the desired size *)
  set_window_size width height;
  set_window_title title;
  set_target_fps 60;
  
  let rec loop () =
    if window_should_close () then
      close_window ()
    else (
      begin_drawing ();
      clear_background (Color.create 245 245 245 255);
      
      (* Center the text based on window dimensions *)
      let text1 = "Hello from OCaml and Raylib!" in
      let text2 = "Press ESC to close" in
      let font_size1 = 40 in
      let font_size2 = 30 in
      let text1_width = measure_text text1 font_size1 in
      let text2_width = measure_text text2 font_size2 in
      draw_text text1 (width / 2 - text1_width / 2) (height / 2 - 40) font_size1 Color.darkgray;
      draw_text text2 (width / 2 - text2_width / 2) (height / 2 + 20) font_size2 (Color.create 100 100 100 255);
      
      end_drawing ();
      loop ()
    )
  in
  
  loop ()

