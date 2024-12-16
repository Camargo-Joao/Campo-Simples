import 'package:flutter/material.dart';
import 'package:projeto_v1/cadastro.dart';
import 'package:projeto_v1/login.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';

class Abertura extends StatefulWidget {
  const Abertura({super.key});

  @override
  State<Abertura> createState() => _AberturaState();
}

class _AberturaState extends State<Abertura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 250, 180),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 106, 219, 63),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(120),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  widgetImage('imagens/logo.png', 160),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Campo Simples",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 252, 180),
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 110,
            ),
            widgetButton(
                Color.fromARGB(255, 106, 219, 63),
                Color.fromARGB(255, 255, 252, 180),
                "Login",
                150,
                40,
                widgetLogin(),
                context),
            SizedBox(
              height: 20,
            ),
            widgetButton(
                Color.fromARGB(255, 106, 219, 63),
                Color.fromARGB(255, 255, 252, 180),
                "Cadastre-se",
                150,
                40,
                Cadastro(),
                context)
          ],
        ),
      ),
    );
  }
}
