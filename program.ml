module Obj = struct
  type t

  external repr : 'a -> t = "%identity"
end

module Callback = struct
  external register_named_value : string -> Obj.t -> unit
    = "caml_register_named_value"

  let register name v = register_named_value name (Obj.repr v)
end

type out_channel

external open_descriptor_out : int -> out_channel
  = "caml_ml_open_descriptor_out"

let stdout = open_descriptor_out 1

external unsafe_output_string : out_channel -> string -> int -> int -> unit
  = "caml_ml_output"

external string_length : string -> int = "%string_length"

external flush : out_channel -> unit = "caml_ml_flush"

let output_string oc s = unsafe_output_string oc s 0 (string_length s)

let main () =
  output_string stdout "hello, World\n";
  flush stdout

let () = Callback.register "doCamlInitialization" main
