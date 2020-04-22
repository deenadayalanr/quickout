import 'package:flutter/material.dart';
import '../admin.dart';
import '../screens/userhome.dart';
import '../database/getdata.dart';
var email;
enum AuthMode { Signup, Login }
const routeName = '/auth';
final reg = [];
List hod = [{'mail':'hod@hod.com','password':'departmenthod'}];
class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class User{
  String email;
  String password;
  User(this.email,this.password);
}
class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> authData = {
    'email': '',
    'password': '',
  };
  String response = '';
  List users = [];
  /*var name;
  var username;
  var mobilenumber;
  var email;
  var password;

  List reg=[];
*/
  


  var _isLoading = false;
  final _passwordController = TextEditingController();
  Future<void> refreshUsers()async{
        var result = await http_get_users('users');
        // print(result.data);
        if(result.ok){
          setState(() {
            users.clear();
            for(var i in result.data){
              users.add(i);
            }
            // var in_users = result.data as List<dynamic>;
            // in_users.forEach((in_users){
            //   users.add(
            //     User(
            //       in_users['email'].toString(),
            //       in_users['password']
            //     )
            //   );
            // });
          });
          
        }
      }
      createUser () async{
        // print('New login');
        var data = {
                "email": authData['email'],
                "password": authData['password']
              };
              var result = await http_post_register("create-user",data);
              if(result.ok){
                setState(() {
                  response = result.data['status'];
                });
              }
            }

  void _submit() {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
//    print(authData);
    if (_authMode == AuthMode.Login) {
      if((authData['email'] == 'hod@hod.com') && authData['password'] == 'departmenthod'){
//        print('True');
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) =>AdminState()));
      }else {
        // print('1');
        refreshUsers();
        // print(users);
        // print(authData);
        for(var user in users){
          if(user['email']==authData['email'] && user['password']==authData['password']){
            email = user['email'];
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext)=>Check(email)));
          }
        }
    }
      // Log user in
    }
    else{
      // print('Signup');
      createUser();
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext)=>Check(authData['email'])));
  //     // Sign user up
    }

  
    setState(() {
      _isLoading = false;
    });
  }

  
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
        BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    authData['email']=value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 10) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    authData['password']=value;
                  },
                ),

                if (_authMode == AuthMode.Signup)
                  SingleChildScrollView(
                    child:Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Mobile Number'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a valid mobilenumber';
                            }
                            if (value.length < 10 || value.length > 11) {
                              return "Invalid mobile number";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                    Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
