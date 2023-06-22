import 'package:uuid/uuid.dart';

class OrcamentoModel {
  String id;
  String dataCadastro;
  bool ativo;

  OrcamentoModel({
    this.id = '',
    this.dataCadastro = '',
    this.ativo = false,
  });

  OrcamentoModel.novo()
      : id = const Uuid().v4(),
        dataCadastro = DateTime.now().toIso8601String(),
        ativo = true;
}
