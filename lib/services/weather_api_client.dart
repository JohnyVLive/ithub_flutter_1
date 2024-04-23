
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ithub_flutter_1/models/weather_model.dart';



class WeatherApiClient {

  // static const BASE_URL_3 = 'https://api.openweathermap.org/data/3.0/';
  static const BASE_URL_2 = 'https://api.openweathermap.org/data/2.5/weather';
  // static const uriCoords = '/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}';
  final String apiKey;

  WeatherApiClient(this.apiKey);

  Future<WeatherModel> getWeather(String cityName) async {
    String urlByCity = '$BASE_URL_2?q=$cityName&appid=$apiKey&units=metric';
    Response response = await Dio().get(urlByCity);

    if (response.statusCode == 200) {
      final parseData = jsonDecode(response.toString());
      final weather = WeatherModel.fromJson(parseData);
      return weather;
    } 
      throw Exception('Ошибка загрузки информации о погоде.');
    }

}