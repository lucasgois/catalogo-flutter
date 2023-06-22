import 'dart:developer';

import 'package:catalogo_flutter/screens/produtos/produtos_controller.dart';
import 'package:flutter/material.dart';

class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({super.key});

  @override
  State<ProdutosScreen> createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  final ProdutosController _controller = ProdutosController();

  final double _tamanhoFloatingButton = 80;

  String _titulo = '';
  Tela _tela = Tela.catalogoProdutos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text(_titulo)),
      body: _construir(),
      bottomNavigationBar: barra(),
    );
  }

  Widget barra() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        _fecharVenda(),
        Container(
          padding: const EdgeInsets.only(top: 8),
          color: Colors.blue,
          child: Row(
            children: [
              Expanded(
                child: Material(
                  color: _tela == Tela.catalogoProdutos ? Colors.white : Colors.transparent,
                  child: InkWell(
                    onTap: () => _trocarTela(Tela.catalogoProdutos),
                    child: Icon(
                      Icons.list,
                      size: _tamanhoFloatingButton * 0.666,
                      color: _tela == Tela.catalogoProdutos ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: _tela == Tela.orcamento ? Colors.white : Colors.transparent,
                  child: InkWell(
                    onTap: () => _trocarTela(Tela.orcamento),
                    child: Icon(
                      Icons.shopping_cart,
                      size: _tamanhoFloatingButton * 0.666,
                      color: _tela == Tela.orcamento ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: _tela == Tela.listaOrcamentos ? Colors.white : Colors.transparent,
                  child: InkWell(
                    onTap: () => _trocarTela(Tela.listaOrcamentos),
                    child: Icon(
                      Icons.receipt,
                      size: _tamanhoFloatingButton * 0.666,
                      color: _tela == Tela.listaOrcamentos ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _construir() {
    log('_tela: $_tela');

    if (_tela == Tela.catalogoProdutos) {
      return FutureBuilder(
        future: _controller.carregarProdutosCatalogo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _abaCatalogoProdutos();
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 10,
              ),
            );
          }
        },
      );
    } else if (_tela == Tela.orcamento) {
      return FutureBuilder(
        future: _controller.carregarListaItensOrcamento(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _abaOrcamento();
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 10,
              ),
            );
          }
        },
      );
    } else if (_tela == Tela.listaOrcamentos) {
      return FutureBuilder(
        future: _controller.carregarListaOrcamentos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _abaListaOrcamentos();
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 10,
              ),
            );
          }
        },
      );
    } else {
      throw 'aba invalida $_tela';
    }
  }

  Widget _abaCatalogoProdutos() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: _controller.listaProdutos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return Material(
          elevation: 5,
          child: ListTile(
            title: Container(
              padding: const EdgeInsets.all(8),
              height: 150,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      _controller.listaProdutos[index].foto,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_controller.listaProdutos[index].descricao),
                      Text(_controller.listaProdutos[index].referencia),
                      Text('R\$ ${_controller.listaProdutos[index].valor.toStringAsFixed(2)}'),
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _controller.addItem(_controller.listaProdutos[index]);
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                      ),
                      Text(_controller.quantidadeItem(_controller.listaProdutos[index].id)),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _controller.removeItem(_controller.listaProdutos[index]);
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // subtitle: Center(child: Text(_controller.produtos[index].id)),
          ),
        );
      },
    );
  }

  Widget _abaOrcamento() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: _controller.listaItens.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return Material(
            elevation: 5,
            child: ListTile(
              title: Text(_controller.listaItens[index].descricao),
              subtitle: Text('R\$ ${_controller.listaItens[index].valor}'),
              trailing: Text('Qtd: ${_controller.listaItens[index].quantidade.toStringAsFixed(0)}'),
            ),
          );
        },
      ),
    );
  }

  Widget _abaListaOrcamentos() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: _controller.listaOrcamentos.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return const Material(
            elevation: 5,
            child: ListTile(
              title: Text('Pedidos'),
              subtitle: Text('0.00'),
              trailing: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  void _trocarTela(Tela tela) {
    String titulo;

    if (tela == Tela.catalogoProdutos) {
      titulo = 'Catálogo de Produtos';
    } else if (tela == Tela.orcamento) {
      titulo = 'Orçamento';
    } else if (tela == Tela.listaOrcamentos) {
      titulo = 'Lista de Orçamentos';
    } else {
      throw 'aba invalida $tela';
    }

    setState(() {
      _titulo = titulo;
      _tela = tela;
    });
  }

  Widget _fecharVenda() {
    if (_tela == Tela.orcamento && _controller.listaItens.isNotEmpty) {
      return SizedBox(
        width: _tamanhoFloatingButton,
        height: _tamanhoFloatingButton,
        child: FloatingActionButton(
          heroTag: 'fechar_pedido',
          backgroundColor: Colors.green,
          onPressed: () async {
            await _controller.fecharOrcamento();
            _controller.listaItens.clear();

            setState(() {});
          },
          child: Icon(
            Icons.check,
            size: _tamanhoFloatingButton * 0.666,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
