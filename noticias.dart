import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_v1/widget_image.dart';
import 'package:url_launcher/url_launcher.dart';

class Noticia {
  String titulo;
  String imagem;
  String site;

  Noticia({
    required this.titulo,
    required this.imagem,
    required this.site,
  });

  // Método para criar uma instância de Praga a partir de um Map (dados do Firestore)
  factory Noticia.fromMap(Map<String, dynamic> data) {
    return Noticia(
      titulo: data['titulo'] ?? '',
      imagem: data['imagem'] ?? '',
      site: data['site'] ?? '',
    );
  }
}

// Função que retorna um Stream de lista de Pragas, puxando do Firestore
Stream<List<Noticia>> getNoticias() {
  return FirebaseFirestore.instance
      .collection('noticias') // Nome da coleção no Firestore
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Noticia.fromMap(doc.data())).toList());
}

class Noticias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 106, 219, 63),
        foregroundColor: Color.fromARGB(255, 253, 244, 226),
        automaticallyImplyLeading: true,
        title: Text("Notícias"),
        actions: [
          Container(
              margin: const EdgeInsets.all(10),
              child: widgetImage('imagens/lupaTitulo.png', 100)),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 253, 244, 180),
        child: StreamBuilder<List<Noticia>>(
          stream: getNoticias(),
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
              return Center(child: Text('Nenhuma notícia encontrada.'));
            }

            // Dados carregados com sucesso
            final noticias = snapshot.data!;

            return ListView.builder(
              itemCount: noticias.length,
              itemBuilder: (context, index) {
                final noticia = noticias[index];
                return widgetStack(
                    noticia.titulo, noticia.imagem, noticia.site);
              },
            );
          },
        ),
      ),
    );
  }
}

widgetStack(String texto, String imagem, String site) {
  return Container(
    margin: EdgeInsets.only(top: 10, bottom: 10),
    child: InkWell(
      onTap: () => launch(site),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 350,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Image.network(
              imagem,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 200);
              },
            ),
          ),
          Container(
            width: 340,
            height: 30,
            margin: EdgeInsets.fromLTRB(0, 100, 10, 0),
            color: Color.fromARGB(255, 106, 219, 63),
          ),
          Container(
            width: 340,
            height: 30,
            margin: EdgeInsets.fromLTRB(0, 110, 10, 0),
            color: Color.fromARGB(255, 79, 118, 64),
            child: Text(
              ' "' + texto + '" ',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 250, 255), fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );
}

void _openNewsLink(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // Caso o link não possa ser aberto
    print('Não foi possível abrir o link: $url');
  }
}
