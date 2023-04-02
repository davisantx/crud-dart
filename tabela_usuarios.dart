import 'crud.dart';
import 'usuario.dart';

class TabelaUsuarios implements Crud {
  List<Usuario> usuarios = [];

  TabelaUsuarios();
  
  void criar({required Usuario usuario}) {
    usuarios.add(usuario);
  }
  void ler({required int codigo, required bool lerTodosOsUsuarios}) {
    if(lerTodosOsUsuarios) {
      for(int i = 0; i < usuarios.length; ++i) {
        print('\nNome  : ${usuarios[i].nome}');
        print('Idade : ${usuarios[i].idade}');
        print('Email : ${usuarios[i].email}');
        print('Código: ${usuarios[i].codigo}\n');
        
      }
    }else {
      print('\nNome  : ${usuarios[codigo].nome}');
      print('Idade : ${usuarios[codigo].idade}');
      print('Email : ${usuarios[codigo].email}');
      print('Código: ${usuarios[codigo].codigo}\n');
    }
  }
  void alterar({required int codigo, required Usuario usuario}) {
    usuarios[codigo] = usuario;
  }
  void apagar({required int codigo}) {
    var users = usuarios.remove(usuarios[codigo]);
  }

  String verificaSeCodigoEValido(codigo, retornoSeForValido) {
    if(codigo < 0 && codigo > tabelaUsuarios.usuarios.length) {
      return 'Não existe usuário com este código no momento!';
    }else {
       return retornoSeForValido;
    }
  }
}

TabelaUsuarios tabelaUsuarios = TabelaUsuarios();
