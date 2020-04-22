import 'package:flutter/material.dart';
import '../auth/auth_screen.dart';
import './studentresponse.dart';
import './form.dart';


class Check extends StatelessWidget {
  final email;
  Check(this.email);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quickout'),
          actions: <Widget>[GestureDetector(child: Icon(Icons.exit_to_app),onTap: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>AuthScreen())),),],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),

                color: Colors.black,
                child: Text("Outpass Request",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Home(email)));
                  },
          ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),

                color: Colors.black,
                child: Text("Outpass Response",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Stud(email)));
                },
              ),
          ],
          ),
        ),
      ),
    );
  }
}
