import 'package:flutter/material.dart';

widgetField(bool obscure, double height, String name, dynamic controller,
    dynamic icon) {
  return SizedBox(
    width: 600,
    height: height,
    child: TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, preencha o campo ' + name;
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: name,
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 79, 118, 64),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 79, 118, 64),
            width: 2,
          ),
        ),
        suffixIcon: Icon(
          icon,
          color: Color.fromARGB(255, 106, 219, 63),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 79, 118, 64),
              width: 2,
            )),
      ),
    ),
  );
}

bool _obscureText = true;
widgetObscureChange(
    double height, String name, dynamic controller, dynamic setState) {
  return SizedBox(
    width: 600,
    height: 40,
    child: TextField(
      controller: controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Senha",
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 79, 118, 64),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 79, 118, 64),
            width: 2,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Color.fromARGB(255, 106, 219, 63),
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 79, 118, 64),
              width: 2,
            )),
      ),
    ),
  );
}
