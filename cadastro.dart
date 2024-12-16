import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_v1/cadastroValidate.dart';

import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';
import 'package:projeto_v1/widget_login.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController _NameController = TextEditingController();
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _SenhaController = TextEditingController();
  String errorMessege = "";
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //hadder
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 253, 244, 226),
        automaticallyImplyLeading: true,
        title: Text("Cadastro"),
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
            height: 770,
            color: Color.fromARGB(255, 255, 252, 180),
            padding: const EdgeInsets.all(40),
            child: Column(children: [
              SizedBox(
                  height: 150, child: widgetImage('imagens/logo.png', 100)),
              Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    "Campo Simples",
                    style: TextStyle(
                        color: Color.fromARGB(255, 106, 219, 63), fontSize: 20),
                  )),
              SizedBox(
                height: 30,
              ),
              widgetField(
                  false, 40, "Nome", _NameController, Icons.account_circle),
              SizedBox(
                height: 30,
              ),
              widgetField(false, 40, "Email", _EmailController, Icons.mail),
              SizedBox(
                height: 30,
              ),
              widgetObscureChange(40, "Senha", _SenhaController, setState),
              SizedBox(
                height: 30,
              ),

              //Dropdowon do cadastro
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
                    "Selecione um Estado",
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
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => cadastroValidate(_EmailController,
                    _SenhaController, _NameController, _selectedValue, context),
                child: Text("Cadastrar"),
                style: buttonStyle(),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
