import 'package:geolocator/geolocator.dart';


Future<String> getUserLocation() async{
  GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
  String userCountry = placemark.first.country;
  return userCountry;
}