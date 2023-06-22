import 'package:catalogo_flutter/screens/login/login_controller.dart';
import 'package:catalogo_flutter/screens/produtos/produtos_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = LoginController();
  final _formKey = GlobalKey<FormState>();

  String? _mensagemErroLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Usuário', errorText: _mensagemErroLogin),
                validator: _controller.deveSerPreenchido,
                onSaved: _controller.usuarioSaved,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha', errorText: _mensagemErroLogin),
                validator: _controller.deveSerPreenchido,
                onSaved: _controller.senhaSaved,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (_controller.login()) {
                      setState(() => _mensagemErroLogin = null);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  ProdutosScreen()),
                      );
                    } else {
                      setState(() => _mensagemErroLogin = 'Usuário ou senha inválidos');
                    }
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
