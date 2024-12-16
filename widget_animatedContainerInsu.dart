import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedInsuWidget extends StatefulWidget {
  final dynamic externalNome;
  final dynamic externalCaract1;
  final dynamic externalCaract2;
  final dynamic externalCaract3;
  final dynamic externalSelect;

  const AnimatedInsuWidget({
    Key? key,
    required this.externalNome,
    required this.externalCaract1,
    required this.externalCaract2,
    required this.externalCaract3,
    required this.externalSelect,
  }) : super(key: key);

  @override
  State<AnimatedInsuWidget> createState() => _AnimatedInsuWidgetState();
}

class _AnimatedInsuWidgetState extends State<AnimatedInsuWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
          margin: EdgeInsets.all(5),
          width: double.infinity, // Ajuste para responsividade
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutSine,
          decoration: BoxDecoration(
            color: _isExpanded
                ? Color.fromARGB(255, 79, 118, 64) //ao clicar
                : Color.fromARGB(255, 106, 219, 63), //sem clicar
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      child: Text(
                        widget.externalNome,
                        style: titulo,
                      ),
                      width: double.infinity,
                      height: 25,
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: AnimatedRotation(
                          duration: Duration(milliseconds: 300),
                          turns: _isExpanded ? 0.5 : 0.0,
                          child: Icon(
                            Icons.expand_more,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text("Função: " + widget.externalCaract1, style: texto),
                AnimatedCrossFade(
                  firstChild: Container(),
                  secondChild: Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text("Modo de uso: " + widget.externalCaract2,
                            style: texto),
                        SizedBox(height: 20),
                        Text("Preço: R\$" + widget.externalCaract3,
                            style: texto),
                        SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                              width: 170,
                              child: Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 106, 219, 63),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Ir para a loja",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 255, 252, 180),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.store,
                                        color:
                                            Color.fromARGB(255, 255, 252, 180),
                                      ),
                                    ],
                                  ),
                                  onTap: () => launch(widget.externalSelect),
                                ),
                              )),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 600),
                )
              ],
            ),
          )),
    );
  }
}

//estilo do título
TextStyle titulo =
    TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 255, 255));

//estílo das informações
TextStyle texto = TextStyle(
  fontSize: 18,
  color: Color.fromARGB(255, 253, 244, 226),
);

void _openNewsLink(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // Caso o link não possa ser aberto
    print('Não foi possível abrir o link: $url');
  }
}
