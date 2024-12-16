import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_v1/cadastroValidate.dart';
import 'package:projeto_v1/contato.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';
import 'package:projeto_v1/widget_login.dart';

class InfoConta extends StatefulWidget {
  const InfoConta({super.key});

  @override
  State<InfoConta> createState() => _InfoContaState();
}

TextStyle style =
    TextStyle(color: Color.fromARGB(255, 79, 118, 64), fontSize: 18);

TextStyle style2 =
    TextStyle(color: Color.fromARGB(255, 79, 118, 64), fontSize: 12);

class _InfoContaState extends State<InfoConta> {
  String? nomeUsuario;
  String? emailUsuario;
  String? estadoUsuario;
  String? _selectedValue;

  // Controladores para os campos de texto
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obterUsuarioLogado();
  }

  Future<void> obterUsuarioLogado() async {
    User? usuarioLogado = FirebaseAuth.instance.currentUser;

    if (usuarioLogado != null) {
      String userId = usuarioLogado.uid;

      try {
        DocumentSnapshot usuarioDoc = await FirebaseFirestore.instance
            .collection("contatos")
            .doc(userId)
            .get();

        if (usuarioDoc.exists) {
          setState(() {
            nomeUsuario = usuarioDoc.get("name");
            emailUsuario = usuarioDoc.get("email");
            estadoUsuario = usuarioDoc.get("estado");

            // Preenche os controladores com os valores obtidos
            nomeController.text = nomeUsuario ?? '';
            emailController.text = emailUsuario ?? '';
            estadoController.text = estadoUsuario ?? '';
          });
        } else {
          print("Usuário não encontrado no Firestore.");
        }
      } catch (e) {
        print("Erro ao buscar usuário: $e");
      }
    } else {
      print("Nenhum usuário logado.");
    }
  }

  // Função para atualizar as informações do usuário no Firestore
  Future<void> atualizarInformacoes() async {
    User? usuarioLogado = FirebaseAuth.instance.currentUser;

    if (usuarioLogado != null) {
      String userId = usuarioLogado.uid;

      try {
        await FirebaseFirestore.instance
            .collection("contatos")
            .doc(userId)
            .update({
          'name': nomeController.text,
          'email': emailController.text,
          'estado': _selectedValue,
        });

        ScaffoldMessage("Informações atualizadas com sucesso!",
            Color.fromARGB(255, 106, 219, 63), Icons.check, context);
      } catch (e) {
        ScaffoldMessage(
          "Erro ao atualizar informações.",
          Color.fromARGB(255, 241, 88, 77),
          Icons.error,
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 255, 250, 226),
        title: Text("Informações da Conta"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: max(200, 900),
          color: Color.fromARGB(255, 255, 250, 180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 120,
                width: 120,
                child: widgetImage("imagens/perfil.png", 100),
              ),
              SizedBox(height: 20),

              // Nome editável

              widgetField(false, 40, "Nome", nomeController, Icons.person),
              SizedBox(height: 20),

              // Email editável
              widgetField(false, 40, "Email", emailController, Icons.email),
              SizedBox(height: 20),

              // Estado editável
              Container(
                width: 600,
                height: 40,
                padding: EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 2,
                      color: Color.fromARGB(255, 79, 118, 64),
                    )),
                child: DropdownButton<String>(
                  isExpanded: true,
                  iconSize: 30,
                  menuMaxHeight: 200,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 106, 219, 63),
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(255, 79, 118, 64), fontSize: 16),
                  underline: SizedBox(),
                  dropdownColor: Color.fromARGB(255, 255, 252, 180),
                  hint: Text(
                    "$estadoUsuario",
                    style: TextStyle(color: Color.fromARGB(255, 79, 118, 64)),
                  ),
                  value: _selectedValue,
                  items: <String>[
                    "Acre",
                    "Alagoas",
                    "Amapá",
                    "Amazonas",
                    "Bahia",
                    "Ceará",
                    "Distrito Federal",
                    "Espírito Santo",
                    "Goiás",
                    "Maranhão",
                    "Mato Grosso",
                    "Mato Grosso do Sul",
                    "Minas Gerais",
                    "Pará",
                    "Paraíba",
                    "Paraná",
                    "Pernambuco",
                    "Piauí",
                    "Rio de Janeiro",
                    "Rio Grande do Norte",
                    "Rio Grande do Sul",
                    "Rondônia",
                    "Roraima",
                    "Santa Catarina",
                    "São Paulo",
                    "Sergipe",
                    "Tocantins"
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                  },
                ),
              ),
              SizedBox(height: 40),

              // Botão para salvar as alterações
              ElevatedButton(
                  onPressed: atualizarInformacoes,
                  child: Text("Salvar Alterações"),
                  style: buttonStyle()),

              SizedBox(height: 40),
              Text(
                "Algum problema com sua conta?",
                style: style2,
              ),
              SizedBox(height: 10),
              widgetButtonCadastrar(
                Color.fromARGB(255, 255, 252, 180),
                Color.fromARGB(255, 106, 219, 63),
                "Fale Conosco",
                150,
                20,
                Contato(),
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
