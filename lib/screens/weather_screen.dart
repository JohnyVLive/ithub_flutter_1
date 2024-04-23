import 'package:flutter/material.dart';
import 'package:ithub_flutter_1/models/weather_model.dart';
import 'package:ithub_flutter_1/services/weather_api_client.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  final TextEditingController _cityInputController = TextEditingController();

  // api key
  final _weatherApiClient = WeatherApiClient('cc4d1a62e594f09c3020a8d6f541b367');
  WeatherModel? _weatherModel;

  // fetch weather
  _fetchWeather(String cityName) async{
    // current city
    // String cityName = 'Москва';

    // get weather for current city
    try{
      final weather = await _weatherApiClient.getWeather(cityName);     
      setState(() {
        _weatherModel = weather;
      });
    } catch (e) {
      print(e);
      setState(() {
        _weatherModel = null;
      });
    }
  }

  // init state
  @override
  void initState() {
    super.initState();
    // TODO: Может быть сделать автоопределение города по геолокации.. А пока - Москва
    _fetchWeather('Москва');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: 
                Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: true,
                      controller: _cityInputController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      
                        hintText: 'Введите город',
                        fillColor: Colors.white70,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    ElevatedButton(
                      onPressed: () async { 
                        // Call fetch weather func
                        await _fetchWeather(_cityInputController.text.trim());

                        _cityInputController.text = '';
                        }, 
                      child: const Text('Найти'),
                    ),
                  ],
                ),
              
            ),
            
            SizedBox(
              width: 300,
              child: Builder(
                builder: (context) {
                  if (_weatherModel != null){
                    return Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Text(_weatherModel!.cityName),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Text('${_weatherModel?.temperature.round()} C'),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Text(_weatherModel!.mainCodition),
                      ],
                    );
                  } else {
                      return const Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text("Данных по заданному городу нет."),
                        ],
                      );
                  }
                }
              )
            ),
          ],
        ),
      ),

    );
  }
}