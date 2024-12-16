import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_v1/cadastroValidate.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';
import 'package:projeto_v1/widget_login.dart';

class CadastroNoticias extends StatefulWidget {
  @override
  _CadastroNoticiasState createState() => _CadastroNoticiasState();
}

class _CadastroNoticiasState extends State<CadastroNoticias> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageLinkController = TextEditingController();
  final TextEditingController _siteLinkController = TextEditingController();

  // Função para salvar as notícias no Firestore
  Future<void> _saveNews() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('noticias').add({
        'titulo': _titleController.text,
        'imagem': _imageLinkController.text,
        'site': _siteLinkController.text,
        'data': FieldValue.serverTimestamp(), // Data do cadastro
      });
      ScaffoldMessage('Notícia adicionada', Color.fromARGB(255, 106, 219, 63),
          Icons.check, context);

      _formKey.currentState!.reset(); // Limpa o formulário após salvar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 253, 244, 226),
        automaticallyImplyLeading: true,
        title: Text("Cadastro Notícias"),
        actions: [
          Container(
              margin: const EdgeInsets.all(10),
              child: widgetImage('imagens/logo.png', 100)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        color: Color.fromARGB(255, 253, 244, 180),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 60),
              widgetField(false, 40, "Título", _titleController, Icons.title),
              SizedBox(height: 30),
              widgetField(
                  false, 40, "Imagem", _imageLinkController, Icons.image),
              SizedBox(height: 30),
              widgetField(false, 40, "Site", _siteLinkController, Icons.link),
              SizedBox(height: 30),
              ElevatedButton(
                style: buttonStyle(),
                onPressed: _saveNews,
                child: Text('Adicionar Notícia',
                    style:
                        TextStyle(color: Color.fromARGB(255, 253, 244, 180))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageLinkController.dispose();
    _siteLinkController.dispose();
    super.dispose();
  }
}
