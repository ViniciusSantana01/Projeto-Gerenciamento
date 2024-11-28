<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Os"%>
<%@page import="model_dao.OsDAO"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Excluir OS</title>
    <link rel="stylesheet" href="../CSS/excluir.css"> <!-- Inclua seu CSS se necessário -->
</head>
<body>
    <h1>Excluir OS</h1>
    <%
        // Recebe o CPF ou nome do cliente para exclusão
        String cliente = request.getParameter("cliente");

        if (cliente == null || cliente.isEmpty()) {
    %>
        <div class="result-message error">
            Nenhum cliente foi informado para exclusão.
        </div>
        <a href="../consultar_os/consultar.html">Voltar</a>
    <%
        } else {
            // Cria a instância da OS
            Os os = new Os();
            
            // Verifica se o parâmetro é CPF ou nome
            if (cliente.matches("\\d{11}")) {
                os.setCpf(cliente); // Se for CPF, define o CPF
            } else {
                os.setNome(cliente); // Caso contrário, define o nome
            }

            OsDAO osDAO = new OsDAO();
            boolean isDeleted = osDAO.delOs(os); // Chama o método para deletar

            if (isDeleted) {
    %>
                <div class="result-message success">
                    OS excluída com sucesso!
                </div>
            <%
            } else {
            %>
                <div class="result-message error">
                    Erro! A OS não foi excluída. Verifique se o nome ou CPF está correto.
                </div>
            <%
            }
        }
    %>
    <a href="../excluir_os/excluir.html" class="btn-back">Voltar</a>
</body>
</html>

