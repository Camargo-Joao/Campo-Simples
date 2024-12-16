import 'package:flutter/material.dart';
import 'package:projeto_v1/ferramentas.dart';
import 'package:projeto_v1/insumos.dart';
import 'package:projeto_v1/noticias.dart';
import 'package:projeto_v1/pragas.dart';
import 'package:projeto_v1/previsao.dart';
import 'package:projeto_v1/profissionais.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_drawer.dart';
import 'package:projeto_v1/widget_image.dart';

class PrimeraPagina extends StatefulWidget {
  @override
  _PrimeraPaginaState createState() => _PrimeraPaginaState();
}

class _PrimeraPaginaState extends State<PrimeraPagina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 255, 250, 226),
        automaticallyImplyLeading: true,
        title: Text(
          "Campo Simples",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: widgetImage('imagens/logo.png', 100),
          ),
        ],
      ),
      drawer: WidgetDrawer(),
      body: Container(
        color: Color.fromARGB(255, 255, 250, 180),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Coluna 1
            Column(
              children: [
                SizedBox(height: 30),
                widgetButton_image(
                  Color.fromARGB(255, 106, 219, 63),
                  "Insumos",
                  150,
                  150,
                  'imagens/insumos.png',
                  context,
                  Insumos(),
                ),
                SizedBox(height: 30),
                widgetButton_image(
                  Color.fromARGB(255, 106, 219, 63),
                  "Ferramentas",
                  150,
                  150,
                  'imagens/ferramentas.png',
                  context,
                  Ferramentas(),
                ),
                SizedBox(height: 30),
                widgetButton_image(
                  Color.fromARGB(255, 106, 219, 63),
                  "Notícias",
                  150,
                  150,
                  'imagens/noticias.png',
                  context,
                  Noticias(),
                ),
              ],
            ),
            // Coluna 2
            Column(
              children: [
                SizedBox(height: 30),
                widgetButton_image(
                  Color.fromARGB(255, 106, 219, 63),
                  "Pragas",
                  150,
                  150,
                  'imagens/pragas.png',
                  context,
                  Pragas(),
                ),
                SizedBox(height: 30),
                widgetButton_image(
                  Color.fromARGB(255, 106, 219, 63),
                  "Profissionais",
                  150,
                  150,
                  'imagens/profissionas.png', // Verifique o nome da imagem
                  context,
                  Profissionais(),
                ),
                SizedBox(height: 30),
                widgetButton_image(
                  Color.fromARGB(255, 106, 219, 63),
                  "Previsão",
                  150,
                  150,
                  'imagens/previsao.png',
                  context,
                  Previsao(),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        height: 30,
        color: Color.fromARGB(255, 106, 219, 63),
        child: Container(
          child: Row(),
        ),
      ),
    );
  }
}
