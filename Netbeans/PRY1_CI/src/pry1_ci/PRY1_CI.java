/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package pry1_ci;
import java.io.File;
import java.io.IOException;

/**
 *
 * @author asmal
 */
public class PRY1_CI {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {
        String r1 = "T:/2023/COMPILADORES/PRYS/PRY1_CI/Netbeans/PRY1_CI/src/pry1_ci/lexer.jflex";
        String r2 = "T:/2023/COMPILADORES/PRYS/PRY1_CI/Netbeans/PRY1_CI/src/pry1_ci/Parser.cup";
        Generar(r1, r2);
    }
        
    
    private static void Generar(String r1, String r2 ) {
        File archivo;
        archivo = new File(r1);
        JFlex.Main.generate(archivo);
        String[] opciones = {"-parser", "sym","T:/2023/COMPILADORES/PRYS/PRY1_CI/Netbeans/PRY1_CI/src/pry1_ci/Parser.cup" }; 
        
       
        try 
        {
            java_cup.Main.main(opciones);
        } 
        catch (Exception ex)
        {
            System.out.print(ex);
        }
    }
    
    /*private static void probar() throws FileNotFoundException, IOException {
        Reader reader = new BufferedReader(new FileReader (ruta));
        reader.read();
        LexerAC lexer = new LexerAC(reader);
        int i = 0;
        
        Symbol token;
        while(true) {
            token = lexer.next_token();
            if(token.sym !=0) {
                System.out.println("Tokem: "+token.sym+ ", Valor: "+lexer.yytext());
            }
            else {
                System.out.println("Cantidad de lexemas encontrados: "+i);
                return;
            }
            i++;
        }
        
    }*/
    
}
