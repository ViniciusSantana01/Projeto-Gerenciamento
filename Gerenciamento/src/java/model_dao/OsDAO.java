package model_dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Os;
import util.ConectaDB;

public class OsDAO {

        public boolean cadastrar(Os os) throws ClassNotFoundException {
        Connection conexao = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conexao = ConectaDB.conectar();

            // Verificar se o CPF já está cadastrado
            String checkSql = "SELECT * FROM tbos WHERE cpf = ?";
            stmt = conexao.prepareStatement(checkSql);
            stmt.setString(1, os.getCpf());
            rs = stmt.executeQuery();

            if (rs.next()) {
                return false; // CPF já existe, não cadastra
            }

            // Inserir nova OS
            String insertSql = "INSERT INTO tbos (cpf, nome, endereco, fone, produto, defeito, situacao, data_registro) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conexao.prepareStatement(insertSql);
            stmt.setString(1, os.getCpf());
            stmt.setString(2, os.getNome());
            stmt.setString(3, os.getEndereco());
            stmt.setString(4, os.getFone());
            stmt.setString(5, os.getProduto());
            stmt.setString(6, os.getDefeito());
            stmt.setString(7, os.getSituacao());
            stmt.setTimestamp(8, Timestamp.valueOf(os.getDataRegistro()));
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            System.out.println("Erro ao cadastrar: " + ex.getMessage());
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conexao != null) conexao.close();
            } catch (SQLException e) {
                System.out.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
    }

    public Os consOsReg(Os os) throws ClassNotFoundException {
        Connection conexao = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conexao = ConectaDB.conectar();

            // Definir a SQL com base no que foi passado (nome ou cpf)
            String sql = "";
            if (os.getNome() != null && !os.getNome().isEmpty()) {
                sql = "SELECT * FROM tbos WHERE nome = ?";
                stmt = conexao.prepareStatement(sql);
                stmt.setString(1, os.getNome());
            } else if (os.getCpf() != null && !os.getCpf().isEmpty()) {
                // Se CPF não estiver vazio, deve-se consultar diretamente com o CPF
                String cpfFormatado = os.getCpf().trim();  // Remove espaços extras
                sql = "SELECT * FROM tbos WHERE cpf = ?";
                stmt = conexao.prepareStatement(sql);
                stmt.setString(1, cpfFormatado);  // Passa o CPF com a formatação
            }

            // Executa a consulta
            rs = stmt.executeQuery();

            if (rs.next()) {
                os.setCpf(rs.getString("cpf"));
                os.setNome(rs.getString("nome"));
                os.setEndereco(rs.getString("endereco"));
                os.setFone(rs.getString("fone"));
                os.setProduto(rs.getString("produto"));
                os.setDefeito(rs.getString("defeito"));
                os.setSituacao(rs.getString("situacao"));
                os.setDataRegistro(rs.getTimestamp("data_registro").toLocalDateTime());

                Timestamp dataAlteracao = rs.getTimestamp("data_alteracao");
                if (dataAlteracao != null) {
                    os.setDataAlteracao(dataAlteracao.toLocalDateTime());
                }
                return os;
            }

            return null;
        } catch (SQLException ex) {
            System.out.println("Erro ao consultar: " + ex.getMessage());
            return null;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conexao != null) conexao.close();
            } catch (SQLException e) {
                System.out.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
    }

    // Método para atualizar a OS
    public boolean altos(Os os) throws ClassNotFoundException {
        Connection conexao = null;
        PreparedStatement stmt = null;

        try {
            conexao = ConectaDB.conectar();

            String sql = "UPDATE tbos SET nome = ?, endereco = ?, fone = ?, produto = ?, defeito = ?, situacao = ? WHERE cpf = ?";
            stmt = conexao.prepareStatement(sql);

            stmt.setString(1, os.getNome());
            stmt.setString(2, os.getEndereco());
            stmt.setString(3, os.getFone());
            stmt.setString(4, os.getProduto());
            stmt.setString(5, os.getDefeito());
            stmt.setString(6, os.getSituacao());
            stmt.setString(7, os.getCpf());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            System.out.println("Erro ao atualizar: " + ex.getMessage());
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conexao != null) conexao.close();
            } catch (SQLException e) {
                System.out.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
    }

   public boolean cados(Os os) throws ClassNotFoundException {
    Connection conexao = null;
    PreparedStatement stmt = null;
    PreparedStatement stmtCheck = null;
    ResultSet rs = null;

    try {
        // Estabelece a conexão com o banco de dados
        conexao = ConectaDB.conectar();

        // Verifica se o CPF já existe na tabela
        String sqlCheck = "SELECT COUNT(*) FROM tbos WHERE cpf = ?";
        stmtCheck = conexao.prepareStatement(sqlCheck);
        stmtCheck.setString(1, os.getCpf());
        rs = stmtCheck.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            // CPF já existe
            throw new SQLException("CPF já cadastrado.");
        }

        // SQL para inserir uma nova ordem de serviço, incluindo CPF como chave primária
        String sql = "INSERT INTO tbos (cpf, nome, endereco, fone, produto, defeito, situacao, data_registro) VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        stmt = conexao.prepareStatement(sql);

        // Preenche os parâmetros com os dados da ordem de serviço
        stmt.setString(1, os.getCpf());
        stmt.setString(2, os.getNome());
        stmt.setString(3, os.getEndereco());
        stmt.setString(4, os.getFone());
        stmt.setString(5, os.getProduto());
        stmt.setString(6, os.getDefeito());
        stmt.setString(7, os.getSituacao());

        // Executa a inserção no banco de dados
        stmt.executeUpdate();
        return true;

    } catch (SQLException ex) {
        System.out.println("Erro ao inserir: " + ex.getMessage());
        return false;

    } finally {
        // Fecha os recursos
        try {
            if (stmt != null) stmt.close();
            if (stmtCheck != null) stmtCheck.close();
            if (rs != null) rs.close();
            if (conexao != null) conexao.close();
        } catch (SQLException e) {
            System.out.println("Erro ao fechar recursos: " + e.getMessage());
        }
    }
}

    
    
    // Método para consultar todos os registros
    public List<Os> mostrarTodos() throws ClassNotFoundException {
        Connection conexao = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Os> registros = new ArrayList<>();

        try {
            conexao = ConectaDB.conectar();
            String sql = "SELECT cpf, nome, produto, situacao FROM tbos";
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Os os = new Os();
                os.setCpf(rs.getString("cpf"));
                os.setNome(rs.getString("nome"));
                os.setProduto(rs.getString("produto"));
                os.setSituacao(rs.getString("situacao"));
                registros.add(os);
            }
            return registros;

        } catch (SQLException ex) {
            System.out.println("Erro ao consultar todos os registros: " + ex.getMessage());
            return null;

        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conexao != null) conexao.close();
            } catch (SQLException e) {
                System.out.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
    }


    // Método para excluir uma ordem de serviço
    public boolean delOs(Os os) throws ClassNotFoundException {
    Connection conexao = null;
    PreparedStatement stmt = null;
    
    try {
        conexao = ConectaDB.conectar();
        
        String sql = "";
        // Se CPF não for nulo, exclui pela chave CPF
        if (os.getCpf() != null && !os.getCpf().isEmpty()) {
            sql = "DELETE FROM tbos WHERE cpf = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, os.getCpf());
        } else if (os.getNome() != null && !os.getNome().isEmpty()) {
            // Se Nome não for nulo, exclui pelo nome
            sql = "DELETE FROM tbos WHERE nome = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, os.getNome());
        }

        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;  // Retorna verdadeiro se a exclusão for bem-sucedida

    } catch (SQLException ex) {
        System.out.println("Erro ao excluir: " + ex.getMessage());
        return false;
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conexao != null) conexao.close();
        } catch (SQLException e) {
            System.out.println("Erro ao fechar recursos: " + e.getMessage());
        }
    }
  }
}
