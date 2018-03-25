(* Marroneo de tiger.lex para entender Straight Line Programs *)
(* Cuidado, no es igual a su tarea !!! *)
type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end


%% 
digits = [0-9]+;
letters = [A-Za-z]+;
%%
\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
","	=> (Tokens.COMMA(yypos,yypos+1));
"("    => (Tokens.LPAREN(yypos,yypos+1));
")"    => (Tokens.RPAREN(yypos,yypos+1));
"+"    => (Tokens.PLUS(yypos,yypos+1));
";"    => (Tokens.SEMICOLON(yypos,yypos+1));
":="    => (Tokens.ASSIGN(yypos, yypos+2));
{letters} => (Tokens.ID(yytext, yypos, yypos+(String.size yytext)));
" "     => (continue());
{digits}  => (let 
	      val SOME x = Int.fromString yytext 
	    in 
	      Tokens.INT(x,yypos,yypos+(String.size yytext) )
	    end);
.       => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());

