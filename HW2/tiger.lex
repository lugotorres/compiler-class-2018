type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end

val comStk = ref 0

%%
num = [0-9];
alph = [A-Za-z];
id = {alph}({alph}|{num}|_)*;
ws = [\ \t];
%s = INITIAL, COMMENT;
%%

<INITIAL>"type"	=> (Tokens.TYPE(yypos,yypos+size yytext));
<INITIAL>"var"	=> (Tokens.VAR(yypos,yypos+size yytext));
<INITIAL>"function"	=> (Tokens.FUNCTION(yypos,yypos+size yytext));
<INITIAL>"end"	=> (Tokens.END(yypos,yypos+size yytext));
<INITIAL>"in"	=> (Tokens.IN(yypos,yypos+size yytext));
<INITIAL>"let"	=> (Tokens.LET(yypos,yypos+size yytext));
<INITIAL>"else"	=> (Tokens.ELSE(yypos,yypos+size yytext));
<INITIAL>"then"	=> (Tokens.THEN(yypos,yypos+size yytext));
<INITIAL>"if"	=> (Tokens.IF(yypos,yypos+size yytext));

<INITIAL>":="	=> (Tokens.ASSIGN(yypos, yypos+size yytext));
<INITIAL>"|"	=> (Tokens.OR(yypos,yypos+size yytext));
<INITIAL>"&"	=> (Tokens.AND(yypos,yypos+size yytext));
<INITIAL>">="	=> (Tokens.GE(yypos,yypos+size yytext));
<INITIAL>">"	=> (Tokens.GT(yypos,yypos+size yytext));
<INITIAL>"<="	=> (Tokens.LE(yypos,yypos+size yytext));
<INITIAL>"<"	=> (Tokens.LT(yypos,yypos+size yytext));
<INITIAL>"<>"	=> (Tokens.NEQ(yypos,yypos+size yytext));
<INITIAL>"="	=> (Tokens.EQ(yypos,yypos+size yytext));
<INITIAL>"/"	=> (Tokens.DIVIDE(yypos,yypos+size yytext));
<INITIAL>"*"	=> (Tokens.TIMES(yypos,yypos+size yytext));
<INITIAL>"-"	=> (Tokens.MINUS(yypos,yypos+size yytext));
<INITIAL>"+"	=> (Tokens.PLUS(yypos,yypos+size yytext));

<INITIAL>")"	=> (Tokens.RPAREN(yypos,yypos+size yytext));
<INITIAL>"("	=> (Tokens.LPAREN(yypos,yypos+size yytext));

<INITIAL>";"	=> (Tokens.SEMICOLON(yypos,yypos+size yytext));
<INITIAL>":"	=> (Tokens.COLON(yypos,yypos+size yytext));
<INITIAL>","	=> (Tokens.COMMA(yypos,yypos+size yytext));

<INITIAL>{num}+	=> (let 
	      val SOME x = Int.fromString yytext 
	    in 
	      Tokens.INT(x,yypos,yypos+(String.size yytext) )
	    end);
<INITIAL>{id}	=> (Tokens.ID(yytext, yypos, yypos+(String.size yytext)));

<INITIAL>{ws}	=> (continue());


<INITIAL>"/*"	=> (YYBEGIN COMMENT; continue());
<COMMENT>"*/"	=> (YYBEGIN INITIAL; continue());
<COMMENT>.	=> (continue());

<INITIAL>(\".*\")	=> (Tokens.STRING(String.extract(yytext,1,SOME (size yytext-2)), yypos, yypos+(String.size yytext)));

\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());

.	=> (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());

