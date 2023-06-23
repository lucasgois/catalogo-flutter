import 'dart:developer';
import 'dart:io';

import 'package:catalogo_flutter/banco/itens_orcamento.dart';
import 'package:catalogo_flutter/banco/orcamento_model.dart';
import 'package:catalogo_flutter/banco/produto_model.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

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

  static Future<String> getDatabasePath() async {
    String databasePath;
    if (Platform.isAndroid) {
      databasePath = await getDatabasesPath();
    } else if (Platform.isWindows) {
      databasePath = '';
    } else {
      throw Exception();
    }
    return join(databasePath, 'banco_de_dados.db');
  }

  static Future<Database> _initDatabase() async {
    sqfliteFfiInit();

    final DatabaseFactory factory = databaseFactoryFfi;

    var path = await getDatabasePath();

    return await factory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
          CREATE TABLE usuarios (
              id TEXT PRIMARY KEY,
              usuario TEXT NOT NULL,
              senha TEXT NOT NULL
          );
        ''');

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
            total REAL,
            ativo INTEGER
          )
        ''');

          await db.execute('''
          CREATE TABLE itens_orcamento (
            id TEXT PRIMARY KEY,
            id_orcamento TEXT,
            id_produto TEXT,
            descricao TEXT,
            valor REAL,
            quantidade REAL,
            FOREIGN KEY (id_orcamento) REFERENCES orcamentos (id),
            FOREIGN KEY (id_produto) REFERENCES produtos (id)
          )
        ''');

          await db.execute('''
                    INSERT INTO produtos (id, descricao, referencia, valor, foto, data_cadastro) VALUES
                  ('68f87d9f-7d2a-4c47-84fb-14379f27d7c1', 'Pneu Aro 15 Pirelli P7', 'REF001', 299.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T10:30:00Z'),
                  ('e874e72a-bc9d-4b68-84a0-1c448b0e651b', 'Pneu Aro 17 Michelin Pilot Sport', 'REF002', 599.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T11:15:00Z'),
                  ('3271ef6b-b671-4943-9d2d-8b57d6c487b8', 'Pneu Aro 19 Continental ContiSportContact', 'REF003', 999.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T12:00:00Z'),
                  ('a3cb8274-7ab7-4c54-9c0d-9d9b04d6659a', 'Pneu Aro 14 Goodyear EfficientGrip Performance', 'REF004', 399.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T13:45:00Z'),
                  ('04b69d0b-4f10-4eb6-a00e-2adbe80d7495', 'Pneu Aro 18 Bridgestone Potenza', 'REF005', 799.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T14:30:00Z'),
                  ('90491e50-6f4a-4417-9771-57e4b2cc8451', 'Pneu Aro 16 Falken Ziex', 'REF006', 499.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T15:15:00Z'),
                  ('6df7e001-7b3b-47ad-9f14-95d34b23a8d4', 'Pneu Aro 20 Yokohama Advan Sport', 'REF007', 899.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T16:00:00Z'),
                  ('a69a5da2-2e6c-4376-b5c2-7a93e4c4a3c1', 'Pneu Aro 13 Pirelli Cinturato P4', 'REF008', 699.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T16:45:00Z'),
                  ('2c0d44e7-527f-4c4b-b6fb-6e53a2882f6b', 'Pneu Aro 16 Michelin Primacy 4', 'REF009', 199.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T17:30:00Z'),
                  ('d31f615a-503a-4195-98c5-20e0f29f8a6e', 'Pneu Aro 15 Continental EcoContact', 'REF010', 349.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T18:15:00Z'),
                  ('d4a34e11-8b8e-4537-8a62-594e135d5ed0', 'Pneu Aro 17 Goodyear Eagle F1 Asymmetric', 'REF011', 249.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T19:00:00Z'),
                  ('450979a0-47a5-42b3-93fd-5da992c7b53d', 'Pneu Aro 14 Bridgestone Ecopia', 'REF012', 399.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T19:45:00Z'),
                  ('d77f1e9b-216f-4dc5-8de0-8e20ee5e2820', 'Pneu Aro 19 Michelin Primacy 3', 'REF013', 499.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T20:30:00Z'),
                  ('5a4e3d8a-45fe-49c3-ae4d-2c2ab62d7fc5', 'Pneu Aro 16 Falken Sincera', 'REF014', 299.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T21:15:00Z'),
                  ('98ff51dd-85c9-4642-8c2f-8d70588fd987', 'Pneu Aro 18 Continental ExtremeContact', 'REF015', 599.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T22:00:00Z'),
                  ('8e42574a-0e3a-4b6d-b759-f79b2de4a9e2', 'Pneu Aro 15 Pirelli Scorpion Verde', 'REF016', 699.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T22:45:00Z'),
                  ('23f4b17b-b1f9-4d49-9b59-49ff4609c2df', 'Pneu Aro 17 Michelin Latitude', 'REF017', 299.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-21T23:30:00Z'),
                  ('e85449e6-bc21-40ef-872e-9a674881d2ed', 'Pneu Aro 16 Goodyear Assurance', 'REF018', 399.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-22T00:15:00Z'),
                  ('ee91e5da-cd7f-447d-a8b4-8ae6b2f1ae06', 'Pneu Aro 15 Falken Wildpeak', 'REF019', 149.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-22T01:00:00Z'),
                  ('bc9b9edf-5b36-4492-bdf1-f1652fcf5479', 'Pneu Aro 14 Yokohama BluEarth', 'REF020', 99.99, 'https://pbs.twimg.com/media/FzQ61CKXwAE7O_6?format=jpg', '2023-06-22T01:45:00Z');
                  ''');

          await db.execute('INSERT INTO usuarios (id, usuario, senha) VALUES (?, ?, ?)', [const Uuid().v4(), 'q', 'q']);
        },
      ),
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
        'foto': produto.foto,
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
              foto: e['foto'],
              dataCadastro: e['data_cadastro'],
            ))
        .toList();
  }

  Future<OrcamentoModel?> selectOrcamentoAtivo() async {
    final db = await database;
    List<Map<String, dynamic>> orcamentos = await db.query('orcamentos', where: 'ativo = ?', whereArgs: [1], limit: 1);

    if (orcamentos.isEmpty) {
      return null;
    }

    OrcamentoModel orcamentoModel = OrcamentoModel();
    orcamentoModel.id = orcamentos[0]['id'];
    orcamentoModel.dataCadastro = orcamentos[0]['data_cadastro'];
    orcamentoModel.total = orcamentos[0]['total'];
    orcamentoModel.ativo = orcamentos[0]['ativo'] == 1;
    return orcamentoModel;
  }

  Future<OrcamentoModel?> selectOrcamento(String idOrcamento) async {
    final db = await database;
    List<Map<String, dynamic>> orcamentos = await db.query('orcamentos', where: 'id = ?', whereArgs: [idOrcamento], limit: 1);

    if (orcamentos.isEmpty) {
      return null;
    }

    OrcamentoModel orcamentoModel = OrcamentoModel();
    orcamentoModel.id = orcamentos[0]['id'];
    orcamentoModel.dataCadastro = orcamentos[0]['data_cadastro'];
    orcamentoModel.total = orcamentos[0]['total'];
    orcamentoModel.ativo = orcamentos[0]['ativo'] == 1;
    return orcamentoModel;
  }

  Future<ItensOrcamentoModel?> selectItemOrcamento(String idOrcamento, String idProduto) async {
    final db = await database;
    List<Map<String, dynamic>> itens = await db.query('itens_orcamento', where: 'id_orcamento = ? AND id_produto = ?', whereArgs: [idOrcamento, idProduto], limit: 1);

    if (itens.isEmpty) {
      return null;
    }

    var item = itens.first;

    return ItensOrcamentoModel(
      id: item['id'],
      idOrcamento: item['id_orcamento'],
      idProduto: item['id_produto'],
      quantidade: item['quantidade'],
    );
  }

  Future<List<ItensOrcamentoModel>> selectListaItensOrcamento(String idOrcamento) async {
    final db = await database;
    List<Map<String, dynamic>> itens = await db.query('itens_orcamento', where: 'id_orcamento = ?', whereArgs: [idOrcamento]);

    log('itens $itens');

    return itens.map((e) {
      return ItensOrcamentoModel(
        id: e['id'],
        idOrcamento: e['id_orcamento'],
        idProduto: e['id_produto'],
        descricao: e['descricao'],
        valor: e['valor'],
        quantidade: e['quantidade'],
      );
    }).toList();
  }

  itemOrcamentoAtualizarQuantidade(String idItemOrcamento, double quantidade) async {
    final db = await database;
    await db.update(
      'itens_orcamento',
      {
        'quantidade': quantidade,
      },
      where: 'id = ?',
      whereArgs: [idItemOrcamento],
    );
  }

  insertItemOrcamento(String idOrcamento, ProdutoModel item) async {
    final db = await database;
    await db.insert(
      'itens_orcamento',
      {
        'id': const Uuid().v4(),
        'id_orcamento': idOrcamento,
        'id_produto': item.id,
        'descricao': item.descricao,
        'valor': item.valor,
        'quantidade': 1,
      },
    );
  }

  insertOrcamento(OrcamentoModel orcamento) async {
    final db = await database;
    await db.insert(
      'orcamentos',
      {
        'id': orcamento.id,
        'data_cadastro': orcamento.dataCadastro,
        'total': orcamento.total,
        'ativo': orcamento.ativo ? 1 : 0,
      },
    );
  }

  fecharOrcamentoAtivo(String idOrcamento) async {
    final db = await database;

    await db.delete('itens_orcamento', where: 'id_orcamento = ? AND quantidade <= 0', whereArgs: [idOrcamento]);

    List itens = await db.rawQuery('SELECT coalesce(sum(valor * quantidade), 0.0) AS total FROM itens_orcamento WHERE id_orcamento = ?', [idOrcamento]);

    double total = itens.first['total'];

    if (total > 0) {
      await db.update(
        'orcamentos',
        {
          'ativo': 0,
          'total': total,
        },
        where: 'id = ?',
        whereArgs: [idOrcamento],
      );
    }
  }

  Future<List<OrcamentoModel>> selectListaOrcamentos() async {
    final db = await database;
    List<Map<String, dynamic>> lista = await db.query('orcamentos',
        columns: [
          'id',
          'total',
          'data_cadastro',
        ],
        where: 'total > 0');

    return lista
        .map((e) => OrcamentoModel(
              id: e['id'],
              dataCadastro: e['data_cadastro'],
              total: e['total'],
            ))
        .toList();
  }

  Future<bool> login(String usuario, String senha) async {
    final db = await database;

    List<Map<String, dynamic>> lista = await db.query('usuarios',
        columns: [
          'usuario',
        ],
        where: 'usuario = ? AND senha = ?',
        whereArgs: [
          usuario,
          senha,
        ]);

    return lista.isNotEmpty;
  }
}
