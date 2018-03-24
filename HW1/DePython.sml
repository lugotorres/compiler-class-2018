(*##################################################################################################
Juan A. Lugo-Torres
801-14-3716
CCOM-4087
Homework #1: DePython
##################################################################################################*)

(*Code provided for homework*)

(*Datatypes*)
type id = string

datatype binop = Add | Mult

datatype prog = Module of stm

and stm = Expr of exp
		| PrintStm of exp
		| Assign of id * exp
		| CompoundStm of stm * stm

and exp = Num of int
		| Name of id
		| BinOp of exp * binop * exp

(*Test cases*)
val p1 = Module (Expr (Num 123));
val p2 = Module (Expr (BinOp (Num 3, Add, Num 2))) : prog;
val p3 = Module (CompoundStm (Assign ("a", Num 3), PrintStm (BinOp (Name "a", Mult, Num 2))));

(*Added test case*)
val p4 = Module (Expr (BinOp (Num 3, Mult, Num 2))) : prog;

(*##################################################################################################
Exercise 1: DePython Pretty Printer
My code below 
##################################################################################################*)

(*Will print the prog passed as argument in human readable format*)
(*fn : prog -> unit*)
fun pretty (Module x) =
	let
		(*Will transform an exp's to a human readable string*)
		(*fn : exp -> string*)
		fun prettyExp (Num numExp) = Int.toString numExp
		  | prettyExp (Name nameExp) = nameExp
		  | prettyExp (BinOp (leftExp, Add, rightExp)) = "(" ^ prettyExp (leftExp) ^ " + " ^ prettyExp (rightExp) ^ ")"
		  | prettyExp (BinOp (leftExp, Mult, rightExp)) = "(" ^ prettyExp (leftExp) ^ " * " ^ prettyExp (rightExp) ^ ")"

		(*Will recursively transform stm's into other stm's or exp's*)
		(*fn : stm -> srting*)
		fun prettyStm (Expr (exp)) = prettyExp exp
		  | prettyStm (PrintStm exp) = "print " ^ prettyExp exp
		  | prettyStm (Assign (name, exp)) = name ^ " = " ^ prettyExp (exp) ^ ", "
		  | prettyStm (CompoundStm (leftStm, rightStm)) = " (" ^ prettyStm (leftStm) ^ prettyStm (rightStm) ^ ") "
	in
		print ("\n" ^ prettyStm x ^ "\n\n")
	end;

(*##################################################################################################
Exercise 2: DePython Interpreter
My code below 
##################################################################################################*)

(*Will interpret the prog passed as argument. Will NOT print unlessed specified by a PrintStm*)
(*fn : prog -> table*)
fun interp (Module x) =
	let 
		(*Datatype : List of tuples (id, value)*)
		type table = (id * int) list

		(*Will traverse table recursively storing the first tuple in tval and the rest in tble
		  If it finds a tuple with id = name it will return the tuple value otherwise raises Fail*)
		(*fn : table * id -> int*)
		fun lookup ([] : table, name : id) = raise Fail "UNBOUND IDENTIFIER"
		  | lookup ((tval :: tbl) : table, name : id) =
				if #1 tval = name
				then #2 tval
				else lookup (tbl, name)
(*
		fun update (tbl : table, name : id, value : int) : table =
			(name,value) :: tbl;
*)
		(*Will modify table adding a tuple consisting of (name, value) passed as individual
		  arguments or if it finds a tuple with id = name it will modify value to the new one*)
		(*fn : table * id * int -> table*)
		fun update ([] : table, name: id, value : int) : table = (name, value) :: []
		  | update ((tval :: tble) : table, name : id, value:int) =
				if #1 tval = name
				then (name, value) :: tble
				else update (tble, name, value) @ [tval]

		(*Will interpret exp's*)
		(*fn : exp * table -> int*)
		fun interpExp (Num nunExp, tbl) = nunExp
		  | interpExp (Name nameExp, tbl) = lookup(tbl, nameExp)
		  | interpExp (BinOp(leftExp, Add, rightExp), tbl)= interpExp (leftExp, tbl) + interpExp (rightExp, tbl)
		  | interpExp (BinOp(leftExp, Mult, rightExp), tbl)= interpExp (leftExp, tbl) * interpExp (rightExp, tbl)

		(*Will recursively interpret stm's to other stm's or exp's*)
		(*fn : stm * table -> table*)
		fun interpStm (Expr exp, tbl) = (interpExp (exp, tbl); tbl)
		  | interpStm (PrintStm exp, tbl) = (print (Int.toString (interpExp (exp, tbl))); tbl)
		  | interpStm (Assign (name, exp), tbl) = (update (tbl, name, interpExp (exp, tbl)))
		  | interpStm (CompoundStm(leftStm, rightStm), tbl) = (interpStm (rightStm, interpStm (leftStm, tbl)))
	in
		print "\n"; interpStm (x, [] : table); print "\n\n"
	end;
