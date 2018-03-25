signature Tiger_TOKENS =
sig
type linenum (* = int *)
type token
val TYPE:  linenum * linenum -> token (* in tiger.lex *)
val VAR:  linenum * linenum -> token (* in tiger.lex *)
val FUNCTION:  linenum * linenum -> token (* in tiger.lex *)
val BREAK:  linenum * linenum -> token
val OF:  linenum * linenum -> token
val END:  linenum * linenum -> token (* in tiger.lex *)
val IN:  linenum * linenum -> token (* in tiger.lex *)
val NIL:  linenum * linenum -> token
val LET:  linenum * linenum -> token (* in tiger.lex *)
val DO:  linenum * linenum -> token
val TO:  linenum * linenum -> token
val FOR:  linenum * linenum -> token
val WHILE:  linenum * linenum -> token
val ELSE:  linenum * linenum -> token (* in tiger.lex *)
val THEN:  linenum * linenum -> token (* in tiger.lex *)
val IF:  linenum * linenum -> token (* in tiger.lex *)
val ARRAY:  linenum * linenum -> token
val ASSIGN:  linenum * linenum -> token (* in tiger.lex *)
val OR:  linenum * linenum -> token (* in tiger.lex *)
val AND:  linenum * linenum -> token (* in tiger.lex *)
val GE:  linenum * linenum -> token (* in tiger.lex *)
val GT:  linenum * linenum -> token (* in tiger.lex *)
val LE:  linenum * linenum -> token (* in tiger.lex *)
val LT:  linenum * linenum -> token (* in tiger.lex *)
val NEQ:  linenum * linenum -> token (* in tiger.lex *)
val EQ:  linenum * linenum -> token (* in tiger.lex *)
val DIVIDE:  linenum * linenum -> token (* in tiger.lex *)
val TIMES:  linenum * linenum -> token (* in tiger.lex *)
val MINUS:  linenum * linenum -> token (* in tiger.lex *)
val PLUS:  linenum * linenum -> token (* in tiger.lex *)
val DOT:  linenum * linenum -> token
val RBRACE:  linenum * linenum -> token
val LBRACE:  linenum * linenum -> token
val RBRACK:  linenum * linenum -> token
val LBRACK:  linenum * linenum -> token
val RPAREN:  linenum * linenum -> token (* in tiger.lex *)
val LPAREN:  linenum * linenum -> token (* in tiger.lex *)
val SEMICOLON:  linenum * linenum -> token (* in tiger.lex *)
val COLON:  linenum * linenum -> token
val COMMA:  linenum * linenum -> token (* in tiger.lex *)
val STRING: (string) *  linenum * linenum -> token (* in tiger.lex *)
val INT: (int) *  linenum * linenum -> token (* in tiger.lex *)
val ID: (string) *  linenum * linenum -> token (* in tiger.lex *)
val EOF:  linenum * linenum -> token (* in tiger.lex *)
end
