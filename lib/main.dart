import 'package:catalogo_flutter/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Catálogo de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    ),
  );
}

enum Rota {
  telaPrincipal,
  ;

  String get caminho => '/$name';
}
