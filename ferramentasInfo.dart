import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_v1/widget_animatedContainerInsu.dart';

class ExibirFerramentaPorCategoria extends StatelessWidget {
  final String categoria;

  // Construtor para receber a categoria selecionada
  ExibirFerramentaPorCategoria({required this.categoria});

  // Função para buscar insumos da categoria selecionada no Firestore
  Stream<DocumentSnapshot> obterInsumosDaCategoria() {
    return FirebaseFirestore.instance
        .collection('ferramenta')
        .doc(categoria)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 255, 250, 226),
        automaticallyImplyLeading: true,
        title: Text('$categoria'),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 250, 180),
        child: StreamBuilder<DocumentSnapshot>(
          stream: obterInsumosDaCategoria(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar dados.'));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(
                  child: Text('Nenhum insumo encontrado para esta categoria.'));
            }

            // Obtendo a lista de insumos como Map<String, dynamic>
            var ferramentas =
                List<Map<String, dynamic>>.from(snapshot.data!['ferramenta']);

            return ListView.builder(
              itemCount: ferramentas.length,
              itemBuilder: (context, index) {
                var ferramenta = ferramentas[index];

                return ListTile(
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedInsuWidget(
                          externalNome: ferramenta['nome'],
                          externalCaract1: ferramenta['funcao'],
                          externalCaract2: ferramenta['uso'],
                          externalCaract3: ferramenta['preco'],
                          externalSelect: ferramenta['compra']),
                    ],
                  ),
                  //leading: Icon(Icons.agriculture), // Ícone opcional
                  isThreeLine: true, // Permite mostrar três linhas na ListTile
                );
              },
            );
          },
        ),
      ),
    );
  }
}
