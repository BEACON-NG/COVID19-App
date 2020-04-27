import 'package:covid/views/donation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

bool _donating = false;
final TextEditingController _email = TextEditingController();
final TextEditingController _name = TextEditingController();
final TextEditingController _phoneNumber = TextEditingController();
final TextEditingController _location = TextEditingController();
final _volunteerKey = GlobalKey<FormState>();
class Volunteer extends StatefulWidget {
  Volunteer({Key key}) : super(key: key);

  @override
  _VolunteerState createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  createAlertDialog(BuildContext context) async{
    final MailOptions mailOptions = MailOptions(
      body: 'Name: ${_name.text} <br/>Email Address: ${_email.text} <br/>Phone Number: ${_phoneNumber.text} <br/>State: ${_location.text}',
      subject: 'Beacon Volunteer for Covid\'19 ',
      recipients: ['beacon.covid@gmail.com'],
      isHTML: true,
//      bccRecipients: ['other@example.com'],
//      ccRecipients: ['third@example.com'],
//      attachments: [ 'path/to/image.png', ],
    );

    await FlutterMailer.send(mailOptions);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Text('Your Entry has been received!'),
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
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Volunteers',
          style: TextStyle(color: Color.fromRGBO(0, 38, 87, 1)),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: _volunteerKey,
          child: ListView(children: <Widget>[
            Container(
              color: Colors.white,
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
                          onPressed: () {
                            setState(() {
                              _donating = false;
                            });
                          },
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: (_donating)?Colors.white:Color.fromRGBO(38, 153, 251, 1),
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
                                  Icon(Icons.group, color:(_donating)? Color.fromRGBO(36, 37, 130, 1):Colors.white),
                                  Text(
                                    'Volunteer',
                                    style: TextStyle(color: (_donating)? Color.fromRGBO(36, 37, 130, 1):Colors.white),
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
                          onPressed: () {

                            setState(() {
                              _donating = true;
                            });
                          },
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: (_donating)?Color.fromRGBO(38, 153, 251, 1):Colors.white,
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
                                      color: (_donating)?Colors.white:Color.fromRGBO(36, 37, 130, 1)),
                                  Text(
                                    'Donate',
                                    style: TextStyle(
                                        color: (_donating)?Colors.white:Color.fromRGBO(36, 37, 130, 1)),
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
                  child: (_donating)?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                      Text(
                        "Click the button below to donate",
//                      "Click the button below to donate towards the infected",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1), fontSize: 25, fontWeight: FontWeight.w300),),
                      SizedBox(height: 30,),
                      Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 0.1),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: FlatButton(
                              onPressed: (){
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => Donation(donate: "https://zoeparisfoundation.org/donate",)));
//
                              }, child: Text("Zoeparisfoundation.org", style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1), fontSize: 12),)),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 0.1),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: FlatButton(
                              onPressed: (){
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => Donation(donate: "https://covid19responsefund.org/",)));
//
                              }, child: Text("W.H.O Response Team", style: TextStyle(color:Color.fromRGBO(36, 37, 130, 1), fontSize: 12),)),
                        ),
                      ),
                      SizedBox(height: 10,),
//                    Text("by Zoeparisfoundation.org",textAlign: TextAlign.center,
//                      style: TextStyle(color: Color.fromRGBO(38, 153, 251, 1), fontSize: 12, fontWeight: FontWeight.normal),),

                    ],
                  )
                      :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Name',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      TextFormField(
                        controller: _name,
                        validator: (value){
                          if(value.isEmpty){
                            return "Please Enter Text";
                          }return null;
                        },
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
                      TextFormField(

                        controller:_email,
                        validator: (value){
                          if(value.isEmpty){
                            return "Please Enter Text";
                          }else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.text) ==false)
                          {
                            return "The input is not a valid Email Address.  ";}
                          return null;
                        },
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
                      TextFormField(
                        controller: _phoneNumber,
                        validator: (value){
                          if(value.isEmpty){
                            return "Please Enter Text";
                          }else if (RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(_phoneNumber.text) ==false)
                          {
                            return "The input is not a phone number.  ";}
                          return null;
                        },
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
                          'State',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      TextFormField(
                        controller: _location,
                        validator: (value){
                          if(value.isEmpty){
                            return "Please Enter Text";
                          }return null;
                        },
                        decoration: InputDecoration(
                          hintText: "State",
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
                          onPressed: () async{
                        // Validate returns true if the form is valid, otherwise false.
                        if (_volunteerKey.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          Scaffold
                              .of(context)
                              .showSnackBar(SnackBar(content: Text('Processing Data...')));
                          await createAlertDialog(context);
                        }
                      },),
                    ],
                  ),
                )
              ],
            )),
          ]),
        ),
      ),
    );
  }
}






