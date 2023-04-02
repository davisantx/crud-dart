import 'dart:io';
import 'usuario.dart';
import 'tabela_usuarios.dart';

class Sistema extends TabelaUsuarios {
  final List<String> nomeDasOperacoes = ['Criar', 'Ler', 'Alterar', 'Apagar', 'Sair do programa'];

  void introduzir() {
    print('Sistema de Crud criado em Dart!!');
  }

  void exibirOperacoes() {
    int indice;
    String operacaoAtual;
    espacamento();
    print('Insira o código que corresponde a operação desejada!');
    for(int i = 0; i < nomeDasOperacoes.length; ++i) {
        indice = i + 1;
        operacaoAtual = nomeDasOperacoes[i];
        print('$indice - $operacaoAtual');
    }
    inserirOperacao();
  }
  void espacamento() {
    print('\n');
  }
  void inserirOperacao() {
    stdout.write('\nCódigo: ');
    String? codigoDaOperacao = stdin.readLineSync();
    espacamento();
    int codigoNumericoDaOperacao = retornaNumeroConvertido(codigoDaOperacao);
    if(validar(codigoNumericoDaOperacao)) {
        //inserir operação que será efetuada segundo o código escolhido pelo usuário
        executaOperacao(codigoNumericoDaOperacao);
    }else {
      print('Insira uma operação válida!');
      espacamento();
      exibirOperacoes();
    }

  }
  bool validar(int codigo) {
    if(codigo <= 5 && codigo > 0) {
      return true;
    }else {
      return false;
    }
  }

  bool verificaSeCampoEstaNulo(List<String?> campos) {
    for(int i = 0; i < campos.length; ++i) {
      if(campos[i] == null) {
        return true;
      }
    }
    return false;
  }
  
  void adicionaOuModificaInformacoes(int codigoNumerico, bool criarUsuario) {
    stdout.write('Nome : ');
    String? nome = stdin.readLineSync();
    stdout.write('Idade: ');
    String? idade = stdin.readLineSync();
    stdout.write('Email: ');
    String? email = stdin.readLineSync();

    List<String?> informacoes = [nome, idade, email];
    if(verificaSeCampoEstaNulo(informacoes)) {
      print('Algum campo está nulo!');
      exibirOperacoes();
    }else if(criarUsuario) {
      tabelaUsuarios.criar(usuario: Usuario(nome!, retornaNumeroConvertido(idade), email!, tabelaUsuarios.usuarios.length + 1));
      exibirOperacoes();
    }else {
      tabelaUsuarios.alterar(codigo: codigoNumerico, usuario: Usuario(nome!, retornaNumeroConvertido(idade), email!, codigoNumerico));
      exibirOperacoes();
      
    }
  }
  void lerUsuarios() {
    print('Deseja ler as informações de um usuário ou de todos?');
    print('1 - Ler as informações de um usuário específico\n2 - Ler as informações de todos os usuários');
    String? leituraEscolhida = stdin.readLineSync();
    int? tipoDeLeitura = retornaNumeroConvertido(leituraEscolhida);
    if(tipoDeLeitura == 1) {
      lerInformacoesDeUmUsuarioEmEspecifico();
    }else {
      lerInformacoesDeTodosOsUsuarios();
    }
  }
  void lerInformacoesDeUmUsuarioEmEspecifico() {
    print('Insira o código do usuário em que se deseja visualizar os dados:');
    String? codigo = stdin.readLineSync();
    int codigoNumerico = retornaNumeroConvertido(codigo);
    if(tabelaUsuarios.verificaSeCodigoEValido(codigoNumerico, 'valido') == 'valido') {
      tabelaUsuarios.ler(codigo: codigoNumerico, lerTodosOsUsuarios: false);
      exibirOperacoes();
    }else {
      print('Não existe usuário com este código no momento!');
      exibirOperacoes();
    }
  }
  void lerInformacoesDeTodosOsUsuarios() {
    tabelaUsuarios.ler(codigo: 0, lerTodosOsUsuarios: true);
    exibirOperacoes();
  }
  void atualizarUsuarios() {
    print('Insira o código do usuário em que se deseja alterar os dados!');
    String? codigo = stdin.readLineSync();
    int codigoNumerico = retornaNumeroConvertido(codigo);
    if(tabelaUsuarios.verificaSeCodigoEValido(codigoNumerico, 'valido') == 'valido') {
      adicionaOuModificaInformacoes(codigoNumerico, false);
    }
  }
  void excluirUsuario() {
    print('Insira o código do usuário que se deseja excluir da lista:');
    String? codigo = stdin.readLineSync();
    int codigoNumerico = retornaNumeroConvertido(codigo);

    if(tabelaUsuarios.verificaSeCodigoEValido(codigoNumerico, 'valido') == 'valido') {
      tabelaUsuarios.apagar(codigo: codigoNumerico);
      exibirOperacoes();
    }else {
      print('Não existe usuário com este código no momento!');
      exibirOperacoes();
    }
  }

  void executaOperacao(int codigoDaOperacao) {
    if(codigoDaOperacao == 1) {
      adicionaOuModificaInformacoes(0, true);
    }else if(codigoDaOperacao == 2) {
      lerUsuarios();
    }else if(codigoDaOperacao == 3) {
      atualizarUsuarios();
    }else if(codigoDaOperacao == 4) {
      excluirUsuario();
    }else if(codigoDaOperacao == 5) {
      exit(0);
    }
  }
  int retornaNumeroConvertido(valor) {
    if(valor != null) {
      return int.parse(valor);
    }
    return 0;
  }

  Sistema() {
    introduzir();
    exibirOperacoes();
  }
}