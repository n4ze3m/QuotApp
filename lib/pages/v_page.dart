import 'package:flutter/material.dart';


class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor:Color(0xff2D294A),
          leading: IconButton(icon: Icon(Icons.navigate_before), onPressed: () => Navigator.pop(context)),
        title: Text("About 😝"),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor:  Theme.of(context).primaryColor,
      body: SafeArea(
        child: ListView(
           children: <Widget>
           [
             SizedBox(height: 25.0,),
              Center(
              child: Container(
                height: 150,
                child: Image.asset('assests/icon/icon.png'),
              )),
              Padding(
              padding: const EdgeInsets.all(16.0),
              child:  Center(
                child: RichText(
                            text:  TextSpan(text:'QutApp 1.0',
                          style: TextStyle(
                              fontSize: 20,
                         fontFamily: 'Pacifico',
                            color:Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                             children: <TextSpan>[
                              TextSpan(
                                text: "\n"+'from DuoTres just for fun',
                                
                                 style: TextStyle(
                         fontFamily: 'NunitoSans',
                              fontSize: 10,
                            color:Colors.white54,
                           fontStyle: FontStyle.italic
                            ))
                              ,
                            
                          ]
                          )
                         
                          ),
              ),
            ),
           ]
        )
      ),
    );
  }
}