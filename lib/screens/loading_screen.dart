import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  

  void getWeather()async{
      WeatherModel weatherModel = WeatherModel();
      var decodedData = await weatherModel.getLocationWeather();
      
      
      Navigator.push(context,MaterialPageRoute(builder: (context){
        return LocationScreen(currentWeather: decodedData,);
      }));
    }
    
  
  void initState() {
    super.initState();
    getWeather();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size:100
          ),
        )
    );
  }
}
