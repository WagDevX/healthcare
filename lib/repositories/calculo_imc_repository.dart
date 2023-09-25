import 'package:healthcare/models/pessoa.dart';

class CalculoImcRepository {
  final List<Pessoa> _pessoas = [];

  Future<void> adicionar(Pessoa pessoa) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _pessoas.add(pessoa);
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _pessoas
        .remove(_pessoas.where((pessoa) => pessoa.id.toString() == id).first);
  }

  Future<List<Pessoa>> listarPessoas() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _pessoas;
  }
}
