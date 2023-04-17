/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package pry1_ci;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
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
        probar("T:\\2023\\COMPILADORES\\PRYS\\PRY1_CI\\Netbeans\\PRY1_CI\\src\\pry1_ci\\ej.txt");
    }
    
    private static void probar(String ruta) throws FileNotFoundException, IOException {
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
        
    }
    
}
