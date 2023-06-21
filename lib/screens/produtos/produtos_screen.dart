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
  int _aba = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text(_titulo)),
      body: Stack(
        children: [
          _construir(),
          Column(
            children: [
              Expanded(child: Container()),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: _tamanhoFloatingButton,
                        height: _tamanhoFloatingButton,
                        child: FloatingActionButton(
                          heroTag: 'produtos',
                          onPressed: () => _trocarAba(0),
                          child: Icon(
                            Icons.list,
                            size: _tamanhoFloatingButton * 0.666,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: _tamanhoFloatingButton,
                        height: _tamanhoFloatingButton,
                        child: FloatingActionButton(
                          heroTag: 'pedido',
                          onPressed: () => _trocarAba(1),
                          child: Icon(
                            Icons.shopping_cart,
                            size: _tamanhoFloatingButton * 0.666,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: _tamanhoFloatingButton,
                        height: _tamanhoFloatingButton,
                        child: FloatingActionButton(
                          heroTag: 'pedidos',
                          onPressed: () => _trocarAba(2),
                          child: Icon(
                            Icons.receipt,
                            size: _tamanhoFloatingButton * 0.666,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _fecharVenda(),
        ],
      ),
    );
  }

  Widget _construir() {
    if (_aba == 0) {
      return _abaProdutos();
    } else if (_aba == 1) {
      return _abaPedido();
    } else if (_aba == 2) {
      return _abaPedidos();
    } else {
      throw 'aba invalida $_aba';
    }
  }

  Widget _abaProdutos() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: _controller.produtos.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return Material(
            elevation: 5,
            child: ListTile(
              title: Text(_controller.produtos[index]['descricao']),
              subtitle: Text('R\$ ${_controller.produtos[index]['valor']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${_controller.produtos[index]['quantidade'] ?? ''}'),
                  IconButton(
                    onPressed: () {
                      _controller.itens.insert(0, _controller.produtos[index]);
                      _controller.produtos[index]['quantidade'] ??= 0;

                      setState(() {
                        _controller.produtos[index]['quantidade']++;
                      });
                    },
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _abaPedido() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: _controller.itens.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return Material(
            elevation: 5,
            child: ListTile(
              title: Text(_controller.itens[index]['descricao']),
              subtitle: Text('R\$ ${_controller.itens[index]['valor']}'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _abaPedidos() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: _controller.pedidos.length,
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

  void _trocarAba(int aba) {
    String titulo;

    if (aba == 0) {
      titulo = 'Produtos';
    } else if (aba == 1) {
      titulo = 'Pedido';
    } else if (aba == 2) {
      titulo = 'Pedidos';
    } else {
      throw 'aba invalida $aba';
    }

    setState(() {
      _titulo = titulo;
      _aba = aba;
    });
  }

  Widget _fecharVenda() {
    if (_aba == 1 && _controller.itens.isNotEmpty) {
      return Positioned(
        right: 18,
        bottom: 18,
        child: SizedBox(
          width: _tamanhoFloatingButton,
          height: _tamanhoFloatingButton,
          child: FloatingActionButton(
            heroTag: 'fechar_pedido',
            onPressed: () {
              _controller.pedidos.add(_controller.itens);
              setState(() {
                _controller.itens.clear();
              });
            },
            child: Icon(
              Icons.check,
              size: _tamanhoFloatingButton * 0.666,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
