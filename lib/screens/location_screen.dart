import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {

  final dynamic currentWeather;

  LocationScreen({this.currentWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  
  String weatherIcon;
  String cityName;
  String weatherMsg;
  int temperature;

  void initState(){
    super.initState();
    updateUI(widget.currentWeather);
  }

  void updateUI(dynamic weatherData){
    if(weatherData == null){
      weatherIcon = '';
      cityName ='';
      weatherMsg='Error';
      temperature = 0;
      return;
    }
    WeatherModel weatherModel = WeatherModel();
    weatherIcon = weatherModel.getWeatherIcon(weatherData['weather'][0]['id']);
    cityName = weatherData['name'];
    temperature =weatherData['main']['temp'].toInt();
    weatherMsg = weatherModel.getMessage(temperature)+' in '+cityName;
  }

  @override
  Widget build(BuildContext context) {
    
    
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: ()async{
                      WeatherModel weatherModel = WeatherModel();
                      var weatherData = await weatherModel.getLocationWeather();
                      this.setState((){
                        updateUI(weatherData);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedName = await Navigator.push(context,MaterialPageRoute(builder:(context){
                        return CityScreen();
                      }));
                      if(typedName!=null){
                        WeatherModel weatherModel= WeatherModel();
                        var data =await weatherModel.getCityWeather(typedName);
                        this.setState((){
                          updateUI(data);
                        });
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMsg,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
