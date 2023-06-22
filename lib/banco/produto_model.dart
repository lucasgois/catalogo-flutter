import 'package:uuid/uuid.dart';

class ProdutoModel {
  String id;
  String descricao;
  String referencia;
  double valor;
  double quantidade;
  String foto;
  String dataCadastro;

  ProdutoModel({
    this.id = '',
    this.descricao = '',
    this.referencia = '',
    this.valor = 0.0,
    this.quantidade = 0.0,
    this.foto = '',
    this.dataCadastro = '',
  });

  ProdutoModel.novo(
    this.descricao,
    this.referencia,
    this.valor,
    this.quantidade,
    this.foto,
  )   : id = const Uuid().v4(),
        dataCadastro = DateTime.now().toIso8601String();
}
