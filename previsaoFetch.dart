import 'package:flutter/material.dart';
import 'package:projeto_v1/previsaoData.dart';

TextStyle style =
    TextStyle(color: Color.fromARGB(255, 255, 250, 226), fontSize: 18);

final WeatherService _weatherService = WeatherService();
Future<Map<String, dynamic>>? _weatherData;

previsaoFetch(String estado, Widget load) {
  if (estado.isEmpty) {
    return Center(
      child: Text('Estado não fornecido'),
    );
  }

  _weatherData = _weatherService.fetchWeather(estado);

  return Container(
    child: FutureBuilder<Map<String, dynamic>>(
      future: _weatherData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: load);
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          var data = snapshot.data!;

          // Extraindo as informações do JSON, usando verificações para evitar null
          var temperature = data['main']['temp'] ?? 'N/A';
          var humidity = data['main']['humidity'] ?? 'N/A';
          var windSpeed = data['wind']['speed'] ?? 'N/A';
          var rain = data.containsKey('rain')
              ? data['rain']['1h'] ?? 0
              : 0; // Chuva da última hora (se disponível)

          return Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 79, 118, 64),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 106, 219, 63),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Text(
                    "$estado",
                    style: style,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dadoIcone(Icons.sunny, "Temperatura:"),
                        SizedBox(height: 30),
                        dadoIcone(Icons.water_drop, "Humidade:"),
                        SizedBox(height: 30),
                        dadoIcone(Icons.cloudy_snowing, "Chuva:"),
                        SizedBox(height: 30),
                        dadoIcone(Icons.air, "Vento:"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "$temperature°C",
                          style: style,
                        ),
                        SizedBox(height: 30),
                        Text(
                          "$humidity%",
                          style: style,
                        ),
                        SizedBox(height: 30),
                        Text(
                          "$rain mm/h",
                          style: style,
                        ),
                        SizedBox(height: 30),
                        Text(
                          "$windSpeed m/s",
                          style: style,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text('Nenhum dado disponível'));
        }
      },
    ),
  );
}

dadoIcone(dynamic icone, String dado) {
  return Row(
    children: [
      Icon(
        icone,
        color: Color.fromARGB(255, 255, 250, 226),
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        dado,
        style: style,
      ),
    ],
  );
}
