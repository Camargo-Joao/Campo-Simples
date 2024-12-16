import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_v1/widget_image.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedProfWidget extends StatefulWidget {
  final dynamic externalNome;
  final dynamic externalArea;
  final dynamic externalEspec;
  final dynamic externalNumber;
  final bool isInitiallyExpanded; // Novo campo para definir o estado inicial

  const AnimatedProfWidget({
    Key? key,
    required this.externalNome,
    required this.externalArea,
    required this.externalEspec,
    required this.externalNumber,
    this.isInitiallyExpanded = false, // Valor padrão: fechado
  }) : super(key: key);

  @override
  State<AnimatedProfWidget> createState() => _AnimatedProfWidgetState();
}

class _AnimatedProfWidgetState extends State<AnimatedProfWidget> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitiallyExpanded; // Definir o estado inicial
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        duration: Duration(seconds: 1),
        curve: Curves.easeInSine,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: _isExpanded
              ? Color.fromARGB(255, 79, 118, 64) // ao clicar
              : Color.fromARGB(255, 106, 219, 63), // sem clicar
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    widgetImage("imagens/perfil.png", 40),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 5),
                        Text(
                          widget.externalNome,
                          style: texto,
                        ),
                        SizedBox(width: 2),
                        Text(widget.externalArea, style: style)
                      ],
                    )
                  ],
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
            AnimatedCrossFade(
              firstChild: Container(),
              secondChild: Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 10),
                    Text('Especialidade: ${widget.externalEspec}',
                        style: style),
                    SizedBox(height: 4),
                    InkWell(
                      child: Text(
                        'Contato: ${widget.externalNumber}',
                        style: style,
                      ),
                      onTap: () =>
                          launch('https://wa.me/55' + widget.externalNumber),
                    )
                  ],
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 600),
            ),
          ],
        ),
      ),
    );
  }
}

//estilo do título
TextStyle style = TextStyle(
  fontSize: 16,
  color: Color.fromARGB(255, 253, 244, 226),
);

//estílo das informações
TextStyle texto = TextStyle(
  fontSize: 18,
  color: Color.fromARGB(255, 253, 244, 226),
);
