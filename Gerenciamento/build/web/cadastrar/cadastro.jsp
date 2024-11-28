<%-- 
  UMC 
  Vinicius Santana, Paulo Ricardo, Juma Siqueira, Matheus Anry e Rafael Kercio
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Os"%>
<%@page import="model_dao.OsDAO"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de OS</title>
    <link rel="stylesheet" href="../CSS/cadastro.css?v=1.0">

</head>
<body>
    <header>
        <img src="../imagem/logo.jpg" alt="Logo do Sistema" class="logo">
    </header>
    <div class="container">
        <div class="form-header">
            <h1>Cadastro de OS</h1>
        </div>
        <form name="frmReg" method="post" action="cadastro.jsp">        
            <div class="form-group">
                <input type="text" id="cpf" name="cpf" placeholder="CPF (xxx.xxx.xxx-xx)" required pattern="\d{3}\.\d{3}\.\d{3}-\d{2}">
            </div>
            <div class="form-group">
                <input type="text" id="cliente" name="cliente" placeholder="Cliente" required>
            </div>
            <div class="form-group">
                <input type="text" id="endereco" name="endereco" placeholder="Endereço" required>
            </div>
            <div class="form-group">
                <input type="tel" id="fone" name="fone" placeholder="(DDD) 95571-3436" required>
            </div>
            <div class="form-group">
                <input type="text" id="produto" name="produto" placeholder="Produto" required>
            </div>
            <div class="form-group">
                <input type="text" id="defeito" name="defeito" placeholder="Defeito" required>
            </div>
            <div class="form-group">
                <select id="status" name="status" required>
                    <option value="" disabled selected>Status</option>
                    <option value="Em andamento">Em andamento</option>
                    <option value="Concluido">Concluido</option>
                    <option value="Cancelado">Cancelado</option>
                </select>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn-submit">Cadastrar</button>
                <a href="../index.html" class="btn-back">Voltar</a>
            </div>
        </form>
        <div class="result-message">
            <%
                // Recebe os parâmetros do formulário
                String cpf = request.getParameter("cpf");
                String cliente = request.getParameter("cliente");
                String endereco = request.getParameter("endereco");
                String fone = request.getParameter("fone");
                String produto = request.getParameter("produto");
                String defeito = request.getParameter("defeito");
                String status = request.getParameter("status");

                // Validação dos dados
                String erro = null;
                if (cpf == null || cpf.isEmpty()) {
                    erro = "CPF é obrigatório!";
                } else if (!Pattern.matches("\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}", cpf)) {
                    erro = "CPF inválido!";
                } else if (cliente == null || cliente.isEmpty()) {
                    erro = "Nome do cliente é obrigatório!";
                } else if (fone == null || fone.isEmpty()) {
                    erro = "Telefone é obrigatório!";
                } else if (produto == null || produto.isEmpty()) {
                    erro = "Produto é obrigatório!";
                } else if (defeito == null || defeito.isEmpty()) {
                    erro = "Defeito é obrigatório!";
                } else if (status == null || status.isEmpty()) {
                    erro = "Status é obrigatório!";
                }

                if (erro != null) {
            %>
                    <p class="error-message"><%= erro %></p>
            <%
                } else {
                    // Instância do objeto OS e configura os dados
                    Os os = new Os();
                    os.setCpf(cpf);
                    os.setNome(cliente);
                    os.setEndereco(endereco);
                    os.setFone(fone);
                    os.setProduto(produto);
                    os.setDefeito(defeito);
                    os.setSituacao(status);
                    os.setDataRegistro(java.time.LocalDateTime.now());

                    OsDAO osDAO = new OsDAO();
                    try {
                        if (osDAO.cadastrar(os)) { // Tenta realizar o cadastro
            %>
                            <p class="success-message">Cadastro realizado com sucesso!</p>
            <%
                        } else {
            %>
                            <p class="error-message">Erro: CPF já cadastrado!</p>
            <%
                        }
                    } catch (Exception e) {
            %>
                        <p class="error-message">Erro ao tentar salvar no banco de dados: <%= e.getMessage() %></p>
            <%
                    }
                }
            %>
        </div>
    </div>

    <!-- JavaScript Embutido -->
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Máscara de telefone
            const phoneInput = document.getElementById('fone');
            phoneInput.addEventListener('input', () => {
                let value = phoneInput.value.replace(/\D/g, '');
                if (value.length > 10) {
                    value = value.replace(/^(\d{2})(\d{5})(\d{4}).*/, '($1)$2-$3');
                } else if (value.length > 5) {
                    value = value.replace(/^(\d{2})(\d{4})(\d{0,4}).*/, '($1)$2-$3');
                } else if (value.length > 2) {
                    value = value.replace(/^(\d{2})(\d{0,5}).*/, '($1)$2');
                } else {
                    value = value.replace(/^(\d*)/, '($1');
                }
                phoneInput.value = value;
            });

            // Máscara de CPF
            const cpfInput = document.getElementById('cpf');
            cpfInput.addEventListener('input', () => {
                let value = cpfInput.value.replace(/\D/g, '');  // Remove caracteres não numéricos

                if (value.length <= 9) {
                    // Formatação parcial para 9 primeiros dígitos (xxx.xxx.xxx)
                    value = value.replace(/^(\d{3})(\d{3})(\d{0,3})$/, '$1.$2.$3');
                } else if (value.length === 10) {
                    // Formatação com 10 dígitos (xxx.xxx.xxx-x)
                    value = value.replace(/^(\d{3})(\d{3})(\d{3})(\d{0,1})$/, '$1.$2.$3-$4');
                } else if (value.length === 11) {
                    // Formatação final com 11 dígitos (xxx.xxx.xxx-xx)
                    value = value.replace(/^(\d{3})(\d{3})(\d{3})(\d{2})$/, '$1.$2.$3-$4');
                }
                cpfInput.value = value;
            });
        });
    </script>
</body>
</html>
