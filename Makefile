.SUFFIXES: .o
CC=g++ -g -fPIC -std=c++11  -I`ocamlc -where`
CLINK=g++
CLINKLIBS=
OUT=helloworld1
OCAMLOPT=ocamlfind opt -linkpkg -verbose
CMX=program.cmx
CMX_TEST=
ASMRUN=-lasmrun
ASMRUN=freelist_n.o memory_n.o alloc_n.o amd64.o floats_n.o hash_n.o bigarray_n.o custom_n.o backtrace_nat_n.o skiplist_n.o globroots_n.o memprof_n.o weak_n.o ./finalise_n.o roots_nat_n.o compact_n.o major_gc_n.o minor_gc_n.o ./md5_n.o ./codefrag_n.o extern_n.o ./parsing_n.o ./backtrace_n.o startup_aux_n.o ./obj_n.o intern_n.o ints_n.o domain_n.o str_n.o unix_n.o misc_n.o sys_n.o gc_ctrl_n.o debugger_n.o startup_nat_n.o signals_nat_n.o signals_n.o io_n.o printexc_n.o fail_nat_n.o callback_n.o

.SUFFIXES: .cpp .h .o .ml .cmx .cmo .cmi
.PHONY: all depend clean

all: freelist_n.o $(GEN_CMX) $(CMX) $(CMX_TEST) library_code $(GEN_MOC) $(GEN_CPP) main.o
	$(CLINK) -L`ocamlc -where` $(GEN_CPP) camlcode.o main.o $(ASMRUN) -lm -ldl -o $(OUT)

library_code:
	$(OCAMLOPT) -output-obj $(GEN_CMX) $(CMX) -o camlcode.o -nostdlib -nopervasives -verbose

callback_n.o freelist_n.o:
	ar x `ocamlc -where`/libasmrun.a $<

.cpp.o:
	$(CC) -c $< -I`ocamlc -where` -I.

.ml.cmx:
	$(OCAMLOPT) -I ../lib/_build -c $<

clean:
	$(RM) *.o *.cm[oiax] *.cmxa *.o.startup.s $(MOC_CPP) $(OUT)

-include  $(shell ocamlc -where)/Makefile.config
include .depend
