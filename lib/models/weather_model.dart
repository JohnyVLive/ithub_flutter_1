class WeatherModel{
  final String cityName;
  final double temperature;
  final String mainCodition;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCodition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
      cityName: json['name'], 
      temperature: json['main']['temp'].toDouble(), 
      mainCodition: json['weather'][0]['main'],
      );
  }
}