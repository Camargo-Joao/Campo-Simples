import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_v1/ferramentasInfo.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';
import 'package:projeto_v1/widget_listtile.dart';
// Tela que será criada para exibir insumos por categoria

class Ferramentas extends StatefulWidget {
  @override
  _Ferramentas createState() => _Ferramentas();
}

class _Ferramentas extends State<Ferramentas> {
  // Função para buscar categorias no Firestore (os documentos da coleção 'insumos')
  Stream<QuerySnapshot> obterCategorias() {
    return FirebaseFirestore.instance.collection('ferramenta').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 255, 250, 226),
        automaticallyImplyLeading: true,
        title: Text("Ferramentas"),
        actions: [
          Container(
              margin: const EdgeInsets.all(10),
              child: widgetImage('imagens/insumosTitulo.png', 100)),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 250, 180),
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
          color: Color.fromARGB(255, 79, 118, 64),
          child: StreamBuilder<QuerySnapshot>(
            stream: obterCategorias(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 255, 250, 226),
                ));
              }

              if (snapshot.hasError) {
                return Center(child: Text('Erro ao carregar dados.'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('Nenhuma categoria encontrada.'));
              }

              // Lista de documentos (categorias)
              var documentos = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documentos.length,
                itemBuilder: (context, index) {
                  var categoria = documentos[index].id; // Nome da categoria

                  return widgetlisttile(
                      categoria,
                      ExibirFerramentaPorCategoria(categoria: categoria),
                      context);
                },
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: buttonHome(context),
    );
  }
}
