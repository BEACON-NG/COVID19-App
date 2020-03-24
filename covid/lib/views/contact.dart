import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  Contact({Key key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

void _launchCaller(String phoneNumber) async {
  // var url ="whatsapp://send?phone=$phoneNumber";
  var url = "tel:$phoneNumber";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _ContactState extends State<Contact> {
  var listModel = <NameModel>[
    NameModel(name: 'Emergency Number1', phone: '080000000'),
    NameModel(name: 'Emergency Number2', phone: '080000000'),
    NameModel(name: 'Emergency Number3', phone: '080000000'),
    NameModel(name: 'Whatapp help line', phone: '080000000'),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'NCDC Nigeria',
                  style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1)),
                ),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              child: Container(
                height: 350,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int i) {
                        return Card(
                            child: ListTile(
                          title: Text(listModel[i].name ?? '',
                              style: TextStyle(
                                  color: Color.fromRGBO(27, 92, 161, 1))),
                          subtitle: InkWell(
                            onTap: () => _launchCaller(listModel[i].phone),
                            child: Text(listModel[i].phone ?? ''),
                          ),
                        ));
                      },
                      itemCount: listModel.length),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(5),
                  ),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              'Whatapp help line',
                              style: TextStyle(
                                  color: Color.fromRGBO(27, 92, 161, 1)),
                            ),
                            leading: Icon(Icons.phone),
                          ),
                        ),
                      ),
                    ],
                  )),
            )
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

  const NameModel({this.name, this.phone, this.img});
}

//    Container(
//   width:MediaQuery.of(context).size.width,
//   height:MediaQuery.of(context).size.height,
//  child:
