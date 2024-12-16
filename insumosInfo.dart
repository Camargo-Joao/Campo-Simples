import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_v1/widget_animatedContainerInsu.dart';

class ExibirInsumosPorCategoria extends StatelessWidget {
  final String categoria;

  // Construtor para receber a categoria selecionada
  ExibirInsumosPorCategoria({required this.categoria});

  // Função para buscar insumos da categoria selecionada no Firestore
  Stream<DocumentSnapshot> obterInsumosDaCategoria() {
    return FirebaseFirestore.instance
        .collection('insumos')
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
            var insumos =
                List<Map<String, dynamic>>.from(snapshot.data!['insumos']);

            return ListView.builder(
              itemCount: insumos.length,
              itemBuilder: (context, index) {
                var insumo = insumos[index];

                return ListTile(
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedInsuWidget(
                          externalNome: insumo['nome'],
                          externalCaract1: insumo['funcao'],
                          externalCaract2: insumo['uso'],
                          externalCaract3: insumo['preco'],
                          externalSelect: insumo['compra']),
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
