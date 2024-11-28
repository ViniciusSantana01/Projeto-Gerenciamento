// UMC
// Vinicius Santana, Paulo Ricardo, Juma Siqueira, Matheus Anry e Rafael Kercio

package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectaDB {
    // URL de conexão ao banco de dados com o fuso horário ajustado para 'America/Sao_Paulo'
    private static final String URL = "jdbc:mysql://localhost:3306/dbos?useTimezone=true&serverTimezone=America/Sao_Paulo";
    private static final String USER = "root"; // Nome do usuário do MySQL
    private static final String PASSWORD = ""; // Senha do MySQL

    // Método para conectar ao banco de dados
    public static Connection conectar() throws ClassNotFoundException, SQLException {
        // Carregar o driver do MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Estabelecer a conexão com o banco "dbos"
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
