<%-- 
  UMC 
  Vinicius Santana, Paulo Ricardo, Juma Siqueira, Matheus Anry e Rafael Kercio
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Os"%>
<%@page import="model_dao.OsDAO"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atualizar OS</title>
    <link rel="stylesheet" href="../CSS/cadastro.css">
</head>
<body>
    <header>
        <h1>Atualização de OS</h1>
    </header>
    
    <%
        try {
            String cpf = request.getParameter("cpf");
            String cliente = request.getParameter("cliente");
            String endereco = request.getParameter("endereco");
            String fone = request.getParameter("fone");
            String produto = request.getParameter("produto");
            String defeito = request.getParameter("defeito");
            String status = request.getParameter("status");

            Os os = new Os();
            os.setCpf(cpf); // Identificador principal para atualização
            os.setNome(cliente);
            os.setEndereco(endereco);
            os.setFone(fone);
            os.setProduto(produto);
            os.setDefeito(defeito);
            os.setSituacao(status);

            OsDAO osDAO = new OsDAO();

            // Atualiza a OS no banco
            if (osDAO.altos(os)) {
    %>
                <div class="result-message success">
                    OS atualizada com sucesso!
                </div>
    <%
            } else {
    %>
                <div class="result-message error">
                    Não foi possível atualizar a OS. Verifique os dados informados.
                </div>
    <%
            }
        } catch (Exception e) {
    %>
        <div class="result-message error">
            Erro durante a atualização: <%= e.getMessage() %> .
        </div>
    <%
        }
    %>

    <!-- Link para voltar à tela anterior -->
    <a href="../alterar_os/alterar.html" class="btn-back">Voltar</a>
</body>
</html>
