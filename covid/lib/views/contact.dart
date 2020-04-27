import 'package:covid/views/morecontacts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  Contact({Key key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

void _launchCaller(NameModel contact) async {
  // var url ="whatsapp://send?phone=$phoneNumber";

  var url;
  if(contact.type == "SMS"){
    url = "sms:${contact.phone}?body=hi";
    await canLaunch(url)? await launch(url): throw 'Could not launch $url';
  }else if(contact.type == "Whatsapp Number"){
    url ="whatsapp://send?phone=${contact.phone}";
    await canLaunch(url)? await launch(url): throw 'Could not launch $url';
  }else{
    url = "tel:${contact.phone}";
    await canLaunch(url)? await launch(url): throw 'Could not launch $url';
  }
}

class _ContactState extends State<Contact> {

  static const Color color = Color(0xff002657);
  var listModel = <NameModel>[
    NameModel(name: 'Emergency Number1', phone: '080097000010', icon:Icons.call_end, color: color, type: "phoneNumber"),
    NameModel(name: 'Emergency Number2', phone: '07036708970', icon:Icons.call_end, color: color, type: "phoneNumber"),
    NameModel(name: 'Emergency Number3', phone: '08099555577', icon:Icons.call_end, color: color, type: "SMS"),
    NameModel(name: 'WhatsApp Help Line', phone: '2347087110839', icon:Ionicons.logo_whatsapp, color: Color.fromRGBO(42, 128, 17, 1),type: "Whatsapp Number"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
              child: Text(
            'Hotlines',
            style: TextStyle(color: Colors.indigo[900]),
          )),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: null,
            ),
          ]),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                "Do you think you might need help?",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w200,
                    color: Color.fromRGBO(36, 37, 130, 1)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation:20,
                  child: Padding(
                padding: const EdgeInsets.only(top:15, bottom: 15, left: 15),
                child: Text(
                  'NCDC Nigeria',
                  style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1)),
                ),
              )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation:20,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 350,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemBuilder: (BuildContext context, int i) {
                          return Card(
                              elevation:10,
                              child: GestureDetector(
                                onTap: (){
                                  _launchCaller(listModel[i]);
                                },
                                child: ListTile(
                            title: Text(listModel[i].name ?? '',
                                  style: TextStyle(
                                      color: Color.fromRGBO(27, 92, 161, 1))),
                            subtitle: Text(listModel[i].phone ?? ''),
                                  trailing: Icon(listModel[i].icon, color: listModel[i].color,),
                          ),
                              ));
                        },
                        itemCount: listModel.length),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
                height: 120.0,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Card(
                  elevation:20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                        child: Text(
                          'WHO',
                          style:
                              TextStyle(color: Color.fromRGBO(36, 37, 130, 1)),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        child: Card(
                          elevation:10,
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(width: 1, color: Color.fromARGB(1,207, 207,227)), borderRadius: BorderRadius.all(Radius.circular(5))),
                            child: GestureDetector(
                              onTap: (){
                                _launchCaller(NameModel(type: "Whatsapp Number", phone: "41798931892"));
                              },
                              child: ListTile(
                                title: Text(
                                  'Whatsapp help line',
                                  style: TextStyle(
                                      color: Color.fromRGBO(27, 92, 161, 1)),
                                ),
                                trailing: Icon(Ionicons.logo_whatsapp, color: Color.fromRGBO(42, 128, 17, 1),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 20,),
            Align(alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                  margin: EdgeInsets.symmetric(horizontal:25, vertical:15),
                  child: FlatButton(onPressed: (){
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Morecontacts()));
                  }, child: Text("View More", style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1)),))))
          ],
        ),
      ),
    );
  }
}

class NameModel {
  final String name;
  final String phone;
  final String img;
  final IconData icon;
  final Color color;
  final String type;

  const NameModel({this.name, this.type, this.phone, this.img, this.icon, this.color});
}

//    Container(
//   width:MediaQuery.of(context).size.width,
//   height:MediaQuery.of(context).size.height,
//  child:
