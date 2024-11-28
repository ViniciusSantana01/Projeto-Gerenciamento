# Projeto-Gerenciamento

Sistema de Gerenciamento de Ordens de Serviço (ACXS)
Este projeto é um Sistema de Gerenciamento de Ordens de Serviço (OS), desenvolvido para uma Assistência Técnica de Eletrônicos, chamada ACXS. O sistema permite que os usuários possam cadastrar, consultar, alterar e excluir registros de ordens de serviço, com base em informações do cliente e do produto.

Funcionalidades
Cadastro de OS: Permite o cadastro de uma nova Ordem de Serviço, incluindo informações como CPF, nome do cliente, endereço, telefone, produto, defeito e status.
Consulta de OS: O usuário pode consultar registros de ordens de serviço, filtrando por CPF ou nome do cliente.
Alteração de OS: Permite alterar os dados de uma ordem de serviço existente, baseado no CPF ou nome do cliente.
Exclusão de OS: Permite excluir uma ordem de serviço existente utilizando o CPF ou nome do cliente.

Como Executar
Pré-requisitos
Servidor de Aplicação: Para executar a aplicação, é necessário ter um servidor de aplicação como o Apache Tomcat ou outro servidor compatível com JSP. (Conector utilizado: mysql-connector-java-8.0.30.jar)
Banco de Dados: É necessário configurar um banco de dados MySQL (ou outro banco de dados compatível). O banco de dados deve conter uma tabela para armazenar as ordens de serviço com os campos correspondentes. (Nome do banco de dados utilizado: dbos / Tabela: tbos)
