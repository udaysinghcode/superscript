open OUnit

let empty_list = []
let singleton_list = [1]

let dummy_test _ =
  assert_equal 0 (List.length empty_list);
  assert_equal 1 (List.length singleton_list)

let suite = "OUnit Example" >::: ["dummy_test" >:: dummy_test]

let _ =
  run_test_tt_main suite
