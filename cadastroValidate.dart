import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_v1/login.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
AutenticacaoServico _autenServico = AutenticacaoServico();

Future<void> cadastroValidate(
  TextEditingController _EmailController,
  TextEditingController _SenhaController,
  TextEditingController _NameController,
  dynamic estado,
  BuildContext context,
) async {
  // Verificar se os campos estão vazios
  if (_EmailController.text.trim().isEmpty ||
      _SenhaController.text.trim().isEmpty ||
      _NameController.text.trim().isEmpty) {
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
  String nome = _NameController.text.trim();

  // Tentar cadastrar o usuário no Firebase Authentication
  User? usuario = await _autenServico.cadastrarUsuario(
    email: email,
    senha: senha,
    nome: nome,
  );

  if (usuario != null) {
    // Cadastro bem-sucedido no Authentication, agora armazenar no Firestore
    String userId = usuario.uid;

    try {
      await db.collection("contatos").doc(userId).set({
        "name": nome,
        "email": email,
        "senha": senha,
        "estado": estado,
      });

      // Limpar os campos de texto
      _NameController.clear();
      _EmailController.clear();
      _SenhaController.clear();

      ScaffoldMessage(
        "Cadastro realizado!",
        Color.fromARGB(255, 106, 219, 63),
        Icons.check,
        context,
      );

      await Future.delayed(Duration(seconds: 1));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widgetLogin()),
          (route) => false);
    } catch (e) {
      // Tratar erros ao salvar no Firestore
      print('Erro ao salvar no Firestore: $e');
      ScaffoldMessage(
        "Erro ao salvar dados. Tente novamente.",
        Color.fromARGB(255, 241, 88, 77),
        Icons.error,
        context,
      );
    }
  } else {
    // Tratar falha no cadastro no Authentication
    ScaffoldMessage(
      "Erro ao cadastrar usuário. Verifique os dados e tente novamente.",
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
    duration: Duration(seconds: 2),
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

  Future<User?> cadastrarUsuario({
    required String nome,
    required String senha,
    required String email,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Atualizar o perfil do usuário com o nome
      await userCredential.user?.updateDisplayName(nome);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Trate os erros conforme necessário
      print('Erro ao cadastrar usuário: $e');
      return null;
    }
  }
}
