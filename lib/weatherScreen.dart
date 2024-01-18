import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/apikey.dart';
import 'package:weather_app/hourlyWeather.dart';
import 'package:weather_app/additionalInfo.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// ignore: camel_case_types
class weatherScreen extends StatefulWidget{
  const weatherScreen({super.key});

  @override
  State<weatherScreen> createState() => _weatherScreenState();
}

// ignore: camel_case_types
class _weatherScreenState extends State<weatherScreen> {
  late Future<Map<String, dynamic>> weather;
  
 Future<Map<String, dynamic>> getCurrentWeather() async {
  
  try{
    String cityName = 'London';
    final res = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey',
        //https://api.openweathermap.org/data/2.5/forecast?q=London&APPID=8cfb7db323ba2918e4c2f64a46a86f7a'

      ),
    );

    final data = jsonDecode(res.body);
    if(data['cod'] != '200') {
      throw 'An Unexpected Error Has Occured';
} 
   return data;
  } catch(e) {
    throw(e).toString;
  }
  
 }

 @override
 void initState() {
  super.initState();
  weather = getCurrentWeather();
 } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Weather App', 
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                 weather = getCurrentWeather();
              }
              );
            },
            icon: const Icon(Icons.refresh)), 
            
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive());
          }

          if(snapshot.hasError) {
            return const Center(
              child: Text('Opps, An error has occured'),
            );
          }

          final data = snapshot.data!;
          final currentTemperature = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final currentHumidity = data['list'][0]['main']['humidity'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];
          final currentPressure = data['list'][0]['main']['pressure'];
          return Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                      elevation: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ),
                          child:Padding(
                            padding:const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  '$currentTemperature K',
                                style:const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                                const SizedBox(height: 16),
                                Icon(
                                  currentSky == 'Clouds' || currentSky == 'Rain'? Icons.cloud : Icons.cloud_circle_sharp,
                                  size: 64),
                                const SizedBox(height: 16),
                                Text(
                                  currentSky,
                                style:const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text('Hourly Weather Forecast',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  const SizedBox(height: 18),
                  //  SingleChildScrollView( 
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for(int i = 1; i < 6; i++) 
                  //         HourlyForcastItem(
                  //         time: data['list'][i]['dt_txt'].toString(),
                  //         icon: data['list'][i]['weather'][0]['main'] == 'Clouds' || data['list'][i]['weather'][0]['main'] == 'Sunny'? Icons.cloud : Icons.sunny,
                  //         temperature: data['list'][0]['main']['temp'].toString(),
                  //         )
                          
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 161,
                    child: ListView.builder(
                      itemCount: 38,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final time = DateTime.parse(data['list'][index+1]['dt_txt']);
                        final icon = data['list'][index+1]['weather'][0]['main'];
                        final temperature = data['list'][index+1]['main']['temp'];
                        return HourlyForcastItem(
                          time: DateFormat.j().format(time), 
                          icon: icon == 'Clouds' ||icon == 'Rain'? Icons.cloud : Icons.cloud_circle_sharp,
                          temperature: temperature.toString());

                      },)
                  ),
                  const SizedBox(height: 18),
                  const Text('Additionl Information',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: currentHumidity.toString(),
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: currentWindSpeed.toString(),
                      ),
                      AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: currentPressure.toString(),
                      ),
                      ],
                      ),
                ]
                ),
            ),
          );
        }
      ),
    );
  }
}



