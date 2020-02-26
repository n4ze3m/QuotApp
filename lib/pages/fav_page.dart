import 'package:flutter/material.dart';
import '../database/db.dart';
import '../models/quotes.dart';

class FavSqlPage extends StatefulWidget {
  FavSqlPage({Key key}) : super(key: key);

  @override
  _FavSqlPageState createState() => _FavSqlPageState();
}

class _FavSqlPageState extends State<FavSqlPage> {
  final dbHelper = DatabaseHelper.instance;
  List<QuotesDb> items = new List();

  @override
  void initState() { 
    super.initState();
    dbHelper.queryAllRows().then((rows){
      setState(() {
        rows.forEach((row) {
        items.add(QuotesDb.fromMap(row));
      });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          backgroundColor:Color(0xff2D294A),
          leading: IconButton(icon: Icon(Icons.navigate_before), onPressed: () => Navigator.pop(context)),
        title: Text("Favorite ❤"),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor:  Theme.of(context).primaryColor,
      body: items.isEmpty ? _empyNothing() :ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (BuildContext context, int index) {
        return _theSavedData(index);
       },
      ),
    );
  }
  Widget _empyNothing(){
    return Center(
      child: Container(
        child: Text('😝Whoops! empty',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white54,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
    );
  }
  Widget _theSavedData(index){
     return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[index].quote}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        '${items[index].author}',
                        style: new TextStyle(
                          fontSize: 13.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child:  Column(
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Color(0xFF00FFFF),
                              tooltip: 'Remove',
                              onPressed: () => _deleteNote(context, items[index], index)),
                        ],
                      )
                    ),
                   
                  ],
                );
  }
  void _deleteNote(BuildContext context, QuotesDb row, int position) async {
    dbHelper.delete(row.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
}