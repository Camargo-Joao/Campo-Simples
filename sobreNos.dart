import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_v1/widget_image.dart';

class SobreNos extends StatefulWidget {
  const SobreNos({super.key});

  @override
  State<SobreNos> createState() => _SobreNosState();
}

TextStyle texto = TextStyle(
  fontSize: 16,
  color: Color.fromARGB(255, 79, 118, 64),
);

TextStyle titulo = TextStyle(
  fontSize: 20,
  color: Color.fromARGB(255, 79, 118, 64),
);

class _SobreNosState extends State<SobreNos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 255, 250, 226),
        automaticallyImplyLeading: true,
        title: Text("Sobre Nós"),
      ),

      //main content
      body: SingleChildScrollView(
        child: Container(
          width: max(200, 900),
          color: Color.fromARGB(255, 255, 250, 180),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 170,
                width: 170,
                child: widgetImage("imagens/logo.png", 100),
              ),
              SizedBox(height: 20),
              ContainerColumn(
                Text(
                  "Empresa",
                  style: titulo,
                ),
                Text(
                  "A Campo Simples se coloca comprometida na intenção de levar este meio tecnológico ao pequeno produtor, por meio de um aplicativo que o auxilie em fatores fundamentais para o funcionamento de seu agronegócio, desde a compra de insumos à mediação de relações comerciais entre produtores e profissionais da área agronômica.",
                  style: texto,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 20),
              ContainerColumn(
                Text(
                  "Aplicativo",
                  style: titulo,
                ),
                Text(
                  "Sendo um software voltado totalmente ao produtor rural, O Campo Simples tem como o objetivo de facilitar a gestão e a organização da uma fazenda que provém da agricultura familiar e abastece a casa de inúmeros brasileiros. Sob essa lógica, sua interface inicial oferece diferentes serviços ao usuário.",
                  style: texto,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 20),
              ContainerColumn(
                Text(
                  "Serviços",
                  style: titulo,
                ),
                Text(
                  "Os serviços oferecidos pelo Campo Simples são: compra de INSUMOS e FERRAMENTAS, acesso a características e tratamento de possíveis PRAGAS, contato direto com PROFISSIONAIS do mercado agronômico, acesso a NOTÌCIAS da agropecuária e PREVISÂO do tempo.",
                  style: texto,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Desenvolvido por: João Pedro Camargo",
                style: texto,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container ContainerColumn(Widget titulo, Widget texto) {
    return Container(
      padding: EdgeInsets.all(17),
      child: Column(
        children: [
          titulo,
          SizedBox(
            height: 5,
          ),
          texto,
        ],
      ),
    );
  }
}
