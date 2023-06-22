import 'dart:developer';

import 'package:catalogo_flutter/banco/helper.dart';
import 'package:catalogo_flutter/banco/produto_model.dart';

class ProdutosController {
  List<ProdutoModel> produtos = [];
  List<ProdutoModel> itens = [];
  List<List<ProdutoModel>> pedidos = [];

  ProdutosController();

  Future<bool> carregarItens() async {
    produtos = await BancoHelper().selectProdutos();
    log('length ${produtos.length}');
    return true;
  }

  void addItem(ProdutoModel item) {
    try {
      ProdutoModel produto = itens.firstWhere((element) => element.id == item.id);
      produto.quantidade++;
    } catch (e) {
      itens.insert(0, item);
      item.quantidade++;
    }
  }

  void removeItem(ProdutoModel item) {
    try {
      ProdutoModel produto = itens.firstWhere((element) => element.id == item.id);
      produto.quantidade--;

      if (produto.quantidade == 0) {
        itens.remove(produto);
      }
    } catch (_) {}
  }

  String quantidadeItem(String id) {
    try {
      return itens.firstWhere((element) => element.id == id).quantidade.toStringAsFixed(0);
    } catch (e) {
      return '';
    }
  }
}

enum Tela {
  catalogoProdutos,
  orcamento,
  listaOrcamentos,
}
