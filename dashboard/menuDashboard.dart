import 'package:flutter/material.dart';
import 'package:projeto_v1/dashboard/cadastro_ferramentas.dart';
import 'package:projeto_v1/dashboard/cadastro_insumos.dart';
import 'package:projeto_v1/dashboard/cadastro_noticias.dart';
import 'package:projeto_v1/dashboard/cadastro_pragas.dart';
import 'package:projeto_v1/dashboard/cadastro_profissional.dart';
import 'package:projeto_v1/home.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';

class Menudashboard extends StatefulWidget {
  const Menudashboard({super.key});

  @override
  State<Menudashboard> createState() => _MenudashboardState();
}

class _MenudashboardState extends State<Menudashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 255, 250, 226),
        automaticallyImplyLeading: true,
        title: Text(
          "Admisnistração CS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: widgetImage('imagens/logo.png', 100),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Color.fromARGB(255, 253, 244, 180),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widgetButton(
                      Color.fromARGB(255, 106, 219, 63),
                      Color.fromARGB(255, 255, 250, 226),
                      "Cadastrar Pragas",
                      150,
                      70,
                      CadastroPragas(),
                      context),
                  widgetButton(
                      Color.fromARGB(255, 106, 219, 63),
                      Color.fromARGB(255, 255, 250, 226),
                      "Cadastrar Profissionais",
                      150,
                      70,
                      CadastroProfissional(),
                      context),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widgetButton(
                      Color.fromARGB(255, 106, 219, 63),
                      Color.fromARGB(255, 255, 250, 226),
                      "Cadastrar Insumos",
                      150,
                      70,
                      CadastroInsumos(),
                      context),
                  widgetButton(
                      Color.fromARGB(255, 106, 219, 63),
                      Color.fromARGB(255, 255, 250, 226),
                      "Cadastrar Ferramentas",
                      150,
                      70,
                      CadastroFerramenta(),
                      context),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              widgetButton(
                  Color.fromARGB(255, 106, 219, 63),
                  Color.fromARGB(255, 255, 250, 226),
                  "Cadastrar Notícias",
                  150,
                  70,
                  CadastroNoticias(),
                  context),
              SizedBox(
                height: 20,
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
