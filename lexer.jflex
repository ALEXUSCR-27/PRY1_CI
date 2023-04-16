package ParserLexer;
import java_cup.runtime.*;

%%

%class LexerAC
%public
%unicode
%cup
%line
%column

%{
    StringBuffer string = new StringBuffer();

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

/* comments */
Comment  = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/" //esto cambia
// Comment can be last line of the file, without line terminator.
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentConten} "*"+ "/"
CommentContent = ([^*] | \*+ [^/*])*

Identifier = [:jletter:] [:jletterdigit:]*

DecIntegerLiteral = 0 | [1-9][0-9]*

%state Cadena

%%

/* keywords */
<YYINITIAL> "bool" {return symbol(sym.BOOL);}
<YYINITIAL> "break" {return symbol(sym.BREAK);}
<YYINITIAL> "int" {return symbol(sym.INT);}
<YYINITIAL> "float" {return symbol(sym.FLOAT);}
<YYINITIAL> "string" {return symbol(sym.STRING);}
<YYINITIAL> "char" {return symbol(sym.CHAR);}
<YYINITIAL> "return" {return symbol(sym.RETURN);}
<YYINITIAL> "arreglo" {return symbol(sym.ARREGLO);}
<YYINITIAL> "$" {return symbol(sym.FINEXPRESION);}
<YYINITIAL> "true" {return symbol(sym.TRUE);}
<YYINITIAL> "false" {return symbol(sym.FALSE);}
<YYINITIAL> "@" {return symbol(sym.COMENTARIO_SIMPLE);}






<YYINITIAL> {
    /*identifiers*/
    {Identifier} {return symbol(sym.IDENTIFIER, yytext();)}

    /*literals*/
    {DecIntegerLiteral} {return symbol(sym.INTEGER_LITERAL, Integer.parserInt(yytext()));}
    \"                  {string.setLength(0); yybegin(CADENA);}
    
    //Operators
    "=="    {return symbol(sym.EQEQ);}
    "="     {return symbol(sym.EQ);}
    "+"     {return symbol(sym.PLUS);}
    "*"     {return symbol(sym.TIMES);}
    "-"     {return symbol(sym.MINUS);}
    "/"     {return symbol(sym.DIVI);}
    "("     {return symbol(sym.LPAREN);}
    ")"     {return symbol(sym.RPAREN);}
    "{"     {return symbol(sym.llavesCorcheteAbre);}
    "}"     {return symbol(sym.llavesCorcheteCierra);}
    ";"     {return symbol(sym.SEMI);}
    ","     {return symbol(sym.COMA);}
    "!"     {return symbol(sym.NEGACION);}
    "^"     {return symbol(sym.CONJUNCION);}

    /*comments*/
    {Comment} {/*ignore*/}

    /*whitespace*/
    {WhiteSpace} {/*ignore*/}
    
}

<CADENA> {
    \"      {yybegin(YYINITIAL);
            return symbol(sym.STRING_LITERAL,
            string.toString());}
    [^\n\r\"\\]+    {string.append(yytext());}
    \\t     {string.append('\t');}
    \\n     {string.append('\n');}
    \\r     {string.append('\r');}
    \\\"    {string.append('\"');}
    \\      {string.append('\\');}
}

/*error fallback*/
[^]     {throw new Error("Illegal character <"+ yytext()+">");}