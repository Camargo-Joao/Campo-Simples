import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_v1/cadastroValidate.dart';
import 'package:projeto_v1/home.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';
import 'package:projeto_v1/widget_login.dart';
import 'package:uuid/uuid.dart';

class CadastroProfissional extends StatefulWidget {
  const CadastroProfissional({super.key});

  @override
  State<CadastroProfissional> createState() => _CadastroProfissionalState();
}

class _CadastroProfissionalState extends State<CadastroProfissional> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController _NomeController = TextEditingController();
  TextEditingController _EspecialController = TextEditingController();
  TextEditingController _AreaController = TextEditingController();
  TextEditingController _NumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 253, 244, 226),
        automaticallyImplyLeading: true,
        title: Text("Cadastro Profissionais"),
        actions: [
          Container(
              margin: const EdgeInsets.all(10),
              child: widgetImage('imagens/logo.png', 100)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        color: Color.fromARGB(255, 253, 244, 180),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              widgetField(
                  false, 40, "Nome", _NomeController, Icons.account_circle),
              SizedBox(
                height: 30,
              ),
              widgetField(false, 40, "Area", _AreaController,
                  Icons.app_registration_outlined),
              SizedBox(
                height: 30,
              ),
              widgetField(false, 40, "Especialidade", _EspecialController,
                  Icons.analytics_outlined),
              SizedBox(
                height: 30,
              ),
              widgetField(
                  false, 40, "Telefone", _NumberController, Icons.phone),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: buttonStyle(),
                  onPressed: () {
                    _sendData(_NomeController, _AreaController,
                        _EspecialController, _NumberController, context);
                  },
                  child: Text("Adicionar Profissional")),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: buttonStyle(),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrimeraPagina()));
                  },
                  child: Text("Menu Princial")),
            ],
          ),
        ),
      ),
    );
  }
}

_sendData(
  TextEditingController _NomeController,
  TextEditingController _AreaController,
  TextEditingController _EspecialController,
  TextEditingController _NumberController,
  BuildContext context,
) {
  String id = Uuid().v1();
  db.collection("profissionais").doc(id).set({
    "nome": _NomeController.text,
    "area": _AreaController.text,
    "especialidade": _EspecialController.text,
    "telefone": _NumberController.text,
  });
  _NomeController.text = "";
  _AreaController.text = "";
  _EspecialController.text = "";
  _NumberController.text = "";

  ScaffoldMessage("Profissional Cadastrado", Color.fromARGB(255, 106, 219, 63),
      Icons.check, context);
}
