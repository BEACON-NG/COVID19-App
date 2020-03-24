import 'package:flutter/material.dart';

class Volunteer extends StatefulWidget {
  Volunteer({Key key}) : super(key: key);

  @override
  _VolunteerState createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  createAlertDialog(BuildContextontext) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Text('Sorry this is not available'),
              actions: <Widget>[
                MaterialButton(
                    child: Text('close'),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
            child: Text(
          'Volunteers',
          style: TextStyle(color: Color.fromRGBO(0, 38, 87, 1)),
        )),
      ),
      body: ListView(children: <Widget>[
        Container(
            child: Column(
          children: <Widget>[
            Text(
              'Join us as we fight against the spread of CONVID\'19',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Color.fromRGBO(36, 37, 130, 1),
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(38, 153, 251, 1),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius:
                                  10.0, // has the effect of softening the shadow
                              spreadRadius:
                                  3.0, // has the effect of extending the shadow
                              offset: Offset(
                                2.0, // horizontal, move right 10
                                4.0, // vertical, move down 10
                              ),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.group, color: Colors.white),
                              Text(
                                'Volunteer',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius:
                                  10.0, // has the effect of softening the shadow
                              spreadRadius:
                                  3.0, // has the effect of extending the shadow
                              offset: Offset(
                                2.0, // horizontal, move right 10
                                4.0, // vertical, move down 10
                              ),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.payment,
                                  color: Color.fromRGBO(36, 37, 130, 1)),
                              Text(
                                'Donate',
                                style: TextStyle(
                                    color: Color.fromRGBO(36, 37, 130, 1)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Name',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "John Doe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(36, 37, 130, 1),
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Email',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "JohnDoe@gmail.com",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(36, 37, 130, 1),
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Phone Number',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "+234814572839",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(36, 37, 130, 1),
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Select Centre',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "John Doe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(36, 37, 130, 1),
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Submit'),
                        ),
                      ),
                      onPressed: () {
                        createAlertDialog(context);
                      })
                ],
              ),
            )
          ],
        )),
      ]),
    );
  }
}
