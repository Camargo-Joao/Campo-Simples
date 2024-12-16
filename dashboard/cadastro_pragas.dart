import 'package:flutter/material.dart';
import 'package:projeto_v1/cadastroValidate.dart';
import 'package:projeto_v1/home.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';
import 'package:projeto_v1/widget_login.dart';
import 'package:uuid/uuid.dart';

class CadastroPragas extends StatefulWidget {
  const CadastroPragas({super.key});

  @override
  State<CadastroPragas> createState() => _CadastroPragasState();
}

class _CadastroPragasState extends State<CadastroPragas> {
  TextEditingController _NomeController = TextEditingController();
  TextEditingController _DescricaoController = TextEditingController();
  TextEditingController _TratamentoController = TextEditingController();
  TextEditingController _ProfissionailController = TextEditingController();
  TextEditingController _ImagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 253, 244, 226),
        automaticallyImplyLeading: true,
        title: Text("Cadastro Pragas"),
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
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              widgetField(
                  false, 40, "Nome", _NomeController, Icons.account_circle),
              SizedBox(
                height: 30,
              ),
              widgetField(false, 40, "Descrição", _DescricaoController,
                  Icons.description),
              SizedBox(
                height: 30,
              ),
              widgetField(false, 40, "Tratamento", _TratamentoController,
                  Icons.addchart_outlined),
              SizedBox(
                height: 30,
              ),
              widgetField(false, 40, "Profissional", _ProfissionailController,
                  Icons.account_box_rounded),
              SizedBox(
                height: 30,
              ),
              widgetField(false, 40, "Imagem", _ImagemController, Icons.image),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: buttonStyle(),
                  onPressed: () {
                    _sendData(
                        _NomeController,
                        _DescricaoController,
                        _TratamentoController,
                        _ProfissionailController,
                        _ImagemController,
                        context);
                  },
                  child: Text("Adicionar Praga")),
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
  TextEditingController _DescricaoController,
  TextEditingController _TratamentoController,
  TextEditingController _ProfissionalController,
  TextEditingController _ImagemController,
  BuildContext context,
) {
  String id = Uuid().v1();
  db.collection("pragas").doc(id).set({
    "nome": _NomeController.text,
    "descricao": _DescricaoController.text,
    "tratamento": _TratamentoController.text,
    "profissional": _ProfissionalController.text,
    "imagem": _ImagemController.text,
  });
  _NomeController.text = "";
  _DescricaoController.text = "";
  _TratamentoController.text = "";
  _ProfissionalController.text = "";
  _ImagemController.text = "";

  ScaffoldMessage("Praga Cadastrada!", Color.fromARGB(255, 106, 219, 63),
      Icons.check, context);
}
