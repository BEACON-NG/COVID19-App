import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Morecontacts extends StatefulWidget {
  Morecontacts({Key key}) : super(key: key);

  @override
  _MorecontactsState createState() => _MorecontactsState();
}

class _MorecontactsState extends State<Morecontacts> {

  static const Color color = Color(0xff002657);
  List<Regions> regions = [
    Regions(region: "North Central", states: [
      States(name: "Benue State", hotlines: [
        "09018602439","07025031214"
      ]),
      States(name: "Federal Capital Territory", hotlines: [
        "08099936312","08099936313"
        ,"08099936314","07080631500","08031230330","08031230508"
      ]),
      States(name: "Kogi State", hotlines: [
        "07088292249","08150953486","08095227003","07043402122"
      ]),
      States(name: "Kwara State", hotlines: [
        "09062010001","09062010002"
      ]),
      States(name: "Nasarawa State", hotlines: [
        "08036018579","08035871718",
        "08033254549","08036201904",
        "08032910826","08121243191",
      ]),
      States(name: "Niger State", hotlines: [
        "09010999909","09010999910"
      ]),
      States(name: "Plateau State", hotlines: [
        "07032864444","08035422711",
        "08065486416","08035779917"
      ]),
    ]),
    Regions(region: "North East", states: [
      States(name: "Adamawa State", hotlines: [
        "08031230359","07080601139",
        "08115850085","07025040415","09044235334"
      ]),
      States(name: "Borno State", hotlines: [
        "08088159881","080099999999"
      ]),
      States(name: "Bauchi State", hotlines: [
        "08023909309","08032717887","08059600898","08033698036"
        ,"08080330216","08036911698"
      ]),
      States(name: "Gombe State", hotlines: [
        "08103371257",
        "07026256569",
        "07045257107",
        "07025227843",
        "07026761392",
        "07026799901",
        "07042145504"
      ]),
      States(name: "Taraba State", hotlines: [
        "08065508675",
        "08032501165",
        "08039359368",
        "08037450227",
      ]),
      States(name: "Yobe State", hotlines: [
        "08131834764",
        "07041116027",
      ]),
    ]),
    Regions(region: "North West", states: [
      States(name: "Jigawa State", hotlines: [
        "08068725224","08034864266",
        "08035997118",
        "08036440522",
        "08069323005",
        "08038806682",
        "07035997118",
        "08038629331",
      ]),
      States(name: "Kaduna State", hotlines: [
        "08035871662",
        "08025088304",
        "08032401473",
        "08037808191",
      ]),
      States(name: "Kano State", hotlines: [
        "08039704476",
        "08037038597",
        "09093995333",
        "09093995444",
      ]),
      States(name: "Katsina State", hotlines: [
        "09035037114",
        "09047092428",
        "08065635686",
        "08065568805",
      ]),
      States(name: "Kebbi State", hotlines: [
        "08036782507",
        "08036074588",
        "08032907601",
        "07035606421",
        "08067677723",
        "08167597029",
        "08083400849",
        "07046352309",
        "07046407663",
        "07046935560",
      ]),
      States(name: "Sokoto State", hotlines: [
        "08032311116",
        "08022069567",
        "08035074228",
        "07031935037",
        "08036394462",
      ]),
      States(name: "Zamfara State", hotlines: [
        "08035626731",
        "08035161538",
        "08161330774",
        "08065408696",
        "08105009888",
        "08063075385",
      ]),
    ]),
    Regions(region: "South East", states: [
      States(name: "Abia State", hotlines: [
        "07002242362"
      ]),
      States(name: "Anambra State", hotlines: [
        "09034728047",
        "09034668319",
        "08163594310",
        "09034663273",
        "09145434416",
        "08117567363",
        ]),
      States(name: "Ebonyi State", hotlines: [
        "09020332489",
        "08159279460",
        "07045910340",
        "07085763054",
        "09026434547",
        ]),
      States(name: "Enugu State", hotlines: [
        "08182555550","09022333833"
      ]),
      States(name: "Imo State", hotlines: [
        "08099555577","07087110839",
      ]),
    ]),
    Regions(region: "South South", states: [
      States(name: "Akwa Ibom State", hotlines: [
        "08189411111",
        "09045575515",
        "07035211919",
        "08028442194",
        "08037934966",
        "09023330092",
      ]),
      States(name: "Bayelsa State", hotlines: [
        "08039216821",
        "07019304970",
        "08151693570",
         ]),
      States(name: "Cross River State", hotlines: [
        "07035371180","08050907736"]),
      States(name: "Delta State", hotlines: [
        "08033521961",
        "08035078541",
        "08030758179",
        "09065031241",
      ]),
      States(name: "Edo State", hotlines: [
        "08084096723",
        "08064258163",
        "08035835529",
      ]),
      States(name: "Rivers State", hotlines: [
        "08056109538",
        "08031888093",
        "08033124314",
        "09062277699",
        "08102900000",
      ]),
    ]),
    Regions(region: "South West", states: [
      States(name: "Ogun State", hotlines: [
        "08188978393",
        "08188978392",
        "08001235678",
      ]),
      States(name: "Ondo State", hotlines: [
        "07002684319","08002684319"
         ]),
      States(name: "Osun State", hotlines: [
        "08035025692",
        "08033908772",
        "08056456250",
        "293",
        ]),
      States(name: "Oyo State", hotlines: [
        "08095394000",
        "08078288999",
        "08078288800",
      ]),
      States(name: "Ekiti State", hotlines: [
        "09062970434",
        "09062970435",
        "09062970436",
      ]),
      States(name: "Lagos State", hotlines: [
        "08023169485",
        "08033565529",
        "08052817243",
        "08028971864",
        "08059758886",
        "08035387653",
        "08000267662",
      ]),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading:  IconButton(
              icon: Icon(Icons.arrow_back,
                  size: 20,
                  color: color),
              onPressed: () {
                Navigator.pop(context);
              }),
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
      body:
      ListView.builder(
          itemCount: regions.length,
          itemBuilder: (BuildContext context, int i){
            return Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation:20,
                      child: Padding(
                        padding: const EdgeInsets.only(top:15, bottom: 15, left: 15),
                        child: Text(
                          regions[i].region,
                          style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1)),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                   Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height*0.6,
                    child: ListView.builder(
                        itemCount: regions[i].states.length,
                        itemBuilder: (BuildContext context, int l){
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Card(
                              elevation:30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                    child: Text(
                                      regions[i].states[l].name,
                                      style:
                                      TextStyle(color: Color.fromRGBO(36, 37, 130, 1)),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  for(var nums in regions[i].states[l].hotlines)
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 20,),
                                        child: Card(
                                          elevation: 20,
                                            child: GestureDetector(
                                              onTap: () async{
                                                var url = "tel:${nums}";
                                                await canLaunch(url)? await launch(url): throw 'Could not launch $url';
              //                                _launchCaller(listModel[i]);
                                              },
                                              child: ListTile(
                                                title: Text(nums ?? '',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(27, 92, 161, 1))),
                                                trailing: Icon(Icons.call_end, color:color,),
                                              ),
                                            )),
                                      ) ,
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                    ),
                ),
                SizedBox(height: 30,),
              ],
            );
          })
    );
  }
}
class Regions{
  final String region;
  final List<States> states;
  Regions({this.region, this.states});
}
class States{
  final String name;
  final List<String> hotlines;
  States({this.name, this.hotlines});
}