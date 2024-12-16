import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_v1/abertura.dart';
import 'package:projeto_v1/contato.dart';
import 'package:projeto_v1/infoConta.dart';
import 'package:projeto_v1/sobreNos.dart';
import 'package:projeto_v1/widget_listtile.dart';
import 'package:projeto_v1/widget_image.dart';

class WidgetDrawer extends StatefulWidget {
  const WidgetDrawer({super.key});

  @override
  State<WidgetDrawer> createState() => _WidgetDrawerState();
}

class _WidgetDrawerState extends State<WidgetDrawer> {
  String? nomeUsuario;

  estiloTexto(double size) {
    return TextStyle(
      color: Color.fromARGB(255, 79, 118, 64),
      fontSize: size,
    );
  } //Estilo de texto padrão

  @override
  void initState() {
    super.initState();
    obterNomeUsuarioLogado();
  }

  Future<void> obterNomeUsuarioLogado() async {
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
            nomeUsuario = usuarioDoc.get("name");
          });
        } else {
          print("Usuário não encontrado no Firestore.");
        }
      } catch (e) {
        print("Erro ao buscar nome do usuário: $e");
      }
    } else {
      print("Nenhum usuário logado.");
    }
  }

  Future<Text> valueName() async {
    await Future.delayed(Duration(seconds: 3));

    return Text("Administração", style: estiloTexto(20));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 170,
          backgroundColor: Color.fromARGB(255, 253, 244, 180),
          foregroundColor: Color.fromARGB(255, 106, 219, 63),
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            child: Column(
              children: [
                SizedBox(height: 30),
                widgetImage('imagens/perfil.png', 100),
                SizedBox(height: 10),
                nomeUsuario != null
                    ? Text("$nomeUsuario", //Nome do suário
                        style: estiloTexto(20))
                    : FutureBuilder<Text>(
                        future: valueName(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              "Carregando...",
                              style: estiloTexto(15),
                            ); //Indicador de carregamento
                          } else if (snapshot.hasError) {
                            return Text(
                              "Erro ao carregar nome",
                              style: estiloTexto(15),
                            );
                          } else {
                            return snapshot.data!;
                          }
                        },
                      )
              ],
            ),
          ),
        ),
        body: Container(
          color: Color.fromARGB(255, 106, 219, 63),
          child: ListView(
            children: [
              SizedBox(height: 20),
              widgetlisttile("Informações da Conta", InfoConta(), context),
              widgetlisttile("Sobre Nós", SobreNos(), context),
              widgetlisttile("Suporte", Contato(), context),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Color.fromARGB(255, 253, 244, 180),
                  title: Text(
                    "Atenção $nomeUsuario",
                    style: TextStyle(
                      color: Color.fromARGB(255, 79, 118, 64),
                    ),
                  ),
                  content: Text(
                    "Tem certeza que deseja sair?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 79, 118, 64),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 106, 219, 63),
                        ),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Abertura()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Sim",
                        style: TextStyle(
                            color: Color.fromARGB(255, 253, 244, 180)),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 79, 118, 64),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha o diálogo
                      },
                      child: Text(
                        "Não",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 250, 226),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: Color.fromARGB(255, 79, 118, 64),
          foregroundColor: Color.fromARGB(255, 255, 250, 226),
          child: Text("Sair"),
        ),
      ),
    );
  }
}

Future<void> exibirAdm() async {
  await Future.delayed(Duration(seconds: 1));
  Text(
    "Administração",
    style: TextStyle(
      color: Color.fromARGB(255, 79, 118, 64),
      fontSize: 20,
    ),
  );
}
