import 'package:uuid/uuid.dart';

class ItensOrcamentoModel {
  String id;
  String idOrcamento;
  String idProduto;
  String descricao;
  double valor;
  double quantidade;

  ItensOrcamentoModel({
    this.id = '',
    this.idOrcamento = '',
    this.idProduto = '',
    this.descricao = '',
    this.valor = 0.0,
    this.quantidade = 0.0,
  });

  @override
  String toString() {
    return 'ItensOrcamentoModel{id: $id, idOrcamento: $idOrcamento, idProduto: $idProduto, descricao: $descricao, valor: $valor, quantidade: $quantidade}';
  }
}
