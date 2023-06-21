class ProdutosController {
  List<Map<String, dynamic>> produtos = [];
  List<Map<String, dynamic>> itens = [];
  List<List<Map<String, dynamic>>> pedidos = [];

  ProdutosController() {
    produtos.addAll(
      [
        {
          'descricao': 'Camiseta',
          'valor': 29.99,
        },
        {
          'descricao': 'Calça jeans',
          'valor': 79.99,
        },
        {
          'descricao': 'Tênis',
          'valor': 129.99,
        },
        {
          'descricao': 'Vestido',
          'valor': 59.99,
        },
        {
          'descricao': 'Sapato social',
          'valor': 99.99,
        },
        {
          'descricao': 'Jaqueta',
          'valor': 89.99,
        },
        {
          'descricao': 'Bermuda',
          'valor': 39.99,
        },
        {
          'descricao': 'Blusa de frio',
          'valor': 49.99,
        },
        {
          'descricao': 'Sapato esportivo',
          'valor': 79.99,
        },
        {
          'descricao': 'Saia',
          'valor': 34.99,
        },
        {
          'descricao': 'Camisa social',
          'valor': 69.99,
        },
        {
          'descricao': 'Óculos de sol',
          'valor': 59.99,
        },
        {
          'descricao': 'Shorts',
          'valor': 29.99,
        },
        {
          'descricao': 'Blazer',
          'valor': 109.99,
        },
        {
          'descricao': 'Sandália',
          'valor': 49.99,
        },
        {
          'descricao': 'Macacão',
          'valor': 79.99,
        },
        {
          'descricao': 'Cinto',
          'valor': 19.99,
        },
        {
          'descricao': 'Carteira',
          'valor': 39.99,
        },
        {
          'descricao': 'Chapéu',
          'valor': 24.99,
        },
        {
          'descricao': 'Pulseira',
          'valor': 14.99,
        },
      ],
    );
  }
}
