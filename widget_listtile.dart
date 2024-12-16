import 'package:flutter/material.dart';

widgetlisttile(String texto, Widget rota, BuildContext context) {
  return ListTile(
    iconColor: Color.fromARGB(255, 253, 244, 226),
    textColor: Color.fromARGB(255, 253, 244, 226),
    hoverColor: Color.fromARGB(255, 106, 219, 63),
    leading: Icon(Icons.arrow_right),
    title: Text(
      texto,
      style: TextStyle(fontSize: 20),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => rota),
      );
    },
  );
}
