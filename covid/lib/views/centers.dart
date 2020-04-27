import 'package:covid/models/centersmodel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Centerss extends StatefulWidget {
 final List<Datum> first;
 final String query;
  Centerss({Key key, @required this.first, @required this.query}) : super(key: key);

  @override
  _CentersState createState() => _CentersState(first: first, query: query);
}

class _CentersState extends State<Centerss> {
  static const Color color = Color(0xff002657);
  static const TextStyle style =
  TextStyle(fontSize: 16.0, color: Color(0xff002657));
  final String query;
  final List<Datum> first;
  _CentersState({ @required this.first, @required this.query});
  List<Datum> result = List();
  List<bool> full = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<Datum> search = List();
    if(query == "all"){
      setState(() {
        result = first;
      });
    }else{
      first.forEach((Datum d){
        if(d.name.toLowerCase().contains(query.toLowerCase())){
          search.add(d);
        }else if(d.address.toLowerCase().contains(query.toLowerCase())){
          search.add(d);
        }
      });
      setState(() {
        result = search;
      });
    }
    List<bool> fill = List();
    result.forEach((Datum c)=>fill.add(false));
    setState(() {
      full = fill;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
            icon: Icon(Icons.arrow_back,
                size: 20,
                color: color),
            onPressed: () {
//              setState(() {
//                result = null;
//              });
              Navigator.pop(context);
            }),
        elevation: 0,
        centerTitle: true,
        title: Text("Centers", style: TextStyle(
          color: Color.fromRGBO(36, 37, 130, 1),fontSize: 30,
        ),),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.05, left: 15, right: 15, bottom: 15),
          width: double.infinity,
          color: Colors.white,
          child:(result != null)? ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for(var item in result) centerCard(item, result.indexOf(item)),
                ],
              ),
            ],
          ):Center(child: Text("No Test Centers Available", textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1), fontSize: 25, fontWeight: FontWeight.w400),),),
      ),
    );
  }



  Widget centerCard(Datum d, int i){
    print(i);
    bool fill = false;
    return GestureDetector(
      onTap: (){
//      fill = (fill)?false:true;
        print(fill);
        full.forEach((f)=>print(f));
        setState(() {
          full[i] = (full[i])?false:true;
        });
        full.forEach((f)=>print(f));
      },
      child: Container(
        margin: EdgeInsets.only(top:10),
        child: Card(
          elevation: 10.0,
          color: Colors.white,
          child:AnimatedCrossFade(
            key: ValueKey<int>(i),
            duration: Duration(milliseconds: 300),
            firstChild: Container(
              margin: EdgeInsets.only(left: 10.0, right:10),
              height: 100,
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${d.name}',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${d.address}',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Color(0xFF242582),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:
                    Container(
                      width: 55,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: color,
                      ),
                      child: Image.asset("assets/images/beacon.png"),
                      padding: EdgeInsets.all(10),
                    ),
//                    Container(
//                      width: 55,
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(8.0),
//                        image: DecorationImage(
//                            image: AssetImage(
//                                'assets/images/test_centre.png'),
//                            fit: BoxFit.fill),
//                      ),
//                    ),
                  ),
                ],
              ),
            ),
            secondChild: Container(
                margin: EdgeInsets.only(bottom: 15.0),
                height: 170,
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        print(d.email);
                        if(d.email != null){
                          String url = "mailto:${d.email}?subject=COVID-19&body=Message%20Here";
                          await canLaunch(url)? await launch(url): throw 'Could not launch $url';
                        }
                      },
                      child: Container(
                        height:30,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 5.0),
                        padding: EdgeInsets.all(5),
                        width: double.infinity,
                        color: color.withOpacity(0.1),
                        child: Text((d.email != null)?"Email:\t ${d.email}":"Email:\t Not Available"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(d.phoneNumber!=null){
                          String url = "tel:${d.phoneNumber}";
                          await canLaunch(url)? await launch(url): throw 'Could not launch $url';
                        }
                      },
                      child: Container(
                        height:30,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 5.0),
                        padding: EdgeInsets.all(5),
                        width: double.infinity,
                        color: color.withOpacity(0.1),
                        child: Text((d.phoneNumber!=null)?"Phone Number:\t ${d.phoneNumber}":"Phone Number:\t Not Available"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(d.otherNumbers[0]!=null){
                          String url = "tel:${d.phoneNumber}";
                          await canLaunch(url)? await launch(url): throw 'Could not launch $url';
                        }
                      },
                      child: Container(
                        height:30,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 5.0),
                        padding: EdgeInsets.all(5),
                        width: double.infinity,
                        color: color.withOpacity(0.1),
                        child: Text((d.otherNumbers[0]!=null)?"Other Number:\t ${d.otherNumbers[0]}":"Other Number:\t Not Available"),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          full[i] = false;
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 10),
                          color: color,
                          height: 30,
                          alignment: Alignment.center,
                          child: Text("close", style: TextStyle(fontSize: 16, color: Colors.white),)),
                    ),
                  ],
                )
            ),
            crossFadeState: full[i] ? CrossFadeState.showSecond:CrossFadeState.showFirst,
          ),
        ),
      ),
    );
  }
}