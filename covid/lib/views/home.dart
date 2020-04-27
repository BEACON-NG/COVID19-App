import 'package:covid/main.dart';
import 'package:covid/models/centersmodel.dart';
import 'package:covid/models/country.dart';
import 'package:covid/provider/getCenters.dart';
import 'package:covid/views/about.dart';
import 'package:covid/views/centers.dart';
import 'package:covid/views/precaution.dart';
import 'package:covid/views/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  final List<Country> countries;
  Home({Key key, this.countries}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(countries: countries);
}
class _HomeState extends State<Home> {
  List<Country> countries;
  bool full = false;
  static const Color color = Color(0xff002657);
  static const TextStyle style =
      TextStyle(fontSize: 10.0, color: Color(0xff002657));
  _HomeState({this.countries});
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Centers covid;
  List<Datum> first = List();
  List<Datum> _first = List();
  List<bool> _full = List();
  List<bool> _fill = List();
  String query = "";
  _getcenter() async{
    List<bool> _full = List();
    Centers c = await getCenters();
    c.data.forEach((Datum c)=>_full.add(false));
    setState(() {
      covid = c;
      _first = covid.data;
      first = covid.data.sublist(0,4);
      _full = _full;
      _fill = _full.sublist(0,4);
      full = true;
    });
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getcenter();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
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
            color: color.withOpacity(0.1),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyHomePage(pageno: 1))),
              leading: Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/news.png'),
                ),
              ),
              title: Text('News', style: style),
            ),
          ),
          Container(
            color: color.withOpacity(0.1),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: ListTile( onTap: ()=>
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Centerss( first: _first, query: "all"))),
              leading: Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child:
                  Image.asset('assets/images/stethoscope.png'),
                ),
              ),
              title: Text('Test Centres', style: style),
            ),
          ),
          Container(
            color: color.withOpacity(0.1),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Statistics())),
              leading: Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child:Image.asset('assets/images/graph.png'),
                ),
              ),
              title: Text(
                  'Global Epidemic Tracker',
                  style: style),
            ),
          ),

//                  'Statistics',
          Container(
            color: color.withOpacity(0.1),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyHomePage(pageno: 3))),
              leading: Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/hands_helping.png',fit: BoxFit.scaleDown,
//                    height: 50,
                  ),
//                  Icon(
//                    FontAwesome5Solid.hands_helping,
//                    color: Colors.white,
//                    size: 16,
//                  ),
                ),
              ),
              title: Text('Volunteer', style: style),
            ),
          ),
          Container(
            color: color.withOpacity(0.1),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Abouts()));
              },
              child: ListTile(
                leading: Container(
                  height: 35,
                  width: 45,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      FontAwesome.info,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
                title: Text('About Us', style: style),
              ),
            ),
          ),
        ],
      )),
      appBar: PreferredSize(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF242582),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16.0))),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/beacon.png',
                  width: 120,
                  height: 50,
                ),
              ),
              Positioned(
                top: 72,
                left: 15,
                child: IconButton(
                    icon: Icon(
                      Feather.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    }),
              ),
              Positioned(
                top: 120,
                left: 15,
                right: 15,
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 40.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextField(
                        onChanged: (text){
                          setState(() {query=text;});
                        },
                        decoration:InputDecoration(
                          prefixIcon:Icon(Feather.search,
                            size: 20, color: Colors.black.withOpacity(0.3)),
                          suffixIcon: (query == "")?  Icon(Icons.keyboard_arrow_down,
                            size: 20, color: Colors.black.withOpacity(0.3))
                        : IconButton(icon: Icon(Icons.arrow_forward,size: 20, color: Colors.black.withOpacity(0.5)),
                            onPressed: (){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => Centerss( first: _first, query: query)));
                            }
                        ),
                          border: InputBorder.none,
                          hintText: 'Search for Test centre',hintStyle:TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.3)),
                          contentPadding: EdgeInsets.only(bottom: 1, top: 7),
                        ),
                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Icon(Feather.search,
//                            size: 16, color: Colors.black.withOpacity(0.3)),
////                        Text(
////                          'Search for Test centre',
////                          style: TextStyle(
////                              fontSize: 16,
////                              color: Colors.black.withOpacity(0.3)),
////                        ),
//                      TextField(
//                        onChanged: (text){
//                          setState(() {query=text;});
//                        },
//                        decoration:InputDecoration(
//                          border: InputBorder.none,
//                          hintText: 'Search for Test centre',hintStyle:TextStyle(
//                            fontSize: 16,
//                            color: Colors.black.withOpacity(0.3)),
//                        ),
//                      ),
//                        (query == "")?  Icon(Icons.keyboard_arrow_down,
//                            size: 18, color: Colors.black.withOpacity(0.3))
//                        : IconButton(icon: Icon(Icons.arrow_forward,size: 18, color: Colors.black.withOpacity(0.5)),
//                            onPressed: (){
//                              Navigator.of(context)
//                                  .push(MaterialPageRoute(builder: (context) => Centerss( first: _first, query: query)));
//                            }
//                        ),
//                      ],
//                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        preferredSize: Size(double.infinity, 140.0),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        margin: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => MyHomePage(pageno: 1)));
                  },
                    child: Container(
                      width: 100.0,
                      margin: EdgeInsets.only(right: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 70,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0xFF002657),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child:
//                            Icon(FontAwesome.newspaper_o, color: Colors.white, size: 30),
                            Image.asset('assets/images/news.png', fit: BoxFit.scaleDown,),
                          ),
                          Text(
                            'News',
                            style: style,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:   () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => Centerss( first: _first, query: "all")));
                    },
                    child: Container(
                      width: 80.0,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 70,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0xFF2699fb),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/stethoscope.png',fit: BoxFit.scaleDown,
                              height: 50,
                            ),
                          ),
                          Text(
                            'Test Centres',
                            style: style,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Statistics()));
                    },
                    child: Container(
                      width: 80.0,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 70,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0xFFCE13BB),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child:
//                            Icon(Icons.show_chart, color: Colors.white, size: 45),
                            Image.asset(
                              'assets/images/graph.png',fit: BoxFit.scaleDown,
                              height: 50,
                            ),
                          ),
                          Text(
                            'Global Epidemic Tracker',textAlign: TextAlign.center,
//                            'Statistics',
                            style: style,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => MyHomePage(pageno: 3)));
                    },
                    child: Container(
                      width: 80.0,
                      margin: EdgeInsets.only(left: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 70,
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.only(left: 5.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF0090),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child:Image.asset(
                              'assets/images/hands_helping.png',fit: BoxFit.scaleDown,
                              height: 50,
                            ),
//                            Icon(FontAwesome5Solid.hands_helping, color: Colors.white,size: 35,),
//                            Image.asset('assets/images/news.png'),
                          ),
                          Text(
                            'Volunteer',
                            style: style,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Card(
              elevation: 10.0,
              color: Colors.white,
//              shadowColor: Colors.grey.withOpacity(0.4),
//              borderOnForeground: true,
              child: Container(
                height: 160,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                          height: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Let update you on preventive measures against COVID-19',
                                style: TextStyle(
                                    fontSize: 18.0, color: Color(0xff002657)),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) => Precaution()));
                                },
                                child: Container(
                                  height: 40.0,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0Xffedd7ea),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text('View here', style: style),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: double.infinity,
                        child: Image.asset('assets/images/illustrator.png',
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ),
            ),
//            headingRow(
//                leading: "Precautions",
//                trailing: "See All",
//                onTap: () {
//                  Navigator.of(context)
//                      .push(MaterialPageRoute(builder: (context) => Precaution()));
//                }),
//            Container(
//              margin: EdgeInsets.symmetric(vertical: 10.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Expanded(
//                    child: Container(
//                      margin: EdgeInsets.symmetric(horizontal: 15),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Container(
//                            height: 80,
//                            width: 80,
//                            decoration: BoxDecoration(
//                              color: Colors.white,
//                              borderRadius: BorderRadius.circular(8.0),
//                              image: DecorationImage(
//                                  image: AssetImage('assets/images/pre1.png'),
//                                  fit: BoxFit.scaleDown),
//                            ),
//                          ),
//                          Container(
//                              margin: EdgeInsets.symmetric(vertical: 15),
//                              child: Text("Wash hands \n regularly",style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1), fontSize: 12, fontWeight: FontWeight.w300),textAlign: TextAlign.center,))
//                        ],
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    child:Container(
//                      margin: EdgeInsets.symmetric(horizontal: 15),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Container(
//                            height: 70,
//                            width: 70,
//                            decoration: BoxDecoration(
//                              color: Colors.white,
//                              borderRadius: BorderRadius.circular(8.0),
//                              image: DecorationImage(
//                                  image: AssetImage('assets/images/pre6.png'),
//                                  fit: BoxFit.scaleDown),
//                            ),
//                          ),
//                          Container(
//                              margin: EdgeInsets.symmetric(vertical: 15),
//                              child: Text("Avoid raw meat or live animals",style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1), fontSize: 12, fontWeight: FontWeight.w300),textAlign: TextAlign.center,))
//                        ],
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    child:Container(
//                      margin: EdgeInsets.symmetric(horizontal: 15),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Container(height: 70,
//                            width: 70,
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: BorderRadius.circular(8.0),
//                                image: DecorationImage(
//                                    image: AssetImage('assets/images/pre2.png'),
//                                    fit: BoxFit.scaleDown)),
//                          ),
//                          Container(
//                              margin: EdgeInsets.symmetric(vertical: 15),
//                              child: Text("Do not touch your eye, mouth or nose",style: TextStyle(color: Color.fromRGBO(36, 37, 130, 1), fontSize: 12, fontWeight: FontWeight.w300),textAlign: TextAlign.center,))
//
//                        ],
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
            headingRow(
                leading: "Test Centres",
                trailing: "View All",
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Centerss( first: _first, query: "all")));
                }),
            SizedBox(height: 10.0),
//            (full)?
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for(var item in first) centerCard(item, first.indexOf(item)),
              ],
            ),
            SizedBox(height: 10.0),
//                :Container(
//              child: CardListSkeleton(
//                style: SkeletonStyle(
//                  theme: SkeletonTheme.Light,
//                  isShowAvatar: false,
//                  isCircleAvatar: false,
//                  barCount: 4,
//                ),
//              ),
//            ),
        ],
        ),
      ),
    );
  }

  Container headingRow({String leading, String trailing, Function onTap}) {
    return Container(
      margin: EdgeInsets.only(top: 30.0, left: 5.0, right: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            leading,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    trailing,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  height: 24.0,
                  width: 24.0,
                  decoration: BoxDecoration(
                    color: Color(0XFF9394C1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
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
      _fill.forEach((f)=>print(f));
      setState(() {
        _fill[i] = (_fill[i])?false:true;
      });
      _fill.forEach((f)=>print(f));
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
//                  Container(
//                    width: 55,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(8.0),
//                      image: DecorationImage(
//                          image: AssetImage(
//                              'assets/images/test_centre.png'),
//                          fit: BoxFit.fill),
//                    ),
//                  ),
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
                        _fill[i] = false;
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
          crossFadeState: _fill[i] ? CrossFadeState.showSecond:CrossFadeState.showFirst,
        ),
      ),
    ),
  );
}
}