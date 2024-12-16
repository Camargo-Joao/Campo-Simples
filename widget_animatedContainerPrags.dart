import 'package:flutter/material.dart';
import 'package:projeto_v1/profissionais.dart';
import 'package:projeto_v1/widget_image.dart';

class AnimatedContainerWidget extends StatefulWidget {
  final dynamic externalImagem;
  final dynamic externalNome;
  final dynamic externalCaract;
  final dynamic externalTrat;
  final dynamic externalEspec;

  const AnimatedContainerWidget({
    Key? key,
    required this.externalImagem,
    required this.externalNome,
    required this.externalCaract,
    required this.externalTrat,
    required this.externalEspec,
  }) : super(key: key);

  @override
  _AnimatedContainerWidgetState createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
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
        duration: Duration(seconds: 1),
        curve: Curves.easeInSine,
        padding: EdgeInsets.all(16.0),
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
                Image.network(
                  widget.externalImagem,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: 200);
                  },
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
            SizedBox(height: 8),
            Text(
              widget.externalNome,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 250, 226),
              ),
            ),
            AnimatedCrossFade(
              firstChild: Container(),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text('Características: ${widget.externalCaract}',
                      style: style),
                  SizedBox(height: 4),
                  Text('Tratamento: ${widget.externalTrat}', style: style),
                  SizedBox(height: 4),
                  Text('Especialista: ${widget.externalEspec}', style: style),
                  SizedBox(height: 8),
                  widgetButtonImageText(
                    Color.fromARGB(255, 106, 219, 63),
                    Color.fromARGB(255, 255, 250, 226),
                    widget.externalEspec,
                    500,
                    40,
                    Profissionais(profissionalId: widget.externalEspec),
                    context,
                  ),
                ],
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

TextStyle style = TextStyle(
  color: Color.fromARGB(255, 253, 244, 226),
);

Widget widgetButtonImageText(Color back, Color text, String nome, double width,
    double height, Widget route, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(back),
            foregroundColor: MaterialStateProperty.all<Color>(text),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => route),
            );
          },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: 30,
                height: 30,
                child: widgetImage("imagens/perfil.png", 100),
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                nome,
                style: TextStyle(),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
