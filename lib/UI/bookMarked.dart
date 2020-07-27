import 'file:///C:/Users/aditya/AndroidStudioProjects/credicxo_intern/lib/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:credicxo_intern/UI/trackinfo_page.dart';
class BookMarked extends StatefulWidget {
  @override
  _BookMarkedState createState() => _BookMarkedState();
}

class _BookMarkedState extends State<BookMarked> {
  Future _future;
  List TrackId=[];
  List TrackName=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future=findBookMarked(context);
    //findBookMarked();
  }
 Future<List> findBookMarked(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     final prefKeys =  prefs.getKeys();
    for(String i in prefKeys){
      TrackId.add(i);
      TrackName.add(await prefs.get(i));
    }
    print(TrackName);
    return TrackName;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        title: Text("Book Marked Tracks"),
      ),
      body: FutureBuilder(
        future: _future,
        builder:(context,snapshot){

         if(snapshot.hasData){
           return ListView.builder(
             itemCount: snapshot.data.length,
             itemBuilder: (context,index){
               return Card(
                 margin: EdgeInsets.all(10),
                 elevation: 5,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

                 child: Container(
                   

                   decoration: dec,
                   child: ListTile(
                     onTap: (){
                       print("${TrackId[index]}");
                       Navigator.push(context, MaterialPageRoute(builder: (context) =>
                           TrackInfo(trackId: TrackId[index])));
                     },
                     title: Text("${TrackName[index]}",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                   ),
                 ),
               );
             },
           );
         }
         return CircularProgressIndicator();
        },
      ),
    );
  }
}
