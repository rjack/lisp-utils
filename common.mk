.PHONY	: all clean

all	: *.x86f

%.x86f	: %.lisp
	lisp -quiet -eval '(compile-file "$<") (quit)'


clean	:
	rm -f *.x86f
