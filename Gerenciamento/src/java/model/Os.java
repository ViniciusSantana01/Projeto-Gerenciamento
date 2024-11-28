package model;

import java.time.LocalDateTime;

public class Os {
    private String cpf;       // CPF será a chave primária
    private String nome;      // Nome do cliente
    private String endereco;  // Endereço do cliente
    private String fone;      // Telefone do cliente
    private String produto;   // Produto em questão
    private String defeito;   // Defeito reportado
    private String situacao;  // Situação da OS (substitui Status)
    private LocalDateTime dataRegistro;  // Data de registro
    private LocalDateTime dataAlteracao; // Data da última alteração

    // Getter e Setter para CPF
    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    // Getter e Setter para Nome
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    // Getter e Setter para Endereço
    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    // Getter e Setter para Telefone
    public String getFone() {
        return fone;
    }

    public void setFone(String fone) {
        this.fone = fone;
    }

    // Getter e Setter para Produto
    public String getProduto() {
        return produto;
    }

    public void setProduto(String produto) {
        this.produto = produto;
    }

    // Getter e Setter para Defeito
    public String getDefeito() {
        return defeito;
    }

    public void setDefeito(String defeito) {
        this.defeito = defeito;
    }

    // Getter e Setter para Situação
    public String getSituacao() {
        return situacao;
    }

    public void setSituacao(String situacao) {
        this.situacao = situacao;
    }

    // Getter e Setter para Data de Registro
    public LocalDateTime getDataRegistro() {
        return dataRegistro;
    }

    public void setDataRegistro(LocalDateTime dataRegistro) {
        this.dataRegistro = dataRegistro;
    }

    // Getter e Setter para Data de Alteração
    public LocalDateTime getDataAlteracao() {
        return dataAlteracao;
    }

    public void setDataAlteracao(LocalDateTime dataAlteracao) {
        this.dataAlteracao = dataAlteracao;
    }
}
