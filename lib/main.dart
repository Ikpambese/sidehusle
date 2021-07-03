import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0XFF0A0E21),
          scaffoldBackgroundColor: Color(0XFF0A0E21),
        ),
        title: 'WEATHER NOW',
        home: WeatherApp(),
      ),
    );

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  // First create the variables
  //    link
  //key

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  String place = 'Abuja';

  Future getWeather() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$place&appid=7c62ccab44d975c0a856acd99c53e528'),
    );
    var results = jsonDecode(response.body);

    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.pinkAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Currently in Abuja',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + '\u00B0' + 'C' : 'loading',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    currently != null ? currently : 'loading',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Container(
            width: double.infinity,
            height: 44,
            margin: EdgeInsets.only(right: 20, left: 20),
            padding: EdgeInsets.only(left: 20, right: 10),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(color: Colors.amber, width: 2),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.pink),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    initialValue: 'Nigeria',
                    decoration: InputDecoration(
                      hintText: 'Enter Place',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: RawMaterialButton(
              child: FaIcon(
                FontAwesomeIcons.search,
                color: Colors.pink,
              ),
              onPressed: () {
                getWeather();
              },
              elevation: 0.0,
              constraints: BoxConstraints.tightFor(
                width: 56.0,
                height: 56.0,
              ),
              shape: CircleBorder(),
              fillColor: Color(0xFF4C4F5E),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.thermometer,
                      color: Colors.pinkAccent,
                      size: 50,
                    ),
                    title: Text(
                      'Temperature',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    trailing: Text(
                      temp != null ? temp.toString() + '\u00B0' : 'loading',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.cloud,
                      color: Colors.pinkAccent,
                      size: 50,
                    ),
                    title: Text(
                      'Weather',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    trailing: Text(
                      description != null ? description.toString() : 'loading',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.sun,
                      color: Colors.pinkAccent,
                      size: 50,
                    ),
                    title: Text('Humidity',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    trailing: Text(
                      humidity != null ? humidity.toString() : 'loading',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.wind,
                      color: Colors.pinkAccent,
                      size: 50,
                    ),
                    title: Text('Wind Speed',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    trailing: Text(
                      windSpeed != null ? windSpeed.toString() : 'loading',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
