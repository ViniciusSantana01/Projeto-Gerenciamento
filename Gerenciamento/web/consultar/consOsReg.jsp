<%-- 
  UMC 
  Vinicius Santana, Paulo Ricardo, Juma Siqueira, Matheus Anry e Rafael Kercio
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Os"%>
<%@page import="model_dao.OsDAO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado da Consulta</title>
    <link rel="stylesheet" href="../CSS/consulta.css">
</head>
<body>
    <h1>Registro / Ordem de Serviço</h1>
    <%
        String cliente = request.getParameter("cliente");
        String mostrarTodos = request.getParameter("mostrarTodos"); // Verifica se é para mostrar todos os registros

        // Se "Mostrar Todos" foi solicitado
        if ("true".equals(mostrarTodos)) {
        try {
            OsDAO osDAO = new OsDAO();
            List<Os> listaRegistros = osDAO.mostrarTodos(); 

                if (listaRegistros != null && !listaRegistros.isEmpty()) {
    %>
                    <h2>Todos os Registros Cadastrados</h2>
                    <table border="1" class="registro-tabela">
                        <thead>
                            <tr>
                                <th>CPF</th>
                                <th>Nome</th>
                                <th>Produto</th>
                                <th>Situação</th>
                            </tr>
                        </thead>
                        <tbody>
    <%
                            for (Os registro : listaRegistros) {
    %>
                                <tr>
                                    <td><%= registro.getCpf() %></td>
                                    <td><%= registro.getNome() %></td>
                                    <td><%= registro.getProduto() %></td>
                                    <td><%= registro.getSituacao() %></td>
                                </tr>
    <%
                            }
    %>
                        </tbody>
                    </table>
    <%
                } else {
    %>
                    <div class="result-message error">
                        Nenhum registro encontrado.
                    </div>
    <%
                }
            } catch (Exception e) {
    %>
                <div class="result-message error">
                    Erro ao consultar o banco de dados: <%= e.getMessage() %>.
                </div>
    <%
            }
        } else if (cliente == null || cliente.isEmpty()) {
    %>
        <div class="result-message error">
            Nenhum cliente foi informado para a consulta.
        </div>
        <a href="consulta.html" class="btn-back-registro">Voltar</a>
    <%
        } else {
            try {
                OsDAO osDAO = new OsDAO();
                Os resultado = null;

                // Verifica se é um CPF ou um nome de cliente
                if (cliente.matches("\\d{11}")) { // CPF (11 dígitos)
                    Os os = new Os();
                    os.setCpf(cliente);  // Busca por CPF
                    resultado = osDAO.consOsReg(os);
                } else {
                    Os os = new Os();
                    os.setNome(cliente);  // Busca por nome do cliente
                    resultado = osDAO.consOsReg(os);
                }

                // Exibe o resultado
                if (resultado != null) {
    %>
                    <div class="result-message success">
                        <p><b>CPF:</b> <%= resultado.getCpf() %></p>
                        <p><b>Cliente:</b> <%= resultado.getNome() %></p>
                        <p><b>Endereço:</b> <%= resultado.getEndereco() %></p>
                        <p><b>Fone:</b> <%= resultado.getFone() %></p>
                        <p><b>Produto:</b> <%= resultado.getProduto() %></p>
                        <p><b>Defeito:</b> <%= resultado.getDefeito() %></p>
                        <p><b>Status:</b> <%= resultado.getSituacao() %></p>
                        <p><b>Data de Registro:</b> <%= resultado.getDataRegistro() %></p>
                        <p><b>Data de Alteração:</b> <%= resultado.getDataAlteracao() != null ? resultado.getDataAlteracao() : "Não alterado" %></p>
                    </div>
    <%
                } else {
    %>
                    <div class="result-message error">
                        Registro não encontrado para o cliente: <%= cliente %>.
                    </div>
    <%
                }
            } catch (Exception e) {
    %>
                <div class="result-message error">
                    Erro ao consultar o banco de dados: <%= e.getMessage() %> .
                </div>
    <%
            }
        }
    %>
    <a href="consulta.html" class="btn-back-registro">Voltar</a>
</body>
</html>
