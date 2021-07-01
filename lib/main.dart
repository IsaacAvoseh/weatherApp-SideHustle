import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simple_search_bar/simple_search_bar.dart';


  final AppBarController appBarController = AppBarController();

void main() => runApp(MaterialApp(
      title: 'Weather App',
      home: Home(),
    ));
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=lagos&units=imperial&appid=677b0f602f20d710754ced87f9e9bd49'));

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
      
      appBar: SearchAppBar(
        primary: Theme.of(context).primaryColor,
        appBarController: appBarController,
    
        autoSelected: true,
        searchHint: "Enter your city...",
        mainTextColor: Colors.white,
        onChange: (String value) {
          
        },
      
        mainAppBar: AppBar(
          title: Text("Weather Search"),
          actions: <Widget>[
            InkWell(
              child: Icon(Icons.search),
              onTap: () {
               
                appBarController.stream.add(true);
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Currently in Lagos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + '\u0000' : 'Loading',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null
                        ? currently.toString() + '\u0000'
                        : 'Loading',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text('Temperature'),
                    trailing: Text(
                        temp != null ? temp.toString() + '\u0000' : 'Loading'),

                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text('Weather'),
                    trailing: Text(description != null
                        ? description.toString() + '\u0000'
                        : 'Loading'),
                  ),

                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text('Humidity'),
                    trailing: Text(description != null
                        ? humidity.toString() + '\u0000'
                        : 'Loading'),
                  ),
                 
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text('Wind Speed'),
                    trailing: Text(windSpeed != null
                        ? windSpeed.toString() + '\u0000'
                        : 'Loading'),
                  ),
                ],
              ),
            ),
          ),
        ],

      ),
      backgroundColor: Colors.blue[50],
    );
  }
}
