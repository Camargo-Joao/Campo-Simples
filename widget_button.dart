import 'package:flutter/material.dart';
import 'package:projeto_v1/home.dart';
import 'package:projeto_v1/widget_image.dart';

//botão para imagens widgetButton_image (Color color, String text, double width, double height, String imagePath, BuildContext context, Widget destination)
widgetButton_image(Color back, String nome, double width, double heigth,
    String imagem, BuildContext context, Widget rota) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: width,
        height: heigth,
        child: ElevatedButton(
            style: ButtonStyle(
                shadowColor: MaterialStatePropertyAll<Color>(Colors.green),
                backgroundColor: MaterialStatePropertyAll<Color>(back),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (contexft) => rota),
              );
            },
            child: widgetImage(imagem, 100)),
      )
    ],
  );
}

//botão de texto
widgetButton(Color back, Color text, String nome, double width, double heigth,
    Widget route, BuildContext context) {
  return SizedBox(
      width: width,
      height: heigth,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(back),
          foregroundColor: MaterialStatePropertyAll<Color>(text),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
          shadowColor: MaterialStatePropertyAll<Color>(Colors.black),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        child: Text(
          nome,
          textAlign: TextAlign.center,
        ),
      ));
}

widgetButtonCadastrar(Color back, Color text, String nome, double width,
    double heigth, Widget route, BuildContext context) {
  return SizedBox(
      width: width,
      height: heigth,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(back),
            foregroundColor: MaterialStatePropertyAll<Color>(text),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
            shadowColor:
                MaterialStatePropertyAll<Color>(Color.fromARGB(0, 0, 0, 0))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        child: Text(nome),
      ));
}

//https://stackoverflow.com/questions/64764169/flutter-what-is-the-difference-buttonstyle-and-stylefrom

//Botãio Home

buttonHome(BuildContext context) {
  return BottomAppBar(
    padding: EdgeInsets.all(0),
    height: 35,
    color: Color.fromARGB(255, 106, 219, 63),
    child: IconButton(
      padding: EdgeInsets.all(3),
      style: ButtonStyle(alignment: Alignment.topCenter),
      icon: Icon(
        color: Color.fromARGB(255, 253, 244, 226),
        Icons.home_rounded,
        size: 30,
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PrimeraPagina()),
            (route) => false);
      },
    ),
  );
}

buttonStyle() {
  return ButtonStyle(
      backgroundColor:
          MaterialStatePropertyAll<Color>(Color.fromARGB(255, 106, 219, 63)),
      foregroundColor:
          MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 252, 180)),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))));
}
