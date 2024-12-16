import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_v1/widget_animatedContainerPrags.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';

// Modelo para a Praga
class Praga {
  String nome;
  String descricao;
  String tratamento;
  String profissional;
  String imagem;

  Praga({
    required this.nome,
    required this.descricao,
    required this.tratamento,
    required this.profissional,
    required this.imagem,
  });

  // Método para criar uma instância de Praga a partir de um Map (dados do Firestore)
  factory Praga.fromMap(Map<String, dynamic> data) {
    return Praga(
      nome: data['nome'] ?? '',
      descricao: data['descricao'] ?? '',
      tratamento: data['tratamento'] ?? '',
      profissional: data['profissional'] ?? '',
      imagem: data['imagem'] ?? '',
    );
  }
}

// Função que retorna um Stream de lista de Pragas, puxando do Firestore
Stream<List<Praga>> getPragas() {
  return FirebaseFirestore.instance
      .collection('pragas') // Nome da coleção no Firestore
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Praga.fromMap(doc.data())).toList());
}

class Pragas extends StatelessWidget {
  const Pragas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 253, 244, 226),
        automaticallyImplyLeading: true,
        title: Text("Pragas"),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: widgetImage('imagens/pragasTitulo.png', 100),
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 253, 244, 180),
        child: StreamBuilder<List<Praga>>(
          stream: getPragas(),
          builder: (context, snapshot) {
            // Verifica se está carregando os dados
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 106, 219, 63),
              ));
            }

            // Verifica se houve erro ao carregar os dados
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar dados.'));
            }

            // Verifica se a lista está vazia
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhuma praga encontrada.'));
            }

            // Dados carregados com sucesso
            final pragas = snapshot.data!;

            return ListView.builder(
              itemCount: pragas.length,
              itemBuilder: (context, index) {
                final praga = pragas[index];
                return AnimatedContainerWidget(
                  externalImagem: praga.imagem,
                  externalNome: praga.nome,
                  externalCaract: praga.descricao,
                  externalTrat: praga.tratamento,
                  externalEspec: praga.profissional,
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: buttonHome(context),
    );
  }
}
