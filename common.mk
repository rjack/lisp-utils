.PHONY	: all clean

all	: *.fas

%.fas	: %.lisp
	clisp -q -c $<


clean	:
	rm -f *.fas *.lib
