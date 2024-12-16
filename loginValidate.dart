import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_v1/dashboard/menuDashboard.dart';
import 'package:projeto_v1/home.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
AutenticacaoServico _autenServico = AutenticacaoServico();

Future<void> loginValidate(
  TextEditingController _EmailController,
  TextEditingController _SenhaController,
  BuildContext context,
) async {
  // Verificar se os campos estão vazios
  if (_EmailController.text.trim().isEmpty ||
      _SenhaController.text.trim().isEmpty) {
    ScaffoldMessage(
      "Preencha todos os campos.",
      Color.fromARGB(255, 241, 88, 77),
      Icons.cancel,
      context,
    );
    return;
  }

  String email = _EmailController.text.trim();
  String senha = _SenhaController.text.trim();

  // Tentar cadastrar o usuário no Firebase Authentication
  User? usuario = await _autenServico.logarUsuario(
    email: email,
    senha: senha,
  );

  if (email == "adm@cs.com" && senha == "adm@senha") {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Menudashboard()),
        (route) => false);
  } else if (usuario != null) {
    // Cadastro bem-sucedido no Authentication, agora armazenar no Firestore
    String userId = usuario.uid;

    try {
      await db.collection("contatos").doc(userId).set({
        "email": email,
        "senha": senha,
      }, SetOptions(merge: true));

      // Limpar os campos de texto
      _EmailController.clear();
      _SenhaController.clear();

      ScaffoldMessage(
        "Login realizado!",
        Color.fromARGB(255, 106, 219, 63),
        Icons.check,
        context,
      );

      await Future.delayed(Duration(seconds: 2));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PrimeraPagina()),
          (route) => false);

      ScaffoldMessage(
        "Seja Bem-Vindo $email",
        Color.fromARGB(255, 106, 219, 63),
        Icons.person,
        context,
      );
    } catch (e) {
      // Tratar erros ao salvar no Firestore
      print('Erro ao salvar no Firestore: $e');
      ScaffoldMessage(
        "Erro ao carregar dados. Tente novamente.",
        Color.fromARGB(255, 241, 88, 77),
        Icons.error,
        context,
      );
    }
  } else {
    // Tratar falha no cadastro no Authentication
    ScaffoldMessage(
      "Erro ao logar usuário. Verifique os dados e tente novamente.",
      Color.fromARGB(255, 241, 88, 77),
      Icons.error,
      context,
    );
  }
}

ScaffoldMessage(
    String mensagem, Color color, IconData icon, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            mensagem,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
    backgroundColor: color,
    duration: Duration(seconds: 4),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(12),
        topLeft: Radius.circular(12),
      ),
    ),
  ));
}

class AutenticacaoServico {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> logarUsuario({
    required String senha,
    required String email,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      return userCredential.user;
    } on Exception {}
    return null;
  }
}
