import 'package:geolocator/geolocator.dart';

class Location{
  double latitude;
  double longitude;

  Future getCurrentLocation()async{
    try{
      print('a');
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('b');
      this.latitude = position.latitude;
      this.longitude = position.longitude;
    }catch(e){
      print(e);
    }
  }
}