import 'package:covid/provider/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';
import '../main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCountry extends StatefulWidget {
  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  _setLaunch({CountryCode codes}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_launch', false);
    prefs.setString("country_name", codes.name);
    prefs.setString("country_code", codes.code);
  }
  CountryCode codes;
//  _savaCountry(name, code) async {
//    final storage = FlutterSecureStorage();
//    await storage.write(key: 'country_name', value: name);
//    await storage.write(key: 'country_code', value: code);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                color: Color(0xff002657),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(24.0),
                    bottomLeft: Radius.circular(24.0)),
                image: DecorationImage(
                  image: AssetImage('assets/images/covid.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 30.0,
              right: 30,
              child: Container(
                child: Image.asset(
                  'assets/images/beacon.png',
                  height: 110,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: 30,
              right: 30,
              child: Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Text(
                          'Select your country',
                          style: TextStyle(
                              fontSize: 16.0, color: Color(0xff002657)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 24.0),
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Color(0xff002759).withOpacity(0.18),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: CountryListPick(
                          onChanged: (CountryCode code) async {
//                            final snackbar = new SnackBar(
//                                content:
//                                    Text('Country selected successfully !'),
//                                duration: Duration(seconds: 1));
//                            _savaCountry(code.name, code.code).then((value) =>
//                                Scaffold.of(context).showSnackBar(
//                                  new SnackBar(content:
//                                    Text('Country selected successfully !'),
//                                duration: Duration(seconds: 1)))
//                                );
                          setState(() {
                            codes=code;
                          });
                          Scaffold.of(context).showSnackBar(
                                  new SnackBar(content:
                                    Text('Country selected successfully !'),
                                duration: Duration(seconds: 1)));
                          },
                          isShowFlag: true,
                          isShowTitle: true,
                          isDownIcon: true,
                          initialSelection: '+234',
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                         await _setLaunch(codes: codes).then((_) => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage())));
                        },
                        child: Container(
                          height: 40.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xff002758),
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.symmetric(
                              horizontal: 70, vertical: 30.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Proceed',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
