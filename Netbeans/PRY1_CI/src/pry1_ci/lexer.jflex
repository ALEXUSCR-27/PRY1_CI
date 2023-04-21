package pry1_ci;
import java_cup.runtime.*;

%%

%class LexerAC
%public
%unicode
%cup
%line
%column

%{

    int line = 1;
    int column = 1;
    String msgErr = "";
    StringBuffer string = new StringBuffer();

    public Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    public Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }

    public int getYYLine() {
        return yyline+1;
    }

    public int getYYColumn() {
        return yycolumn+1;
    }

    public String getMsgErr() {
        return msgErr;
    }

    public void SetMsgErr() {
        msgErr = "";
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
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent = ([^*] | \*+ [^/*])*

Identifier = [:jletter:][:jletterdigit:]*

DecIntegerLiteral = 0 | [1-9][0-9]*


%state CADENA

%%




/* keywords */

/*Tipos*/
<YYINITIAL> "bool" {return symbol(sym.BOOL);}
<YYINITIAL> "int" {return symbol(sym.INT);}
<YYINITIAL> "float" {return symbol(sym.FLOAT);}
<YYINITIAL> "string" {return symbol(sym.STRING);}
<YYINITIAL> "char" {return symbol(sym.CHAR);}
<YYINITIAL> "arreglo" {return symbol(sym.ARREGLO);}

<YYINITIAL> "true" {return symbol(sym.TRUE);}
<YYINITIAL> "false" {return symbol(sym.FALSE);}
<YYINITIAL> "@" {return symbol(sym.COMENTARIO_SIMPLE);}


/*Control*/
<YYINITIAL> "if" {return symbol(sym.IF);}
<YYINITIAL> "elif" {return symbol(sym.ELIF);}
<YYINITIAL> "else" {return symbol(sym.ELSE);}
<YYINITIAL> "while" {return symbol(sym.WHILE);}
<YYINITIAL> "doWhile" {return symbol(sym.DO_WHILE);} //??
<YYINITIAL> "for" {return symbol(sym.FOR);}
<YYINITIAL> "break" {return symbol(sym.BREAK);}
<YYINITIAL> "return" {return symbol(sym.RETURN);}
<YYINITIAL> "$" {return symbol(sym.FIN_EXPRESION);}//??
<YYINITIAL> "null" {return symbol(sym.NULL);}

<YYINITIAL> "sysPrint" {return symbol(sym.SYS_PRINT);}
<YYINITIAL> "sysRead" {return symbol(sym.SYS_READ);}


<YYINITIAL> {

    /*identifiers*/
    {Identifier} { return symbol(sym.Identificador, yytext()); }

    /*literals*/
    {DecIntegerLiteral} {return symbol(sym.INTEGER_LITERAL, Integer.parseInt(yytext()));}
    \"                  {string.setLength(0); yybegin(CADENA);}
    
    //Operators
    "=="    {return symbol(sym.EQEQ);}
    "="     {return symbol(sym.EQ);}
    "+"     {return symbol(sym.PLUS);}
    "*"     {return symbol(sym.TIMES);}
    "-"     {return symbol(sym.MINUS);}
    "/"     {return symbol(sym.DIVI);}
    "("     {return symbol(sym.PARENTESISABRE);}
    ")"     {return symbol(sym.PARENTESISCIERRA);}
    "{"     {return symbol(sym.LLAVESCORCHETEABRE);}
    "}"     {return symbol(sym.LLAVESCORCHETECIERRA);}
    ";"     {return symbol(sym.SEMI);}
    ","     {return symbol(sym.COMA);}
    "!"     {return symbol(sym.NEGACION);}
    "^"     {return symbol(sym.CONJUNCION);}
    "#"     {return symbol(sym.DISYUNCION);}
    "--"    {return symbol(sym.MINUSMINUS);}
    "++"    {return symbol(sym.PLUSPLUS);}
    ">"     {return symbol(sym.GREATER_THAN);}
    "<"     {return symbol(sym.LESS_THAN);}
    ">="    {return symbol(sym.GREATER_THAN_OR_EQ);}
    "<="    {return symbol(sym.LESS_THAN_OR_EQ);}
    "!="    {return symbol(sym.NOT_EQ);}
    "**"    {return symbol(sym.POWER);}
    "~"     {return symbol(sym.MODULO);}


    

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


/* error fallback */
[^]    { msgErr = "[Error lexico] Caracter Ilegal: "+yytext()+"\" en la linea "+(yyline+1)+", columna "+(yycolumn+1);
        System.err.println(msgErr);
}