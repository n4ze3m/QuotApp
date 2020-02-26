import 'package:flutter/material.dart';
import 'pages/fav_page.dart';
import 'pages/v_page.dart';
import 'components/iconButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'database/db.dart';

class QHomeScreen extends StatefulWidget {
  QHomeScreen({Key key}) : super(key: key);

  @override
  _QHomeScreenState createState() => _QHomeScreenState();
}

class _QHomeScreenState extends State<QHomeScreen> {
  final dbHelper = DatabaseHelper.instance;
  int currentTabSelected = 0;
  List data = [];
  var randomQt;
  var intx;

  final List<IconData> bottomBarIcons = [
    Icons.home,
    FontAwesomeIcons.bookmark,
    Icons.info
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assests/json/ins.json'),
       builder: (context, snapshot){
          if(!snapshot.hasData){
           return _theLoader();
         }
         
         randomQt = json.decode(snapshot.data.toString());
         var range = new Random();
         intx = range.nextInt(randomQt.length);
         return  Stack(
        children: <Widget>[
          _theBody(intx),
          Align(child: _footerBar(),
            alignment: Alignment.bottomCenter,
          )
        ],
      );
      }
      ),
    );
  }
Widget _theLoader() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    );
  }
  Widget _theBody(index) {
    return Column(children: <Widget>[
      Container(
        height: 280,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xff682CFC),
            Color(0xffB730F9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 48,
                      bottom: 42,
                      left: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text:  TextSpan(text:randomQt[index]['quoteText'],
                        style: TextStyle(
                            fontSize: 20,
                          color:Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                           children: <TextSpan>[
                            TextSpan(
                              text: "\n"+randomQt[index]['quoteAuthor'],
                               style: TextStyle(
                       fontFamily: 'NunitoSans',
                            fontSize: 15,
                          color:Colors.white,
                         fontStyle: FontStyle.italic
                          ),
                            )
                        ]
                        )
                       
                        )
                      
                      ],
                    ),
                  )),
                  
            ],
          ),
        ),
      ),
      Expanded(
          child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 20,
              ),
              child: Text(
                "Motivation hub",
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ActionButton(
                icon:FontAwesomeIcons.heart,
                onTap: () async{
                  Map<String, dynamic> row = {
      DatabaseHelper.columnquote : randomQt[intx]['quoteText'],
      DatabaseHelper.columnAuthor : randomQt[intx]['quoteAuthor']  
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
                },
              ),
              ActionButton(
                  icon: FontAwesomeIcons.copy,
                  onTap: () async{
                    final data = ClipboardData(
                      text: randomQt[intx]['quoteText']+'\n'+randomQt[intx]['quoteAuthor'],
                    );
                    Clipboard.setData(data);
                  }),
                  
              ActionButton(
                  icon: Icons.format_quote,
                  onTap: () {
                   setState(() {
             var range = new Random();
             intx = range.nextInt(randomQt.length);
                   });
                  })
            ],
          ))
          ],
        ),
      )),
      
    ]);
  }

  Widget _footerBar() {
    return Card(
      color: Color(0xff2D294A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36),)),
      margin: EdgeInsets.all(16),
      child: Padding(
         padding: const EdgeInsets.symmetric(vertical: 6,),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: IconButton(icon: Icon(bottomBarIcons[0],
                color: currentTabSelected == 0 ? Color(0xFFFF009D) : Color(0xff757495),
              ), onPressed: () {
                
              }),
            ),
            Expanded(
              child: IconButton(icon: Icon(bottomBarIcons[1],
                color: currentTabSelected == 1 ? Colors.pink : Color(0xff757495),
              ), onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => FavSqlPage()));
              }),
            ),
            Expanded(
              child: IconButton(icon: Icon(bottomBarIcons[2],
                color: currentTabSelected == 2 ? Colors.pink : Color(0xff757495),
              ), onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(),));
              }),
            ),
          ],
         ),
      ),
    );
  }
}
