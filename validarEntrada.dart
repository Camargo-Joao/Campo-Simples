import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_v1/abertura.dart';
import 'package:projeto_v1/home.dart';

class ValidarEntrada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // Se o usuário estiver logado, navegue para a página principal
          return PrimeraPagina();
        } else {
          // Se não estiver logado, vá para a página de login
          return Abertura();
        }
      },
    );
  }
}
