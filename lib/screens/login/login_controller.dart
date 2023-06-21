class LoginController {
  String _usuario = '';
  String _senha = '';

  bool login() {
    return _usuario == '1' && _senha == '1';
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
