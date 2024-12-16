import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_v1/widget_image.dart';
import 'package:url_launcher/url_launcher.dart';

class Contato extends StatefulWidget {
  const Contato({super.key});

  @override
  State<Contato> createState() => _ContatoState();
}

TextStyle texto = TextStyle(
  fontSize: 16,
  color: Color.fromARGB(255, 79, 118, 64),
);

TextStyle titulo = TextStyle(
  fontSize: 20,
  color: Color.fromARGB(255, 255, 250, 226),
);

class _ContatoState extends State<Contato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 255, 250, 226),
        automaticallyImplyLeading: true,
        title: Text("Contato"),
      ),

      //main content
      body: SingleChildScrollView(
        child: Container(
          width: max(200, 900),
          height: max(200, 900),
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
              Text(
                "Teve problemas?\n Quer dar uma sugestão?\n Entre em contato!",
                style: texto,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                  width: 300,
                  height: 50,
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 79, 118, 64),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: GestureDetector(
                    onTap: () => _openNewsLink(
                        "https://mail.google.com/mail/u/0/#inbox?compose=DmwnWrRtsnRBFBHTlMMrfJxCBqmQSDrRdWLtCDfmRZgKHkTjlKzvFCLfLhwmMnfrxxHtxBMrhtBg"),
                    child: Text(
                      "camposimples@gmail.com",
                      style: titulo,
                      textAlign: TextAlign.center,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

void _openNewsLink(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // Caso o link não possa ser aberto
    print('Não foi possível abrir o link: $url');
  }
}
