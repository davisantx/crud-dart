import 'usuario.dart';

abstract class Crud {
  void criar({required Usuario usuario});
  void ler({required int codigo, required bool lerTodosOsUsuarios});
  void alterar({required int codigo, required Usuario usuario});
  void apagar({required int codigo});
}