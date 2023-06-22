import 'package:catalogo_flutter/banco/helper.dart';

class LoginController {
  String _usuario = '';
  String _senha = '';

  Future<bool> login() async {
    return await BancoHelper().login(_usuario, _senha);
  }

  String? deveSerPreenchido(String? value) {
    value ??= '';
    if (value.isEmpty) {
      return 'Deve ser preenchido';
    }
    return null;
  }

  void usuarioSaved(String? newValue) {
    _usuario = newValue ?? '';
  }

  void senhaSaved(String? newValue) {
    _senha = newValue ?? '';
  }
}
