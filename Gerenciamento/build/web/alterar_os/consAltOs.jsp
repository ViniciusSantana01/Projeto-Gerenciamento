<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Os"%>
<%@page import="model_dao.OsDAO"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar OS</title>
    <link rel="stylesheet" href="../CSS/cadastro.css"> <!-- CSS específico para essa página -->
</head>
<body>
    <header>
        <h1>Alterar Registro - OS</h1>
    </header>

    <%
        String cliente = request.getParameter("cliente");
        if (cliente == null || cliente.isEmpty()) {
    %>
        <div class="result-message error">
            Nenhum CPF ou Nome foi informado para a consulta.
        </div>
        <a href="../alterar_os/alterar.html">Voltar</a>
    <%
        } else {
            Os os = new Os();
            if (cliente.matches("\\d{11}")) {
                os.setCpf(cliente); // Busca por CPF
            } else {
                os.setNome(cliente); // Busca por Nome
            }

            OsDAO osDAO = new OsDAO();
            Os resultado = osDAO.consOsReg(os);

            if (resultado != null) {
    %>
                <form name="frmReg" method="post" action="updateOs.jsp" class="form-container">
                    <label for="cpf">CPF:</label>
                    <input type="text" name="cpf" id="cpf" value="<%= resultado.getCpf() %>" required readonly>

                    <label for="cliente">Nome do Cliente:</label>
                    <input type="text" name="cliente" id="cliente" value="<%= resultado.getNome() %>" required>

                    <label for="endereco">Endereço:</label>
                    <input type="text" name="endereco" id="endereco" value="<%= resultado.getEndereco() %>" required>

                    <label for="fone">Fone:</label>
                    <input type="text" name="fone" id="fone" value="<%= resultado.getFone() %>" required>

                    <label for="produto">Produto:</label>
                    <input type="text" name="produto" id="produto" value="<%= resultado.getProduto() %>" required>

                    <label for="defeito">Defeito:</label>
                    <input type="text" name="defeito" id="defeito" value="<%= resultado.getDefeito() %>" required>

                    <label for="status">Status:</label>
                    <select name="status" id="status" required>
                        <option value="Em andamento" <%= "Em andamento".equals(resultado.getSituacao()) ? "selected" : "" %>>Em andamento</option>
                        <option value="Concluído" <%= "Concluído".equals(resultado.getSituacao()) ? "selected" : "" %>>Concluído</option>
                        <option value="Cancelado" <%= "Cancelado".equals(resultado.getSituacao()) ? "selected" : "" %>>Cancelado</option>
                    </select>

                    <button type="submit" class="btn-submit">Salvar Alterações</button>
                </form>
    <%
            } else {
    %>
                <div class="result-message error">
                    Nenhuma OS encontrada para o CPF ou Nome informado: <%= cliente %> .
                </div>
    <%
            }
        }
    %>

    <a href="../alterar_os/alterar.html" class="btn-back">Voltar</a>
</body>
</html>



