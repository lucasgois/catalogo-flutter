import 'dart:developer';

import 'package:catalogo_flutter/banco/helper.dart';
import 'package:catalogo_flutter/banco/itens_orcamento.dart';
import 'package:catalogo_flutter/banco/orcamento_model.dart';
import 'package:catalogo_flutter/banco/produto_model.dart';

class ProdutosController {
  List<ProdutoModel> listaProdutos = [];
  List<ItensOrcamentoModel> listaItens = [];
  List<OrcamentoModel> listaOrcamentos = [];

  OrcamentoModel? _orcamento;

  Future<OrcamentoModel> orcamento() async {
    if (_orcamento == null) {
      _orcamento = await BancoHelper().selectOrcamentoAtivo();

      if (_orcamento == null) {
        _orcamento = OrcamentoModel.novo();
        await BancoHelper().insertOrcamento(_orcamento!);
      }
    }

    return _orcamento!;
  }

  ProdutosController();

  Future<bool> carregarProdutosCatalogo() async {
    listaProdutos = await BancoHelper().selectProdutos();
    return listaItens.isEmpty;
  }

  Future<bool> carregarListaItensOrcamento() async {
    String idOrcamento = (await orcamento()).id;
    listaItens = await BancoHelper().selectListaItensOrcamento(idOrcamento);
    return listaItens.isEmpty;
  }

  Future<bool> carregarListaOrcamentos() async {
    listaOrcamentos = await BancoHelper().selectListaOrcamentos();
    return listaItens.isEmpty;
  }

  Future<void> addItem(ProdutoModel item) async {
    String idOrcamento = (await orcamento()).id;

    ItensOrcamentoModel? itemOrcamento = await BancoHelper().selectItemOrcamento(
      idOrcamento,
      item.id,
    );

    if (itemOrcamento == null) {
      await BancoHelper().insertItemOrcamento(idOrcamento, item);
    } else {
      await BancoHelper().itemOrcamentoAtualizarQuantidade(
        itemOrcamento.id,
        itemOrcamento.quantidade + 1,
      );
    }
    listaItens = await BancoHelper().selectListaItensOrcamento(idOrcamento);
  }

  void removeItem(ProdutoModel item) async {
    String idOrcamento = (await orcamento()).id;

    ItensOrcamentoModel? itemOrcamento = await BancoHelper().selectItemOrcamento(
      idOrcamento,
      item.id,
    );

    if (itemOrcamento != null) {
      double quantidade = itemOrcamento.quantidade - 1;

      if (quantidade >= 0.0) {
        await BancoHelper().itemOrcamentoAtualizarQuantidade(
          itemOrcamento.id,
          quantidade,
        );
      }
    }
    listaItens = await BancoHelper().selectListaItensOrcamento(idOrcamento);
  }

  String quantidadeItem(String id) {
    try {
      return listaItens.firstWhere((element) => element.id == id).quantidade.toStringAsFixed(0);
    } catch (e) {
      return '';
    }
  }

  fecharOrcamento() async {
    String idOrcamento = (await orcamento()).id;

    await BancoHelper().fecharOrcamentoAtivo(idOrcamento);
    _orcamento = null;
  }

  void editarOrcamento(OrcamentoModel orcamentoModel) async {
    await fecharOrcamento();

    _orcamento = await BancoHelper().selectOrcamento(orcamentoModel.id);
  }
}

enum Tela {
  catalogoProdutos,
  orcamento,
  listaOrcamentos,
}
