import 'package:flutter/material.dart';

class Precaution extends StatefulWidget {
  Precaution({Key key}) : super(key: key);

  @override
  _PrecautionState createState() => _PrecautionState();
}

class Precautions {
  final String image;
  final String text;
  Precautions({@required this.text, @required this.image});
}
class _PrecautionState extends State<Precaution> {
  List<Precautions> pres = [
    Precautions(text: "Wash hands regularly", image: "assets/images/pre1.png"),
    Precautions(text: "Use proper protective coverings", image: "assets/images/pre2.png"),
    Precautions(text: "Avoid people with flu symptoms", image: "assets/images/pre3.png"),
    Precautions(text: "Seek medical early care for symptoms", image: "assets/images/pre4.png"),
    Precautions(text: "Inform doctors of your travel history", image: "assets/images/pre5.png"),
    Precautions(text: "Avoid raw meat or live animals", image: "assets/images/pre6.png"),
    Precautions(text: "Avoid public gatherings", image: "assets/images/pre7.png"),
    Precautions(text: "Do not touch your eye, mouth or nose", image: "assets/images/pre8.png"),
    Precautions(text: "maintain social distancing", image: "assets/images/pre9.png"),
    Precautions(text: "Stay indoor and maintain proper hygiene", image: "assets/images/pre10.png"),
  ];
  static const Color color = Color(0xff002657);
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
        title: Text("Precaution", style: TextStyle(
          color: Color.fromRGBO(36, 37, 130, 1),fontSize: 30,
        ),),
        backgroundColor: Colors.transparent,
      ),
      body:Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, position) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical:5),
                child: Card(
                  elevation:10,
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 80,
                            height: 70,
                            child: Image.asset(pres[position].image, fit: BoxFit.scaleDown),
                        ),
                        Text(pres[position].text, style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1), fontSize: 12, fontWeight: FontWeight.w300),textAlign: TextAlign.center,)
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: pres.length,
        ),
      )
    );
  }
}