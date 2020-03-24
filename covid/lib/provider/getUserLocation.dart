import 'package:covid/provider/checkNetwork.dart';
import 'package:covid/provider/secureStorage.dart';
import 'package:geolocator/geolocator.dart';


Future<String> getUserLocation() async{
  String userCountry;
  bool net = await checkNetwork();
  if(net == true){
    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    await storage.write(key: "country", value: placemark.first.country);
    userCountry = placemark.first.country;
  }else{
    String data = await storage.read(key: "country");
    userCountry = data;
  }

  return userCountry;
}