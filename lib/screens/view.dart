import 'package:flutter/material.dart';
import '../screens/userhome.dart';

class Display extends StatefulWidget {
  final email;
  Display(this.email);
  @override
  _DisplayState createState() => _DisplayState();
}


class _DisplayState extends State<Display> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("quickout"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200.0,
              width: 200.0,
              child: Text("Your request has been sent Successfully",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ButtonTheme(
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.0),
                ),
                child: Text("Home",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.amber
                ),),
                color: Colors.black,
                onPressed: () {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) =>Check(widget.email)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
