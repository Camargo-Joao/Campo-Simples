import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_v1/widget_animatedContainerProf.dart';
import 'package:projeto_v1/widget_button.dart';
import 'package:projeto_v1/widget_image.dart';

class Profissional {
  String nome;
  String area;
  String especialidade;
  String telefone;

  Profissional({
    required this.nome,
    required this.area,
    required this.especialidade,
    required this.telefone,
  });

  factory Profissional.fromMap(Map<String, dynamic> data) {
    return Profissional(
      nome: data['nome'] ?? '',
      area: data['area'] ?? '',
      especialidade: data['especialidade'] ?? '',
      telefone: data['telefone'] ?? '',
    );
  }
}

Stream<List<Profissional>> getProfissionais() {
  return FirebaseFirestore.instance.collection('profissionais').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Profissional.fromMap(doc.data()))
          .toList());
}

class Profissionais extends StatelessWidget {
  final String? profissionalId;

  const Profissionais({super.key, this.profissionalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 253, 244, 226),
        automaticallyImplyLeading: true,
        title: Text("Profissionais"),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: widgetImage('imagens/profissionasTitulo.png', 100),
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 253, 244, 180),
        child: StreamBuilder<List<Profissional>>(
          stream: getProfissionais(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 106, 219, 63),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar dados.'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhum profissional encontrado.'));
            }

            final profissionais = snapshot.data!;

            if (profissionalId != null) {
              final indexProfissional = profissionais.indexWhere(
                  (p) => p.nome.toLowerCase() == profissionalId!.toLowerCase());

              if (indexProfissional != -1) {
                final profissionalSelecionado =
                    profissionais.removeAt(indexProfissional);
                profissionais.insert(0, profissionalSelecionado);
              }
            }

            return ListView.builder(
              itemCount: profissionais.length,
              itemBuilder: (context, index) {
                final profissional = profissionais[index];

                final isSelected = (profissional.nome.toLowerCase() ==
                    profissionalId?.toLowerCase());

                return AnimatedProfWidget(
                  externalNome: profissional.nome,
                  externalArea: profissional.area,
                  externalEspec: profissional.especialidade,
                  externalNumber: profissional.telefone,
                  isInitiallyExpanded:
                      isSelected, // Ajuste para o container iniciar expandido
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
