import 'package:healthcare/models/pessoa.dart';
import 'package:healthcare/repositories/sqlite/sqlite_database.dart';

class CalculoIMCSQliteRepository {
  Future<List<Pessoa>> obterDados() async {
    List<Pessoa> pessoas = [];
    var db = await DatabaseSQlite().iniciarBancoDeDados();
    var result = await db.rawQuery('SELECT id, nome, peso, altura FROM pessoa');
    for (var element in result) {
      pessoas.add(Pessoa(
          int.parse(element['id'].toString()),
          element['nome'].toString(),
          double.parse(element['peso'].toString()),
          double.parse(element['altura'].toString())));
    }
    return pessoas;
  }

  Future<void> salvar(Pessoa pessoa) async {
    var db = await DatabaseSQlite().iniciarBancoDeDados();
    db.rawInsert('INSERT INTO pessoa (nome, peso, altura) values (?, ?, ?)',
        [pessoa.nome, pessoa.peso, pessoa.altura]);
  }

  Future<void> remover(int id) async {
    var db = await DatabaseSQlite().iniciarBancoDeDados();
    db.rawInsert('DELETE FROM pessoa WHERE id = ?', [id]);
  }
}
