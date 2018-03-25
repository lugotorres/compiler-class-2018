title: Lexical analysis of a Tiger subset
date: 2017-02-07
category: Teaching
tags: hacking, learning
slug: teaching/compilers2017/lexer

## Description

Construct a lexer for a subset of tiger that includes the following

```
exp:
	lvalue
	nil
	int
	string
	exp binop exp
	lvalue := exp
	id ( explist )
	( expseq )
	let declist in expseq end
	if exp then exp
	if exp then exp else exp

lvalue:
	# These are simple variables
	id

binop:
	+ - * / = <> < > <= >= & |

declist:
	dec
	dec declist
		
dec: 
	type id = id
	var id : id := exp
	function id ( typefields ) : id = exp

expseq:
    exp
	expseq ; exp

explist:
	exp
	explist , exp

typefields:
	typefield
	typefield, typefields

typefield:
	id : id
```

And comments delimited by `(*` and `*)`.
	
**NOTE:** the only valid typeid in our language are aliases of the
built in "int" and "string" types. We do not have arrays or structures
or other compound types.

Your assignment is to use the sample code in [chapter 2](https://www.cs.princeton.edu/~appel/modern/ml/chap2/) to implement
(in tiger.lex) a lexer for this subset of tiger. The full description
of tiger is in the Appendix A of the book, and you can get a
[short description of Tiger](http://www.cs.columbia.edu/~sedwards/classes/2002/w4115/tiger.pdf). Remember,
you don't have to implement the whole language, just what I describe
above.

You will definitely need to read Chapter 2 to see examples of building
a lexer, and the [ML-Lex manual](http://www.smlnj.org/doc/ML-Lex/manual.html)
is also useful.

## Example code

You need to make some changes to the `sources.cm` file, you can use one like:

```
Group is

driver.sml
errormsg.sml
tokens.sig
tokens.sml
tiger.lex
$/smlnj-lib.cm
$/basis.cm
```

You can parse a sample program using:

```
- CM.make "sources.cm";
- Parse.parse "test.tig";
  () : unit
```

Here's a simple program that should lex when you have completed the
assignment.

```
let
  function fac(n : int) : int =
	if n <= 1 then
		1
	else
		n * fac(n - 1)
in
	printi(fac(5))
end
```
