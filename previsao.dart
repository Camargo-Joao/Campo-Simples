import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_v1/previsaoData.dart';
import 'package:projeto_v1/previsaoFetch.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart'; // Substitua pelo caminho correto do seu WeatherService

class Previsao extends StatefulWidget {
  @override
  _PrevisaoState createState() => _PrevisaoState();
}

TextStyle style =
    TextStyle(color: Color.fromARGB(255, 255, 250, 226), fontSize: 18);

class _PrevisaoState extends State<Previsao> {
  String? estadoUsuario;
  final WeatherService _weatherService = WeatherService();
  Future<Map<String, dynamic>>? _weatherData;

  Future<void> obterEstadoUsuarioLogado() async {
    User? usuarioLogado = FirebaseAuth.instance.currentUser;

    if (usuarioLogado != null) {
      String userId = usuarioLogado.uid;

      try {
        DocumentSnapshot usuarioDoc = await FirebaseFirestore.instance
            .collection("contatos")
            .doc(userId)
            .get();

        if (usuarioDoc.exists) {
          setState(() {
            estadoUsuario = usuarioDoc.get("estado");

            if (estadoUsuario != null) {
              _weatherData = _weatherService.fetchWeather(estadoUsuario!);
            }
            if (_weatherData == 0000000000000001) {
              estadoUsuario = "";
            }
          });
        } else {
          print("Usuário não encontrado no Firestore.");
        }
      } catch (e) {
        print("Erro ao buscar estado do usuário: $e");
      }
    } else {
      print("Nenhum usuário logado.");
    }
  }

  @override
  void initState() {
    super.initState();
    obterEstadoUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 255, 250, 226),
        title: Text("Previsão"),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: widgetImage('imagens/previsaoTitulo.png', 100),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          color: Color.fromARGB(255, 255, 250, 180),
          child: Column(
            children: [
              SizedBox(height: 30),
              previsaoFetch(
                estadoUsuario ?? "",
                CircularProgressIndicator(
                    color: Color.fromARGB(255, 106, 219, 63)),
              ),
              IfEstado(estadoUsuario ?? "", "São Paulo"),
              IfEstado(estadoUsuario ?? "", "Mato Grosso"),
              IfEstado(estadoUsuario ?? "", "Paraná"),
              IfEstado(estadoUsuario ?? "", "Minas Gerais"),
              IfEstado(estadoUsuario ?? "", "Rio Grande do Sul"),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buttonHome(context),
    );
  }
}

// Função para exibir previsão para estados diferentes
Widget IfEstado(String Uestado, String estado) {
  if (Uestado != estado) {
    return Column(
      children: [
        SizedBox(height: 30),
        previsaoFetch(estado, Text(" ")),
      ],
    );
  }
  return SizedBox
      .shrink(); // Retorna um widget vazio caso os estados sejam iguais
}
