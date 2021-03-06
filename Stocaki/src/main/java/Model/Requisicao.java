package Model;

import org.jetbrains.annotations.Contract;

public class Requisicao {
    private int id_requisicao;
    private String status_aprovacao;
    private String nome;
    private String modelo;
    private String descricao;
    private String classificacao;
    private String lote;
    private String cor;
    private int id_funcionario;
    private int saldo;
    //não existentes no banco
    private String nome_funcionario;
    private int id_armazem;

    @Contract(pure = true)
    public Requisicao() {

    }

    public int getId_requisicao() {
        return id_requisicao;
    }

    public void setId_requisicao(int id_requisicao) {
        this.id_requisicao = id_requisicao;
    }

    public String getStatus_aprovacao() {
        return status_aprovacao;
    }

    public void setStatus_aprovacao(String status_aprovacao) {
        this.status_aprovacao = status_aprovacao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getClassificacao() {
        return classificacao;
    }

    public void setClassificacao(String classificacao) {
        this.classificacao = classificacao;
    }

    public String getLote() {
        return lote;
    }

    public void setLote(String lote) {
        this.lote = lote;
    }

    public String getCor() {
        return cor;
    }

    public void setCor(String cor) {
        this.cor = cor;
    }

    public int getId_funcionario() {
        return id_funcionario;
    }

    public void setId_funcionario(int id_funcionario) {
        this.id_funcionario = id_funcionario;
    }

    public int getSaldo() {
        return saldo;
    }

    public void setSaldo(int saldo) {
        this.saldo = saldo;
    }

    public String getNome_funcionario() {
        return nome_funcionario;
    }

    public void setNome_funcionario(String nome_funcionario) {
        this.nome_funcionario = nome_funcionario;
    }

    public int getId_armazem() {
        return id_armazem;
    }

    public void setId_armazem(int id_armazem) {
        this.id_armazem = id_armazem;
    }
}
