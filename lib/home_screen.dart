import 'dart:convert';
import 'package:climateee/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'constants.dart' as k;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;
  num temp = 0;
  num pressure = 0;
  num humidity = 0;
  num windSpeed = 0;
  num minTemp = 0;
  num maxTemp = 0;
  String CityName = '';
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF0F2027),
            Color(0xFF203A43),
            Color(0xFF2C5364),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
        child: Visibility(
          visible: isLoaded,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.16,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      setState(() {
                        CityName = value;
                        getCityWether(CityName);
                        setState(() {
                          isLoaded = false;
                          cityController.clear();
                        });
                      });
                    },
                    controller: cityController,
                    cursorColor: Colors.white,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Search City',
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w400),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey[400],
                    size: 35,
                  ),
                  SizedBox(width: 05),
                  Text(
                    CityName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.yellow[50]),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  SizedBox(width: 10),
                  Text(
                    '${temp.toInt()} ',
                    style: TextStyle(
                        fontSize: 180,
                        fontWeight: FontWeight.w300,
                        color: Colors.yellow[50]),
                  ),
                  Text(
                    '℃',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[400]),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.MMMEd().format(DateTime.now()),
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400]),
                  ),
                ],
              ),
              SizedBox(height: 55),
              Row(
                children: [
                  Text("Pressure    : ",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400])),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${pressure.toInt()} hpa',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.yellow[50]),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Humidity    : ",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400])),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${humidity.toInt()}%',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.yellow[50]),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("ESE Wind   : ",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400])),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${windSpeed.toInt()} km/hr',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.yellow[50]),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Min Temp  : ",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400])),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${minTemp.toInt()}℃',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.yellow[50]),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Max Temp : ",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400])),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${maxTemp.toInt()}℃',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.yellow[50]),
                  )
                ],
              ),
            ],
          ),
          replacement: Center(
              child: CircularProgressIndicator(
            color: Color(0xFF2C5364),
          )),
        ),
      ),
    ));
  }

  getCurrentLocation() async {
    var p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );
    if (p != null) {
      getCurrentCityWhether(p);
    } else {
      print('Data unavailable');
    }
  }

  getCurrentCityWhether(Position position) async {
    var client = http.Client();
    var uri =
        "${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}";
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      updateUI(decodedData);
      setState(() {
        isLoaded = true;
      });
    } else {
      print(response.statusCode);
    }
  }

  getCityWether(String cityName) async {
    var client = http.Client();
    var uri = "${k.domain}q=$cityName&appid=${k.apiKey}";
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      updateUI(decodedData);
      setState(() {
        isLoaded = true;
      });
    } else if (response.statusCode == 404) {
      setState(() {
        isLoaded=true;
      });
      Navigator.push(context, MaterialPageRoute(builder: ((context) {
        return ErrorScreen();
      })));
    } else {
      print(response.statusCode);
    }
  }

  updateUI(var data) {
    setState(() {
      if (data == null) {
        temp = 0;
        pressure = 0;
        humidity = 0;
        windSpeed = 0;
        minTemp = 0;
        maxTemp = 0;

        CityName = 'Not Available';
      } else {
        temp = data['main']['temp'] - 273;
        pressure = data['main']['pressure'] - 273;
        humidity = data['main']['humidity'];
        windSpeed = data['wind']['speed'];
        minTemp = data['main']['temp_min'] - 273;
        maxTemp = data['main']['temp_max'] - 273;
        CityName = data['name'];
      }
    });
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }
}
