import 'dart:io';
import 'dart:math';
import 'package:covid/main.dart';
import 'package:covid/models/LocationBasedData.dart';
import 'package:covid/models/country.dart';
import 'package:covid/provider/getCountries.dart';
import 'package:covid/provider/getLocationBasedData.dart';
import 'package:covid/provider/getUserLocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:covid/models/Worldtotal.dart';
import 'package:covid/provider/getWorldData.dart';
import 'package:image/image.dart' as imaged;
import 'package:covid/models/Covids.dart';
import 'package:covid/provider/getData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:open/open.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfw;


String s = "";
String country = "Nigeria";
class Statistics extends StatefulWidget {
  Statistics({Key key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  Map<String, List<Covids>> see;
  File _imageFile;
  bool full = true;

  List<Country> countries = List();
//Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  check() async{
    String counts = await getUserLocation();
    List<Country> contries = await getCountries();
    setState(() {
      country = counts;
      countries = contries;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
      (full)?
      AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading:IconButton(icon:Icon(Icons.arrow_back, size: 30, color: Color.fromARGB(1,36, 37, 130).withOpacity(1)), onPressed: (){
          setState(() {full = false;});
        },),
        title: Text("Statistics", style: TextStyle(
          color: Color.fromRGBO(36, 37, 130, 1),fontSize: 40,
        ),),
      ):
      PreferredSize(child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(1, 0, 38, 87).withOpacity(1), 
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
        child: Column(
          children: <Widget>[
            AppBar(
              leading:IconButton(icon:Icon(Icons.arrow_back, size: 30, color: Colors.white), onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
              },),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text("COVID'19 Update", style: TextStyle(
                color: Colors.white,fontSize: 24,fontWeight: FontWeight.w400,
              ),),
            ),
            Container(
              margin: EdgeInsets.only(top:20,left: MediaQuery.of(context).size.width*0.02, right: MediaQuery.of(context).size.width*0.02),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.3,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/world.png"),fit: BoxFit.fill))
            )
          ],
        ),
      ),
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height*0.45)),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child:
        FutureBuilder <LocationBasedData>(
            future: getLocationBasedData(),
            builder: (context, snapshot){
            if (snapshot.hasError) print(snapshot.error);
            List<Location> cases = List();
            double perconfirmed = 0;
            double perdeaths = 0;
            double perrecovered = 0;
            String perincrease;
            Location dlocale;
            double worldimprovement;
            String strworld;
            List<Country> cuntries;
            if (snapshot.hasData) {
              snapshot.data.locations.forEach((Location l)=>((l.country == country)?dlocale = l : print("not found")));
              cuntries = countries;
              int total = dlocale.latest.confirmed;
              int deaths = dlocale.latest.deaths;
              int recovered = dlocale.latest.recovered;
              perconfirmed = total/total;
              perdeaths = deaths / total;
              perrecovered = recovered / total;

//               to get pecentage nIncrease
//              int pos = snapshot.data["Nigeria"].length-2;
//            int second = snapshot.data["Nigeria"].elementAt(pos).confirmed;
              int second = dlocale.yesterday.confirmed;
            int calc = total - second;
            double dcalc  = calc/total;
            double increase = dcalc * 100;
            perincrease = increase.toStringAsFixed(2);

//            to get world wide worldimprovement
            double wdi = snapshot.data.latest.recovered/snapshot.data.latest.confirmed;
              double ss = double.parse(wdi.toStringAsFixed(2));
              worldimprovement = ss;
              double str = worldimprovement * 100;
              strworld = str.toStringAsFixed(2);

//              to find the highest five
            LocationBasedData lcbd = snapshot.data;
            List<Location> loc = lcbd.locations;

//            loc.forEach((Location l)=> cases.add(l.latest.confirmed));

          for(int i = 0; i < 5; i++){
            dynamic max = loc.first;
            loc.forEach((e){
              if(e.latest.confirmed > max.latest.confirmed) max = e;
            });
            cases.add(max);
            loc.removeAt(loc.indexOf(max));
          }
          cases.forEach((d){
            print(d.latest.confirmed);
          });
            }
            return snapshot.hasData ?
            Screenshot(
              controller: screenshotController,
              child:(full)?
              ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top:30,left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("COVID'19 Update", style: TextStyle(
                          color: Color.fromARGB(1, 27, 92, 161).withOpacity(1),fontSize: 21,fontWeight: FontWeight.w400,
                        ),),
                        Text("Check out latest statistics of COVID'19", style: TextStyle(
                          color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300,
                        ),),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:30,left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                    padding: EdgeInsets.only(top:5, bottom: 5, left: 15),
                    color: Color.fromARGB(1,36, 37, 130).withOpacity(0.3),
                    child: Text("$country", style: TextStyle(
                      color: Colors.black,fontSize: 25,
                    ),),
                  ),
                  Container(
                    height: 170,
                      margin: EdgeInsets.only(top:30,left: MediaQuery.of(context).size.width*0.03, right: MediaQuery.of(context).size.width*0.05),
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/coro.png"),fit: BoxFit.cover)),
                          width: MediaQuery.of(context).size.width*0.4,
                        ),
                        Container(
                          margin: EdgeInsets.only(top:19),
                          width: MediaQuery.of(context).size.width*0.5,
                          child: Column(
                            children: <Widget>[
                                Container(
                                  height:40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left:5,right: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Total Cases", style: TextStyle(
                                              color: Color.fromRGBO(36, 37, 130, 1),fontSize: 15,fontWeight: FontWeight.w700,
                                            ), ),
                                            Text("${dlocale.latest.confirmed}", style: TextStyle(
                                              color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w700,
                                            ), ),
                                          ],
                                        ),
                                      ),
                                      new LinearPercentIndicator(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        lineHeight: 8.0,
                                        percent: perconfirmed,
                                        backgroundColor: Colors.grey.withOpacity(0.1),
                                        progressColor: Color.fromARGB(1,0, 0, 0).withOpacity(1),
                                      ),
                                    ],
                                  ),
                                ),

                              Container(
                                height:40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left:5,right: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Deaths", style: TextStyle(
                                            color: Color.fromRGBO(36, 37, 130, 1),fontSize: 15,fontWeight: FontWeight.w700,
                                          ), ),
                                          Text("${dlocale.latest.deaths}", style: TextStyle(
                                            color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w700,
                                          ), ),
                                        ],
                                      ),
                                    ),
                                    new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      lineHeight: 8.0,
                                      percent: perdeaths,
                                      progressColor: Color.fromARGB(1,200, 24, 24).withOpacity(1),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height:40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left:5,right: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Recovered", style: TextStyle(
                                            color: Color.fromRGBO(36, 37, 130, 1),fontSize: 15,fontWeight: FontWeight.w700,
                                          ), ),
                                          Text("${dlocale.latest.recovered}", style: TextStyle(
                                            color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w700,
                                          ), ),
                                        ],
                                      ),
                                    ),
                                    new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      lineHeight: 8.0,
                                      percent: perrecovered,
                                      progressColor: Color.fromARGB(1,0, 87, 87).withOpacity(1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ),

                  Container(
                      margin: EdgeInsets.only(top:10,left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width*0.3,
                            child: Row(children: <Widget>[
                              Icon(Icons.show_chart, size: 40,color: Color.fromARGB(1,36, 37, 130).withOpacity(1),),
                              Text("Percentage \nIncrease", style: TextStyle(
                                color: Color.fromARGB(1,36, 37, 130).withOpacity(1),fontWeight: FontWeight.w700,fontSize:13
                              ),)
                            ],),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            child: Text("${perincrease}%", style: TextStyle(
                              color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800,
                            ),),
                          ),
                          Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width*0.3,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(7,27, 92, 161).withOpacity(0.25),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: FlatButton(
                                  onPressed: () async{
                                    _imageFile = null;

//                                    final Directory pat = await getApplicationDocumentsDirectory();
                                    final Directory pat = await getExternalStorageDirectory();
                                    final Directory beacon = Directory("${pat.path}/BEACON");
                                    String pas;
                                    if(await beacon.exists()){ pas = beacon.path; }else{
                                      final Directory _beacon=await beacon.create(recursive: true);
                                      pas = _beacon.path;
                                    }
                                    screenshotController.capture().then((File inmage) async{
                                      //Capture Done
                                      setState(() {
                                        _imageFile = inmage;
                                      });
                                      final pdfw.Document pdf = pdfw.Document();
                                      final img = imaged.decodeImage(_imageFile.readAsBytesSync());
                                      final image = PdfImage(
                                        pdf.document,
                                        image: img.data.buffer.asUint8List(),
                                        width: img.width,
                                        height: img.height,
                                      );
                                      pdf.addPage(pdfw.Page(
                                          build: (pdfw.Context context) {
                                            return pdfw.Center(
                                              child: pdfw.Image(image),
                                            ); // Center
                                          })); // P
                                      int num = new Random().nextInt(1000);
                                      final files = File("$pas/beaconstat${num}.pdf");
                                      setState(() {
                                        s = files.path;
                                      });
                                      await files.writeAsBytes(pdf.save());

                                    }).catchError((onError) {
                                      print(onError);
                                    });
                                    if(s.isNotEmpty){
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("File successfully added \n ${s}"), elevation: 5,
                                          duration: Duration(seconds: 45),
//                                          action: SnackBarAction(label: "open", onPressed: () async=>(await open("$s"))),
                                        ),
                                      );
                                    }else{
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("File could not be generated"), elevation: 5,
//                                          action: SnackBarAction(label: "open", onPressed: () async=>(await open("$s"))),
                                        ),
                                      );
                                    }
                                  }, child: Row(
                                children: <Widget>[
                                  Icon(MaterialCommunityIcons.arrow_collapse_down, size: 15,color: Color.fromARGB(1,36, 37, 130).withOpacity(1),),
                                  Text("\t Download Data", style: TextStyle(fontSize:9, color: Color.fromARGB(1,36, 37, 130).withOpacity(1)),),
                                ],
                              )),
                          ),
                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top:60,left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                    padding: EdgeInsets.only(top:5, bottom: 5, left: 15),
//                  color: Color.fromRGBO(200, 24, 24, 0.3),
                  color: Color.fromARGB(1, 200, 24, 24).withOpacity(0.3),
                    child: Text("World", style: TextStyle(
                      color: Color.fromRGBO(36, 37, 130, 1),fontSize: 25,
                    ),),
                  ),
                  Container(
                      margin: EdgeInsets.only(top:40,left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width*0.3,
                            child: Column(children: <Widget>[
                              Text("${snapshot.data.latest.confirmed}",
                              style: TextStyle(
                                color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800,)),
                              Text("Total \nRecorded", style: TextStyle(
                                  color: Color.fromARGB(1,36, 37, 130).withOpacity(1),fontWeight: FontWeight.w700,fontSize:13
                              ),)
                            ],),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width*0.3,
                            child: Column(children: <Widget>[
                              Text("${snapshot.data.latest.deaths}",
                                  style: TextStyle(
                                    color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800,)),
                              Text("Total \nDeaths", style: TextStyle(
                                  color: Color.fromARGB(1,36, 37, 130).withOpacity(1),fontWeight: FontWeight.w700,fontSize:13
                              ),)
                            ],),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.3,
                            child: Column(children: <Widget>[
                              Text("${snapshot.data.latest.recovered}",
                                  style: TextStyle(
                                    color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800,)),
                              Text("Total \nRecovery", style: TextStyle(
                                  color: Color.fromARGB(1,36, 37, 130).withOpacity(1),fontWeight: FontWeight.w700,fontSize:13
                              ),)
                            ],),
                          ),
                        ],
                      ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:30, left: 30, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left:5,right: 15, bottom:5,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Total Cases", style: TextStyle(
                                color: Color.fromRGBO(36, 37, 130, 1),fontSize: 15,fontWeight: FontWeight.w700,
                              ), ),
//                              worldimprovement * 100
                              Text("${strworld}%", style: TextStyle(
                                color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w700,
                              ), ),
                            ],
                          ),
                        ),
                        new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width*0.8,
                          lineHeight: 8.0,
                          percent: worldimprovement,
                          progressColor: Color.fromARGB(1,0, 38, 87).withOpacity(1),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  :
              ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top:30,left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("COVID'19 Update", style: TextStyle(
                          color: Color.fromARGB(1, 27, 92, 161).withOpacity(1),fontSize: 21,fontWeight: FontWeight.w400,
                        ),),
                        Text("Check out latest statistics of COVID'19", style: TextStyle(
                          color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300,
                        ),),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:30,left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                    padding: EdgeInsets.only(top:5, bottom: 5, left: 15, right: 15),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(1,238, 242, 254).withOpacity(1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("$country", style: TextStyle(
                          color: Color.fromARGB(1,27, 92, 161).withOpacity(1),fontSize: 14,
                        ),),
                        IconButton(icon: Icon(Ionicons.ios_arrow_down, size: 14,),
                            onPressed: (){
                              showMaterialDialog<String>(
                                context: context,
                                child: AlertDialog(
                                  content: Container(
                                      height: MediaQuery.of(context).size.height*0.7,
                                      child: ListView.builder(itemBuilder: (BuildContext context, int i){
                                          return FlatButton(onPressed: (){
                                            setState(() {
                                              country = countries[i].name;
                                            });
                                            Navigator.pop(context, 'cancel');
                                          }, child: Text("${countries[i].name}", style: TextStyle(color: Colors.grey),));
                                      }, itemCount: countries.length)),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: const Text('CANCEL'),
                                      onPressed: () {
                                        Navigator.pop(context, 'cancel');
                                      },
                                    ),

                                  ],
                                ),
                              );
                            })

                      ],
                    ),
                  ),
                  Container(
                      height: 170,
                      margin: EdgeInsets.only(top:30,left: MediaQuery.of(context).size.width*0.03, right: MediaQuery.of(context).size.width*0.05),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/coro.png"),fit: BoxFit.cover)),
                            width: MediaQuery.of(context).size.width*0.4,
                          ),
                          Container(
                            margin: EdgeInsets.only(top:19),
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height:40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left:5,right: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Total Cases", style: TextStyle(
                                              color: Color.fromRGBO(36, 37, 130, 1),fontSize: 15,fontWeight: FontWeight.w700,
                                            ), ),
                                            Text("${dlocale.latest.confirmed}", style: TextStyle(
                                              color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w700,
                                            ), ),
                                          ],
                                        ),
                                      ),
                                      new LinearPercentIndicator(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        lineHeight: 8.0,
                                        percent: perconfirmed,
                                        backgroundColor: Colors.grey.withOpacity(0.1),
                                        progressColor: Color.fromARGB(1,0, 0, 0).withOpacity(1),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  height:40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left:5,right: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Deaths", style: TextStyle(
                                              color: Color.fromRGBO(36, 37, 130, 1),fontSize: 15,fontWeight: FontWeight.w700,
                                            ), ),
                                            Text("${dlocale.latest.deaths}", style: TextStyle(
                                              color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w700,
                                            ), ),
                                          ],
                                        ),
                                      ),
                                      new LinearPercentIndicator(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        lineHeight: 8.0,
                                        percent: perdeaths,
                                        progressColor: Color.fromARGB(1,200, 24, 24).withOpacity(1),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  height:40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left:5,right: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Recovered", style: TextStyle(
                                              color: Color.fromRGBO(36, 37, 130, 1),fontSize: 15,fontWeight: FontWeight.w700,
                                            ), ),
                                            Text("${dlocale.latest.recovered}", style: TextStyle(
                                              color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w700,
                                            ), ),
                                          ],
                                        ),
                                      ),
                                      new LinearPercentIndicator(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        lineHeight: 8.0,
                                        percent: perrecovered,
                                        progressColor: Color.fromARGB(1,0, 87, 87).withOpacity(1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),

                  Container(
                      margin: EdgeInsets.only(top:10,left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width*0.3,
                            child: Row(children: <Widget>[
                              Icon(Icons.show_chart, size: 40,color: Color.fromARGB(1,36, 37, 130).withOpacity(1),),
                              Text("Percentage \nIncrease", style: TextStyle(
                                  color: Color.fromARGB(1,36, 37, 130).withOpacity(1),fontWeight: FontWeight.w700,fontSize:13
                              ),)
                            ],),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            child: Text("${perincrease}%", style: TextStyle(
                              color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800,
                            ),),
                          ),
                          Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width*0.3,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(7,27, 92, 161).withOpacity(0.25),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: FlatButton(
                                onPressed: () async{
                                  _imageFile = null;

//                                    final Directory pat = await getApplicationDocumentsDirectory();
                                  final Directory pat = await getExternalStorageDirectory();
                                  final Directory beacon = Directory("${pat.path}/BEACON");
                                  String pas;
                                  if(await beacon.exists()){ pas = beacon.path; }else{
                                    final Directory _beacon=await beacon.create(recursive: true);
                                    pas = _beacon.path;
                                  }
                                  screenshotController.capture().then((File inmage) async{
                                    //Capture Done
                                    setState(() {
                                      _imageFile = inmage;
                                    });
                                    final pdfw.Document pdf = pdfw.Document();
                                    final img = imaged.decodeImage(_imageFile.readAsBytesSync());
                                    final image = PdfImage(
                                      pdf.document,
                                      image: img.data.buffer.asUint8List(),
                                      width: img.width,
                                      height: img.height,
                                    );
                                    pdf.addPage(pdfw.Page(
                                        build: (pdfw.Context context) {
                                          return pdfw.Center(
                                            child: pdfw.Image(image),
                                          ); // Center
                                        })); // P
                                    int num = new Random().nextInt(1000);
                                    final files = File("$pas/beaconstat${num}.pdf");
                                    setState(() {
                                      s = files.path;
                                    });
                                    await files.writeAsBytes(pdf.save());

                                  }).catchError((onError) {
                                    print(onError);
                                  });
                                  if(s.isNotEmpty){
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("File successfully added \n ${s}"), elevation: 5,
                                        duration: Duration(seconds: 45),
//                                          action: SnackBarAction(label: "open", onPressed: () async=>(await open("$s"))),
                                      ),
                                    );
                                  }else{
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("File could not be generated"), elevation: 5,
//                                          action: SnackBarAction(label: "open", onPressed: () async=>(await open("$s"))),
                                      ),
                                    );
                                  }
                                }, child: Row(
                              children: <Widget>[
                                Icon(MaterialCommunityIcons.arrow_collapse_down, size: 15,color: Color.fromARGB(1,36, 37, 130).withOpacity(1),),
                                Text("\t Download Data", style: TextStyle(fontSize:9, color: Color.fromARGB(1,36, 37, 130).withOpacity(1)),),
                              ],
                            )),
                          ),
                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top:40,left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
//                          width: MediaQuery.of(context).size.width*0.7,
                          child: Row(children: <Widget>[
                            GestureDetector(
                              onTap: (){setState(() {
                                country = cases[0].country;
                              });},
                              child: Container(
                                width:35,
                                height: 35,
                                child:Center(child: Text("${cases[0].countryCode}", style: TextStyle(color:Color.fromARGB(1,68, 202, 69).withOpacity(1)))),
                                decoration: BoxDecoration(color: Color.fromARGB(1, 180, 234, 180).withOpacity(1), borderRadius: BorderRadius.all(Radius.circular(30))),
                              ),
                            ),GestureDetector(
                              onTap: (){setState(() {
                                country = cases[1].country;
                              });},
                              child: Container(
                                width:35,
                                height: 35,
                                child:Center(child: Text("${cases[1].countryCode}", style: TextStyle(color:Color.fromARGB(1,101, 100, 220).withOpacity(1)))),
                                decoration: BoxDecoration(color: Color.fromARGB(1, 193, 193, 241).withOpacity(1), borderRadius: BorderRadius.all(Radius.circular(30))),
                              ),
                            ),GestureDetector(
                              onTap: (){setState(() {
                                country = cases[2].country;
                              });},
                              child: Container(
                                width:35,
                                height: 35,
                                child:Center(child: Text("${cases[2].countryCode}", style: TextStyle(color:Color.fromARGB(1,255, 208, 22).withOpacity(1)))),
                                decoration: BoxDecoration(color: Color.fromARGB(1, 225, 236, 161).withOpacity(1),borderRadius: BorderRadius.all(Radius.circular(30))),
                              ),
                            ),GestureDetector(
                              onTap: (){setState(() {
                                country = cases[3].country;
                              });},
                              child: Container(
                                decoration: BoxDecoration(color: Color.fromARGB(1, 169, 227, 219).withOpacity(1),borderRadius: BorderRadius.all(Radius.circular(30))),
                                width:35,
                                height: 35,
                                child:Center(child: Text("${cases[3].countryCode}", style: TextStyle(color:Color.fromARGB(1,41, 185, 165).withOpacity(1)))),
                              ),
                            ),GestureDetector(
                              onTap: (){setState(() {
                                country = cases[4].country;
                              });},
                              child: Container(
                                width:35,
                                height: 35,
                                child:Center(child: Text("${cases[4].countryCode}", style: TextStyle(color:Color.fromARGB(1,101, 100, 220).withOpacity(1)))),
                                decoration: BoxDecoration(color: Color.fromARGB(1,255, 236, 161).withOpacity(1), borderRadius: BorderRadius.all(Radius.circular(30))),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){setState(() {
                                full = true;
                              });},
                              child: Container(
                                width:80,
                                height: 35,
                                child:Center(child: Text("  SEE MORE \t +", style: TextStyle(color:Colors.grey.withOpacity(0.8)))),
                                ),
                            ),
                          ],),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:30),
                ],
              ),
            )
                :
            CardListSkeleton(
              style: SkeletonStyle(
                theme: SkeletonTheme.Light,
                isShowAvatar: false,
                isCircleAvatar: false,
                barCount: 4,
              ),
            );

        }),
      ),
    );
  }

  void showMaterialDialog<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    )
        .then<void>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {
        print("it is what it is");
      }
    });
  }
}