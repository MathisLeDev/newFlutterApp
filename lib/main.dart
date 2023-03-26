<<<<<<< HEAD
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:la_derniere_fois/current_weather_models.dart';
import 'package:la_derniere_fois/daily_weather_models.dart';
import 'package:la_derniere_fois/suggestion_models.dart';
import 'package:la_derniere_fois/weekly_weather_models.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
=======
import 'package:flutter/material.dart';
import 'package:starter/second_page.dart';

import 'home_page.dart';
>>>>>>> origin/master

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Weather App'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {
  List<String> suggestionsList = [];
  String cityName = "";
  List<SuggestionModel> listOfAllSuggestions = [];
  List<WeeklyWeatherModel> listOfWeeklyWeather = [];
  List<DailyWeatherModel> listOfDailyWeather = [];
  List<CurrentWeatherModel> currentWeatherModel = [];
  

/**
 * Est appelée à chaque fois l'input texte change de valeur
 * Appel API pour GET les suggestions sur le nom des villes
 * 
 */
  Future getSuggestions(city) async {
    suggestionsList.clear();
    if (city.length > 2) { //Le get est efficace a partir d'une chaine de plus de 2 caractères.
      http.Response response;
      try {
        response = await http.get(Uri.parse(
          "https://geocoding-api.open-meteo.com/v1/search?name=$city"));//appel et réception du GET stocké dans la var response.
        if (response.statusCode == 200 && jsonDecode(response.body).containsKey('results')) {//définie la liste noms des suggestions renvoyées. vérification code 200 pour éviter un arrêt de l'appli.
          final results = <String>[];
          List<SuggestionModel> listOfAllSuggestionsTemps = [];

          for (final suggestion in jsonDecode(response.body)['results'] as List<dynamic>) {
            final name = suggestion['name'] as String;//suggestion['name'] contiendra tous les noms de ville en suggestions. Même fonctionnement pour le timezone
            final timezone = suggestion['timezone'] as String;
            results.add('$name:$timezone');
            listOfAllSuggestionsTemps.add(SuggestionModel.fromJson(suggestion));
          }
          setState(() {
            listOfAllSuggestions = listOfAllSuggestionsTemps; //Intègre les suggestions dans les variables global pour qu'elles puissent êtres utilisé dans l'appli pour afficher les suggestions par exemple.
            suggestionsList = results;
          });
        } else {
          setState(() {
            suggestionsList = [];
          });
        }
      }
      catch(e) {
        print(e);
      }
      
    } else {
      setState(() {
        suggestionsList = [];
      });
    }
  }


  Future _setWeeklyAndDailyWeather() async {
    if(listOfAllSuggestions.length != 0) {
      final city = cityName.substring(0, cityName.indexOf(":")); //prend la valeur Marseille de Marseille:Europe/Paris par exemple
      final timestamp = cityName.substring(cityName.indexOf(":")+1);//prend la valeur Europe/Paris de Marseille:Europe/Paris par exemple
      SuggestionModel suggestionModel = listOfAllSuggestions.firstWhere((element) => element.name == city && element.timezone == timestamp);//Chercher dans la liste des suggestions la suggestions qui contient Marseille en nom de ville et Europe/Paris en timezone.
      final latitude = suggestionModel.latitude;
      final longitude = suggestionModel.longitude;
      final timezone = suggestionModel.timezone;
      http.Response response;
      List<WeeklyWeatherModel> listOfWeeklyWeatherTemp = [];
      List<DailyWeatherModel> listOfDailyWeatherTemp = [];
      final url = 'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&daily=weathercode,temperature_2m_max,temperature_2m_min,weathercode&current_weather=true&current_weather=true&hourly=temperature_2m,weathercode&timezone=$timezone';
      response = await http.get(Uri.parse(
          url ));//Récupération de la météo sur la semaine, heures/heures et sur l'instantannée.

      if (response.statusCode == 200) {
        currentWeatherModel.clear();
        //instantiation des model pour la météo instantannée, celle de la journée et de la semaine pour pouvoir les afficher par la suite.
        //météo instantannée
        final Map<String, dynamic> currentWeatherData = jsonDecode(response.body)['current_weather'];
        CurrentWeatherModel currentWeatherModelTemp = CurrentWeatherModel.fromJson(currentWeatherData);
        

        //météo de la journée
        final Map<String, dynamic> dailyData = jsonDecode(response.body)['hourly'];
        final currentDate = DateTime.now();
        for(int i = 0; i < dailyData['time'].length && i < 48  ; i++) {
          final dailyDataDate = DateTime.parse(dailyData['time'][i]); 
          if(dailyDataDate.isAfter(currentDate)) {
            listOfDailyWeatherTemp.add(DailyWeatherModel.fromJson(dailyData, i));
          }
        }
        
        //météo de la semaine
        final Map<String, dynamic> weeklyData = jsonDecode(response.body)['daily'];
        for(int i = 0; i < weeklyData['time'].length; i++) {
          listOfWeeklyWeatherTemp.add(WeeklyWeatherModel.fromJson(weeklyData, i));
        }

        //initisalisation des variables en global pour les afficher ensuite.
        setState(() {
        currentWeatherModel.add(currentWeatherModelTemp);
        listOfWeeklyWeather = listOfWeeklyWeatherTemp;
        listOfDailyWeather = listOfDailyWeatherTemp;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: <Widget>[



          Autocomplete<String>(
            optionsBuilder: (textEditingValue) async {
              await getSuggestions(textEditingValue.text);
              return suggestionsList;
            },
            onSelected: (value) {
              setState(() {
                cityName = value;
             });
            },
        ),

          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 5),
                    blurRadius: 5,
                  )
                ],
                color: const Color(0XFFfefffe)),
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child:  Expanded(
                              child: Text(
                                currentWeatherModel.isNotEmpty ? "${currentWeatherModel[0].temperature}°C" : "--",
                                style: const TextStyle(fontSize: 56),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              cityName.isNotEmpty ? cityName : "--",
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                     child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(currentWeatherModel[0].weatherCode) : const Text("--")
                  ),
                ],
              ),
            ),

          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(0, 5),
                      blurRadius: 5,
                    )
                  ],
                  color: const Color(0XFFfefffe)),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                         Expanded(
                            child: Text(
                          listOfDailyWeather.isNotEmpty 
    ? listOfDailyWeather[0].temperature.toString()
    : '--',
                          style: const TextStyle(fontSize: 18),
                        )),
                        Expanded( child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(listOfWeeklyWeather[0].weatherCode) : Text("--")),
                         Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfDailyWeather[0].date.toString()
    : '--',
                          style: TextStyle(fontSize: 18),
                        )),
                        Expanded(
                            child: Text(listOfDailyWeather.isNotEmpty ?
                          getPeriodOfTheDay(listOfDailyWeather[0].date) : "--",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                         Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfDailyWeather[1].temperature.toString()
    : '--',
                          style: const TextStyle(fontSize: 18),
                        )),
                        Expanded( child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(listOfWeeklyWeather[1].weatherCode) : Text("--")),
                         Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfDailyWeather[1].date.toString()
    : '--',
                          style: TextStyle(fontSize: 18),
                        )),
                         Expanded(
                            child: Text(
                          listOfDailyWeather.isNotEmpty ?
                          getPeriodOfTheDay(listOfDailyWeather[1].date) : "--",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfDailyWeather[2].temperature.toString()
    : '--',
                          style: const TextStyle(fontSize: 18),
                        )),
                        Expanded( child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(listOfWeeklyWeather[2].weatherCode) : Text("--")),
                         Expanded(
                            child: Text(
                         listOfWeeklyWeather.isNotEmpty 
    ? listOfDailyWeather[2].date.toString()
    : '--',
                          style: TextStyle(fontSize: 18),
                        )),
                         Expanded(
                            child: Text(
                          listOfDailyWeather.isNotEmpty ?
                          getPeriodOfTheDay(listOfDailyWeather[2].date) : "--",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfDailyWeather[3].temperature.toString()
    : '--',
                          style: const TextStyle(fontSize: 18),
                        )),
                        Expanded( child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(listOfWeeklyWeather[3].weatherCode) : Text("--")),
                         Expanded(
                            child: Text(
                         listOfWeeklyWeather.isNotEmpty 
    ? listOfDailyWeather[3].date.toString()
    : '--',
                          style: TextStyle(fontSize: 18),
                        )),
                         Expanded(
                            child: Text(
                          listOfDailyWeather.isNotEmpty ?
                          getPeriodOfTheDay(listOfDailyWeather[3].date) : "--",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfDailyWeather[4].temperature.toString()
    : '--',
                          style: const TextStyle(fontSize: 18),
                        )),
                        Expanded( child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(listOfWeeklyWeather[4].weatherCode) : Text("--")),
                        Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfDailyWeather[4].date.toString()
    : '--',
                          style: TextStyle(fontSize: 18),
                        )),
                         Expanded(
                            child: Text(
                          listOfDailyWeather.isNotEmpty ?
                          getPeriodOfTheDay(listOfDailyWeather[0].date) : "--",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    )),
                  ],
                ),
              )),
          Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 5),
                      blurRadius: 5,
                    )
                  ],
                  color: const Color(0XFFfefffe)),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                         Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfWeeklyWeather[0].temperature
    : '--',
                          style: const TextStyle(fontSize: 18),
                        )),
                        Expanded( child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(listOfDailyWeather[0].weatherCode) : Text("--")),
                         Expanded(
                            child: Text(listOfWeeklyWeather.isNotEmpty ?
                          getDayNameOfTheWeek(listOfWeeklyWeather[0].date.toString()) : "--",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfWeeklyWeather[1].temperature
    : '--',
                          style: const TextStyle(fontSize: 18),
                        )),
                        Expanded( child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(listOfDailyWeather[1].weatherCode) : Text("--")),
                        Expanded(
                            child: Text(listOfWeeklyWeather.isNotEmpty ?
                          getDayNameOfTheWeek(listOfWeeklyWeather[1].date.toString()) : "--",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfWeeklyWeather[2].temperature
    : '--',
                          style: const TextStyle(fontSize: 18),
                        )),
                        Expanded( child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(listOfDailyWeather[2].weatherCode) : Text("--")),
                        Expanded(
                            child: Text(listOfWeeklyWeather.isNotEmpty ?
                          getDayNameOfTheWeek(listOfWeeklyWeather[2].date.toString()) : "--",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfWeeklyWeather[3].temperature
    : '--',
                          style: const TextStyle(fontSize: 18),
                        )),
                        Expanded( child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(listOfDailyWeather[3].weatherCode) : Text("--")),
                        Expanded(
                            child: Text(listOfWeeklyWeather.isNotEmpty ?
                          getDayNameOfTheWeek(listOfWeeklyWeather[3].date.toString()) : "--",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                            child: Text(
                          listOfWeeklyWeather.isNotEmpty 
    ? listOfWeeklyWeather[4].temperature
    : '--',
                          style: const TextStyle(fontSize: 18),
                        )),
                        Expanded( child: listOfWeeklyWeather.isNotEmpty ? getSvgFromWeatherCode(listOfDailyWeather[4].weatherCode) : Text("--")),
                        Expanded(
                            child: Text(listOfWeeklyWeather.isNotEmpty ?
                          getDayNameOfTheWeek(listOfWeeklyWeather[4].date.toString()) : "--",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    )),
                  ],
                ),
              )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _setWeeklyAndDailyWeather,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  

  /**
   * params: String en paramètre correspondant a la date demandée  ex:"2023-03-26T00:00"
   * return: AM ou PM selon l'heure présent dans la date.
   */
  getPeriodOfTheDay(String date) {
    final hour = date.substring(0, date.indexOf(":"));
    if(int.parse(hour) >= 12) {
      return "PM";
    }
    return "AM";
  }
  

  /**
   * params: String en paramètre correspondant a la date demandée  ex:"2023-03-26T00:00" pour avoir la journée correspondante
   * return: Lun, Mar, Mer, Jeu, Ven, Sam, Dim selon le jour de la date en paramètre.
   */
  getDayNameOfTheWeek(String givenDate) {
  DateTime date = DateTime.parse(givenDate);
  String dayOfWeek = DateFormat('EEEE').format(date); // 'EEEE' retourne le nom complet du jour de la semaine
  switch (dayOfWeek) {
    case "Monday":
      return "Lun";
    case "Tuesday":
      return "Mar";
    case "Wednesday":
      return "Mer";
    case "Thursday":
      return "Jeu";
    case "Friday":
      return "Ven";
    case "Saturday":
      return "Sam";
    case "Sunday":
      return "Dim";
    default:
    return "--";
    }
  }
}


/**
 * params: Int weatherCode correspond au temps renvoyé par l'API utilisé ex:0
 * return: l'image correspondant au weathercode ex: 0 = wi-day-fog.svg
 * utilisé pour la choix des images pour l'affichage.
 */
getSvgFromWeatherCode(int weatherCode) {
  String icon;
  switch (weatherCode) {
      case 0:
        icon = "assets/wi-day-fog.svg";
        break;
      case 1:
        icon = "assets/wi-day-fog.svg";
        break;
      case 2:
        icon = "assets/wi-day-fog.svg";
        break;
      case 3:
        icon = "assets/wi-day-fog.svg";
        break;
      case 45:
        icon = "assets/wi-day-fog.svg";
        break;
      case 48:
        icon = "assets/wi-day-fog.svg";
        break;
      case 51:
        icon = "assets/wi-day-rain.svg";
        break;
      case 53:
        icon = "assets/wi-day-rain.svg";
        break;
      case 55:
        icon = "assets/wi-day-rain.svg";
        break;
      case 56:
        icon = "assets/wi-day-rain.svg";
        break;
      case 57:
        icon = "assets/wi-day-rain.svg";
        break;
      case 61:
        icon = "assets/wi-day-rain.svg";
        break;
      case 63:
        icon = "assets/wi-day-rain.svg";
        break;
      case 65:
        icon = "assets/wi-day-rain.svg";
        break;
      case 66:
        icon = "assets/wi-day-fog.svg";
        break;
      case 67:
        icon = "assets/wi-day-fog.svg";
        break;
      case 71:
        icon = "assets/wi-snow.svg";
        break;
      case 73:
        icon = "assets/wi-snow.svg";
        break;
      case 75:
        icon = "assets/wi-snow.svg";
        break;
      case 77:
        icon = "assets/wi-day-fog.svg";
        break;
      case 80:
        icon = "assets/wi-lightning.svg";
        break;
      case 81:
        icon = "assets/wi-lightning.svg";
        break;
      case 82:
        icon = "assets/wi-lightning.svg";
        break;
      case 85:
        icon = "assets/wi-snow.svg";
        break;
      case 86:
        icon = "assets/wi-snow.svg";
        break;
      case 95:
        icon = "assets/wi-lightning.svg";
        break;
      case 96:
        icon = "assets/wi-day-fog.svg";
        break;
      case 99:
        icon = "assets/wi-day-fog.svg";
        break;
      default:
        icon = "assets/wi-day-sunny.svg";
        break;
    }
    return SvgPicture.asset(
    icon,
    height: 200, // taille de l'image
    width: 200,
  );
}
=======
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: const Color(0XFFc1cfea),
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/home": (context) => const MyHomePage(title: "MyHomePage"),
        "/detail": (context) => const SecondHomePage(title: "SecondHomePage"),
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
>>>>>>> origin/master
