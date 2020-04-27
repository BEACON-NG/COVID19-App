import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';



class Abouts extends StatefulWidget {
  Abouts({Key key}) : super(key: key);

  @override
  _AboutsState createState() => _AboutsState();
}

class _AboutsState extends State<Abouts> {
  static const Color color = Color(0xff002657);
  static const TextStyle style =
  TextStyle(fontSize: 16.0, color: Color(0xff002657));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
            icon: Icon(Icons.arrow_back,
                size: 20,
                color: color),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
        centerTitle: true,
        title: Text("About", style: TextStyle(
          color: Color.fromRGBO(36, 37, 130, 1),fontSize: 40,
        ),),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/beacon.png',
                height: 50.0,
                width: 130,
                alignment: Alignment.center,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.6,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2 ),
                    child: Card(
                      child: ListTile(
                        leading:Container(child: Image.asset("assets/images/android.png", fit: BoxFit.scaleDown,), height: 40,width: 40,),
//                        Icon(MaterialIcons.android, size: 40, color: color),
                        title: Text('Beacon', style: style),
                        subtitle: Text("App Name"),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2 ),
                    child: Card(
                      child: ListTile(
                        leading: Container(child: Image.asset("assets/images/version.png", fit: BoxFit.scaleDown,), height: 30,width: 30,),
                        title: Text('V1.0.0', style: style),
                        subtitle: Text("App Version"),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2 ),
                    child: Card(
                      child: ListTile(
                        leading: Container(child: Image.asset("assets/images/data.png", fit: BoxFit.scaleDown,), height: 40,width: 40,),
                        title: Text('JHU CSSE,WHO,CDC', style: style),
                        subtitle: Text("Data Source"),
                      ),
                    ),
                  ),Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      child: ListTile(
                        title: Text('Contact Us', style: style),
                      ),
                    ),
                  ),Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                    height: MediaQuery.of(context).size.height*0.33,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Card(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0),),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(width: 1, style: BorderStyle.solid, color: color)),
                            child: GestureDetector(
                              onTap: () async{
                                String url = "tel:09040494859";
                                await canLaunch(url)? await launch(url): throw 'Could not launch $url';
                              },
                              child: ListTile(
                                  title: Text('Phone Number', style: style),
                                  subtitle: Text("09040494859"),
                                trailing: Icon(Icons.call_end, color: color,),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(width: 1, style: BorderStyle.solid, color: color)),
                            child: GestureDetector(
                              onTap: () async{
                                String  url ="mailto:beacon.covid@gmail.com?subject=Beacon&body=Message%20Here";
                                await canLaunch(url)? await launch(url): throw 'Could not launch $url';
                              },
                              child: ListTile(
                                trailing: Icon(Icons.email, color: Colors.red,),
                                title: Text('Beacon.covid@gmail.com', style: style),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(width: 1, style: BorderStyle.solid, color: color)),
                            child:  GestureDetector(
                              onTap: () async{
                                String  url ="whatsapp://send?phone=2349040494859";
                                await canLaunch(url)? await launch(url): throw 'Could not launch $url';
                              },
                              child: ListTile(
                                trailing: Icon(Ionicons.logo_whatsapp, color: Color.fromRGBO(42, 128, 17, 1),),
                                title: Text('WhatsApp Line', style: style),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
//                  Container(
//                      margin: EdgeInsets.symmetric(horizontal: 10.0),
//                      child: Card(
//                         child: ListTile(
//                            title: Text('Our Team', style: style),
//                           leading: Icon(FontAwesome5.life_ring, size: 40, color: color,)
//                          ),
//                      ),
//                  ),
//                  Container(
//                    padding: EdgeInsets.symmetric(vertical: 5),
//                    margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.grey,
//                          blurRadius: 20.0, // has the effect of softening the shadow
//                          spreadRadius: 2.0, // has the effect of extending the shadow
//                          offset: Offset(
//                            5.0, // horizontal, move right 10
//                            5.0, // vertical, move down 10
//                          ),
//                        )
//                      ],
//                      borderRadius: new BorderRadius.all(Radius.circular(5)),
//                    ),
//                    child: Text(
//                      """
//                          gehhhi
//                      """
//                    ),
//                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}