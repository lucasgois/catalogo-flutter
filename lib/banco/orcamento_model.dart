import 'package:uuid/uuid.dart';

class OrcamentoModel {
  String id;
  String dataCadastro;
  double total;
  bool ativo;

  OrcamentoModel({
    this.id = '',
    this.dataCadastro = '',
    this.total = 0.0,
    this.ativo = false,
  });

  OrcamentoModel.novo()
      : id = const Uuid().v4(),
        dataCadastro = DateTime.now().toIso8601String(),
        total = 0.0,
        ativo = true;
}
