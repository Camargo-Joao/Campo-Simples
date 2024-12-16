import 'package:flutter/material.dart';

widgetDropdown(dynamic _selectedValue, dynamic setState) {
  return Container(
    width: 600,
    height: 40,
    padding: EdgeInsets.only(left: 20, right: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 2,
          color: Color.fromARGB(255, 79, 118, 64),
        )),
    child: DropdownButton<String>(
      isExpanded: true,
      iconSize: 30,
      menuMaxHeight: 200,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Color.fromARGB(255, 106, 219, 63),
      ),
      style: TextStyle(color: Color.fromARGB(255, 79, 118, 64), fontSize: 16),
      underline: SizedBox(),
      dropdownColor: Color.fromARGB(255, 255, 252, 180),
      hint: Text(
        "Selecione um Estado",
        style: TextStyle(color: Color.fromARGB(255, 79, 118, 64)),
      ),
      value: _selectedValue,
      items: <String>[
        "Acre - AC",
        "Alagoas - AL",
        "Amapá - AP",
        "Amazonas - AM",
        "Bahia - BA",
        "Ceará - CE",
        "Distrito Federal - DF",
        "Espírito Santo - ES",
        "Goiás - GO",
        "Maranhão - MA",
        "Mato Grosso - MT",
        "Mato Grosso do Sul - MS",
        "Minas Gerais - MG",
        "Pará - PA",
        "Paraíba - PB",
        "Paraná - PR",
        "Pernambuco - PE",
        "Piauí - PI",
        "Rio de Janeiro - RJ",
        "Rio Grande do Norte - RN",
        "Rio Grande do Sul - RS",
        "Rondônia - RO",
        "Roraima - RR",
        "Santa Catarina - SC",
        "São Paulo - SP",
        "Sergipe - SE",
        "Tocantins - TO"
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
      },
    ),
  );
}
