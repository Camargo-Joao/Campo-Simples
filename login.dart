import 'package:flutter/material.dart';
import 'package:projeto_v1/cadastro.dart';
import 'package:projeto_v1/loginValidate.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';
import 'package:projeto_v1/widget_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class widgetLogin extends StatefulWidget {
  @override
  State<widgetLogin> createState() => _widgetLoginState();
}

class _widgetLoginState extends State<widgetLogin> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController _EmailController = TextEditingController();
  TextEditingController _SenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //hadder
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 106, 219, 63),
          foregroundColor: Color.fromARGB(255, 253, 244, 226),
          automaticallyImplyLeading: true,
          title: Text("Login"),
          actions: [
            Container(
                margin: const EdgeInsets.all(10),
                child: widgetImage('imagens/logo.png', 100)),
          ],
        ),
        //main content
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(0),
                width: double.infinity,
                height: 1200,
                padding: const EdgeInsets.all(40),
                color: Color.fromARGB(255, 255, 252, 180),
                child: Column(children: [
                  SizedBox(
                    height: 150,
                    child: widgetImage('imagens/logo.png', 100),
                  ),
                  Container(
                      child: Text(
                    "Campo Simples",
                    style: TextStyle(
                        color: Color.fromARGB(255, 106, 219, 63), fontSize: 20),
                  )),
                  SizedBox(
                    height: 40,
                  ),
                  widgetField(false, 40, "Email", _EmailController, Icons.mail),
                  SizedBox(
                    height: 30,
                  ),
                  //passwordField,
                  widgetObscureChange(40, "Senha", _SenhaController, setState),

                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () => loginValidate(
                        _EmailController, _SenhaController, context),
                    child: Text("Logar"),
                    style: buttonStyle(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Não Possui uma conta?"),
                  SizedBox(
                    height: 10,
                  ),
                  widgetButtonCadastrar(
                      Color.fromARGB(255, 255, 252, 180),
                      Color.fromARGB(255, 106, 219, 63),
                      "Cadastre-se",
                      150,
                      20,
                      Cadastro(),
                      context)
                ])),
          ),
        ));
  }
}
