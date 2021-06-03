#include "caml/startup.h"
#include "caml/memory.h"
#include "caml/callback.h"

void doCaml() {
  CAMLparam0();
  static const value *closure = caml_named_value("doCamlInitialization");
  caml_callback(*closure, Val_unit); // should be a unit
  CAMLreturn0;
}

int main(int argc, char ** argv) {
    caml_main(argv);
    doCaml();

    return 0;
}
