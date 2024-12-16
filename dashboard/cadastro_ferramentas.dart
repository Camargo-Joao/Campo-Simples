import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_v1/cadastroValidate.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_login.dart';

class CadastroFerramenta extends StatefulWidget {
  @override
  _CadastroFerramentaState createState() => _CadastroFerramentaState();
}

class _CadastroFerramentaState extends State<CadastroFerramenta> {
  // Mapa para armazenar os tipos de insumos e suas listas de insumos
  Map<String, List<Map<String, dynamic>>> insumosPorTipo = {
    'Arados': [],
    'Pulverizadores': [],
    'Enxadas': [],
  };

  // Controladores de texto
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController ferramentaController = TextEditingController();
  final TextEditingController funcaoController = TextEditingController();
  final TextEditingController precoController = TextEditingController();
  final TextEditingController usoController = TextEditingController();
  final TextEditingController compraController = TextEditingController();

  // Função para cadastrar insumos localmente e no Firestore
  void cadastrarFerramenta(String tipo, String ferramenta, String funcao,
      String preco, String uso, String compra) {
    setState(() {
      Map<String, dynamic> novoInsumo = {
        'nome': ferramenta,
        'funcao': funcao,
        'preco': preco,
        'uso': uso,
        'compra': compra,
      };

      if (insumosPorTipo.containsKey(tipo)) {
        insumosPorTipo[tipo]?.add(novoInsumo);
      } else {
        insumosPorTipo[tipo] = [novoInsumo];
      }
    });

    // Chama a função para enviar ao Firestore
    enviarInsumosParaFirestore(tipo, ferramenta, funcao, preco, uso, compra);
  }

  // Função para enviar insumos ao Firestore
  Future<void> enviarInsumosParaFirestore(String tipo, String ferramenta,
      String funcao, String preco, String uso, String compra) async {
    try {
      // Referência ao documento do tipo de insumo no Firestore
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('ferramenta').doc(tipo);

      // Atualiza o documento, adicionando o insumo à lista do tipo
      await docRef.set(
          {
            'ferramenta': FieldValue.arrayUnion([
              {
                'nome': ferramenta,
                'funcao': funcao,
                'preco': preco,
                'uso': uso,
                'compra': compra,
              }
            ]), // Adiciona insumo na lista
          },
          SetOptions(
              merge: true)); // Utiliza merge para manter os dados existentes
      ScaffoldMessage('Ferramenta $ferramenta do tipo $tipo Adicionada',
          Color.fromARGB(255, 106, 219, 63), Icons.check, context);
    } catch (e) {
      ScaffoldMessage('Erro ao enviar a ferramenta: $e',
          Color.fromARGB(255, 219, 63, 63), Icons.check, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 253, 244, 226),
        automaticallyImplyLeading: true,
        title: Text('Cadastro de Ferramenta'),
      ),
      body: Container(
        color: Color.fromARGB(255, 253, 244, 180),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              widgetField(
                  false, 40, "categoria", tipoController, Icons.category),
              SizedBox(height: 20),
              widgetField(
                  false, 40, "nome", ferramentaController, Icons.edit_document),
              SizedBox(height: 20),
              widgetField(false, 40, "função", funcaoController,
                  Icons.flourescent_rounded),
              SizedBox(height: 20),
              widgetField(
                  false, 40, "preço", precoController, Icons.price_change),
              SizedBox(height: 20),
              widgetField(false, 40, "uso", usoController,
                  Icons.system_security_update_good_sharp),
              SizedBox(height: 20),
              widgetField(false, 40, "compra", compraController, Icons.link),
              SizedBox(height: 20),
              ElevatedButton(
                style: buttonStyle(),
                onPressed: () {
                  if (tipoController.text.isNotEmpty &&
                      ferramentaController.text.isNotEmpty &&
                      funcaoController.text.isNotEmpty &&
                      precoController.text.isNotEmpty &&
                      usoController.text.isNotEmpty &&
                      compraController.text.isNotEmpty) {
                    cadastrarFerramenta(
                      tipoController.text,
                      ferramentaController.text,
                      funcaoController.text,
                      precoController.text,
                      usoController.text,
                      compraController.text,
                    );
                    tipoController.clear();
                    ferramentaController.clear();
                    funcaoController.clear();
                    precoController.clear();
                    usoController.clear();
                    compraController.clear();
                  }
                },
                child: Text('Adicionar Ferramenta'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
