import 'package:catalogo_flutter/banco/produto_model.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BancoHelper {
  static Database? _database;

  static Future<Database> get database async {
    _database ??= await _initDatabase();

    if (_database == null) {
      throw 'database esta null';
    } else {
      return _database!;
    }
  }

  static Future<Database> _initDatabase() async {
    sqfliteFfiInit();

    databaseFactory = databaseFactoryFfi;

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'banco_de_dados.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE produtos (
            id TEXT PRIMARY KEY,
            descricao TEXT,
            referencia TEXT,
            valor REAL,
            foto TEXT,
            data_cadastro TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE orcamentos (
            id TEXT PRIMARY KEY,
            data_cadastro TEXT,
            ativo INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE itens_orcamento (
            id TEXT PRIMARY KEY,
            id_orcamento TEXT,
            id_produto TEXT,
            quantidade INTEGER,
            FOREIGN KEY (id_orcamento) REFERENCES orcamentos (id),
            FOREIGN KEY (id_produto) REFERENCES produtos (id)
          )
        ''');

        try {
          await db.execute('''
                    INSERT INTO produtos (id, descricao, referencia, valor, foto, data_cadastro) VALUES
                    ('68f87d9f-7d2a-4c47-84fb-14379f27d7c1', 'Camiseta', 'REF001', 29.99, 'foto1.jpg', '2023-06-21T10:30:00Z'),
                    ('e874e72a-bc9d-4b68-84a0-1c448b0e651b', 'Calça Jeans', 'REF002', 59.99, 'foto2.jpg', '2023-06-21T11:15:00Z'),
                    ('3271ef6b-b671-4943-9d2d-8b57d6c487b8', 'Sapato', 'REF003', 99.99, 'foto3.jpg', '2023-06-21T12:00:00Z'),
                    ('a3cb8274-7ab7-4c54-9c0d-9d9b04d6659a', 'Bolsa', 'REF004', 39.99, 'foto4.jpg', '2023-06-21T13:45:00Z'),
                    ('04b69d0b-4f10-4eb6-a00e-2adbe80d7495', 'Relógio', 'REF005', 79.99, 'foto5.jpg', '2023-06-21T14:30:00Z'),
                    ('90491e50-6f4a-4417-9771-57e4b2cc8451', 'Óculos de Sol', 'REF006', 49.99, 'foto6.jpg', '2023-06-21T15:15:00Z'),
                    ('6df7e001-7b3b-47ad-9f14-95d34b23a8d4', 'Jaqueta', 'REF007', 89.99, 'foto7.jpg', '2023-06-21T16:00:00Z'),
                    ('a69a5da2-2e6c-4376-b5c2-7a93e4c4a3c1', 'Tênis', 'REF008', 69.99, 'foto8.jpg', '2023-06-21T16:45:00Z'),
                    ('2c0d44e7-527f-4c4b-b6fb-6e53a2882f6b', 'Carteira', 'REF009', 19.99, 'foto9.jpg', '2023-06-21T17:30:00Z'),
                    ('d31f615a-503a-4195-98c5-20e0f29f8a6e', 'Blusa', 'REF010', 34.99, 'foto10.jpg', '2023-06-21T18:15:00Z'),
                    ('d4a34e11-8b8e-4537-8a62-594e135d5ed0', 'Chapéu', 'REF011', 24.99, 'foto11.jpg', '2023-06-21T19:00:00Z'),
                    ('450979a0-47a5-42b3-93fd-5da992c7b53d', 'Saia', 'REF012', 39.99, 'foto12.jpg', '2023-06-21T19:45:00Z'),
                    ('d77f1e9b-216f-4dc5-8de0-8e20ee5e2820', 'Camisa Social', 'REF013', 49.99, 'foto13.jpg', '2023-06-21T20:30:00Z'),
                    ('5a4e3d8a-45fe-49c3-ae4d-2c2ab62d7fc5', 'Bermuda', 'REF014', 29.99, 'foto14.jpg', '2023-06-21T21:15:00Z'),
                    ('98ff51dd-85c9-4642-8c2f-8d70588fd987', 'Moletom', 'REF015', 59.99, 'foto15.jpg', '2023-06-21T22:00:00Z'),
                    ('8e42574a-0e3a-4b6d-b759-f79b2de4a9e2', 'Vestido', 'REF016', 69.99, 'foto16.jpg', '2023-06-21T22:45:00Z'),
                    ('23f4b17b-b1f9-4d49-9b59-49ff4609c2df', 'Sapatilha', 'REF017', 29.99, 'foto17.jpg', '2023-06-21T23:30:00Z'),
                    ('e85449e6-bc21-40ef-872e-9a674881d2ed', 'Calçado Esportivo', 'REF018', 79.99, 'foto18.jpg', '2023-06-22T00:15:00Z'),
                    ('ee91e5da-cd7f-447d-a8b4-8ae6b2f1ae06', 'Lenço', 'REF019', 14.99, 'foto19.jpg', '2023-06-22T01:00:00Z'),
                    ('bc9b9edf-5b36-4492-bdf1-f1652fcf5479', 'Meia', 'REF020', 9.99, 'foto20.jpg', '2023-06-22T01:45:00Z');
                  ''');
        } catch (e) {
          print(e);
        }
      },
    );
  }

  Future<void> insertProduto(ProdutoModel produto) async {
    final db = await database;
    await db.insert(
      'produtos',
      {
        'id': produto.id,
        'descricao': produto.descricao,
        'referencia': produto.referencia,
        'valor': produto.valor,
        'data_cadastro': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<List<ProdutoModel>> selectProdutos() async {
    final db = await database;
    List<Map<String, dynamic>> lista = await db.query('produtos');

    return lista
        .map((e) => ProdutoModel(
              id: e['id'],
              descricao: e['descricao'],
              referencia: e['referencia'],
              valor: e['valor'],
              dataCadastro: e['data_cadastro'],
            ))
        .toList();
  }
}
