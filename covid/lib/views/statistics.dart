import 'package:covid/models/Covids.dart';
import 'package:covid/provider/getData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';



class Statistics extends StatefulWidget {
  Statistics({Key key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  Map<String, List<Covids>> see;
  check() async{
    see = await getData();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text("Statistics", style: TextStyle(
          color: Color.fromRGBO(36, 37, 130, 1),fontSize: 30,
        ),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child:
        FutureBuilder <Map <String, List<Covids>>>(
            future: getData(),
            builder: (context, snapshot){
            if (snapshot.hasError) print(snapshot.error);
            double perconfirmed = 0;
            double perdeaths = 0;
            double perrecovered = 0;
            double perincrease = 0;
            if (snapshot.hasData){
              int total = snapshot.data["Nigeria"].last.confirmed;
              int deaths = snapshot.data["Nigeria"].last.deaths;
              int recovered = snapshot.data["Nigeria"].last.recovered;
              perconfirmed = total/total;
              perdeaths = deaths / total;
              perrecovered = recovered / total;

//               to get pecentage nIncrease
              int pos = snapshot.data["Nigeria"].length-2;
            int second = snapshot.data["Nigeria"].elementAt(pos).confirmed;
            int calc = total - second;
            double dcalc  = calc/total;
            perincrease = dcalc * 100;

//            to get world wide deaths
            int worldtotal = 0;
            snapshot.data.forEach((String key, List<Covids> c)=>{
              worldtotal = worldtotal + snapshot.data[key].last.confirmed,
              print(worldtotal),
            });


            }
            return snapshot.hasData ?
            ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top:40,left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                  padding: EdgeInsets.only(top:5, bottom: 5, left: 15),
                  color: Color.fromARGB(1,36, 37, 130).withOpacity(0.3),
                  child: Text("Nigeria", style: TextStyle(
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
                                          Text("${snapshot.data["Nigeria"].last.confirmed}", style: TextStyle(
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
                                        Text("${snapshot.data["Nigeria"].last.deaths}", style: TextStyle(
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
                                        Text("${snapshot.data["Nigeria"].last.recovered}", style: TextStyle(
                                          color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w700,
                                        ), ),
                                      ],
                                    ),
                                  ),
                                  new LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.5,
                                    lineHeight: 8.0,
                                    percent: perrecovered,
                                    progressColor: Color.fromARGB(1,36, 37, 130).withOpacity(1),
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
                            color: Colors.black,fontSize: 30,fontWeight: FontWeight.w800,
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
                                onPressed: (){
                              print("hello");
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
                            Text("500"),
                            Text("Percentage \nIncrease", style: TextStyle(
                                color: Color.fromARGB(1,36, 37, 130).withOpacity(1),fontWeight: FontWeight.w700,fontSize:13
                            ),)
                          ],),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          child: Column(children: <Widget>[
                            Text("500"),
                            Text("Percentage \nIncrease", style: TextStyle(
                                color: Color.fromARGB(1,36, 37, 130).withOpacity(1),fontWeight: FontWeight.w700,fontSize:13
                            ),)
                          ],),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          child: Column(children: <Widget>[
                            Text("500"),
                            Text("Percentage \nIncrease", style: TextStyle(
                                color: Color.fromARGB(1,36, 37, 130).withOpacity(1),fontWeight: FontWeight.w700,fontSize:13
                            ),)
                          ],),
                        ),
                      ],
                    )
                ),
              ],
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
}