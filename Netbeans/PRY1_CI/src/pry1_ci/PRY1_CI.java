/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package pry1_ci;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java_cup.runtime.Symbol;

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
        Limpiar();
    }
        
    
    private static void Limpiar() throws IOException {
        
        String raiz, rutaLexer, rutaParser;

        raiz = System.getProperty("user.dir");
        System.out.println(raiz);
       
        rutaLexer = raiz+"\\src\\pry1_ci\\lexer.jflex";
        rutaParser = raiz+"\\src\\pry1_ci\\Parser.cup";
        
        Files.deleteIfExists(Paths.get(raiz+"\\src/pry1_ci\\sym.java"));
        Files.deleteIfExists(Paths.get(raiz+"\\src/pry1_ci\\Parser.java"));
        Files.deleteIfExists(Paths.get(raiz+"\\src/pry1_ci\\LexerAC.java"));
        Generar(rutaLexer, rutaParser);
        
        Files.move(Paths.get(raiz+"\\sym.java"), Paths.get(raiz+"\\src\\pry1_ci\\sym.java"));
        Files.move(Paths.get(raiz+"\\parser.java"), Paths.get(raiz+"\\src\\pry1_ci\\parser.java"));
        probar();
    }
    
    private static void Generar(String r1, String r2) throws IOException {
        File archivo;
        archivo = new File(r1);
        JFlex.Main.generate(archivo);
        String[] opciones = {r2};
         try 
        {
            java_cup.Main.main(opciones);
        } 
        catch (Exception ex)
        {
            System.out.print(ex);
        }
         
    }
    
    private static void probar() throws FileNotFoundException, IOException {
        String rutaEJ1 = "T:/2023/COMPILADORES/PRYS/PRY1_CI/Netbeans/PRY1_CI/src/pry1_ci/ej.txt";
        Reader reader = new BufferedReader(new FileReader (rutaEJ1));
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
        
    }
    
}
