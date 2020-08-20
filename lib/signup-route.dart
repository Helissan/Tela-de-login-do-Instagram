import 'package:flutter/material.dart';
import 'package:meuapp/helpers/database-helper.dart';
import 'package:meuapp/models/users.dart';
import 'package:meuapp/showusers.dart';

class SignupRoute extends StatefulWidget {

  final Users users;

  const SignupRoute({Key key, this.users}) : super(key: key);
  
  @override
  _SignupRouteState createState() => _SignupRouteState();
}

class _SignupRouteState extends State<SignupRoute> {

  DatabaseHelper database = DatabaseHelper();
  List<Users> users = List<Users>();


  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool edited = false;
  Users editUsers;

  @override
  void initState() {
    super.initState();

    database.getUsers().then((lista){
      setState(() {
        users = lista;
      });
    });

    if(widget.users == null) {
      editUsers = Users(null, '', '', '', '');
    }else{
      editUsers = Users.fromMap(widget.users.toMap());

      _usernameController.text = editUsers.username;
      _emailController.text = editUsers.email;
      _nameController.text = editUsers.name;
      _passwordController.text = editUsers.password;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
      padding: EdgeInsets.only(top: 60, left: 40, right: 40),      
      child: ListView(
        children: <Widget>[  
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset("assets/instagramname.png"),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Sign up to see photos and videos from your friends",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white,),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 20,
            child: FlatButton.icon(
              color: Colors.white, 
              icon: Image.asset("assets/facebooklogo.jpg"),
              onPressed: (null),
              label: Text(
              "Log in with Facebook", 
              textAlign: TextAlign.center, 
              style: TextStyle(fontSize: 11, color: Colors.white),
              )
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "----------------------------   OR   -----------------------------",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white,),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              labelText: "Mobile Number or Email",
              filled: true,
              fillColor: Colors.white24,
              border: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              )
            ),
            onChanged: (text){
              edited = true;
              editUsers.email = text;
            },
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              labelText: "Full Name",
              filled: true,
              fillColor: Colors.white24,
              border: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              )
            ),
            onChanged: (text){
              edited = true;
              editUsers.name = text;
            },
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              labelText: "Username",
              filled: true,
              fillColor: Colors.white24,
              border: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              )
            ),
            onChanged: (text){
              edited = true;
              editUsers.username = text;
            },
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _passwordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              labelText: "Password",
              filled: true,
              fillColor: Colors.white24,
              border: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              )
            ),
            onChanged: (text){
              edited = true;
              editUsers.password = text;
            },
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Container( 
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.01, 1],
                colors: [
                  Color(0xFFFF9900),
                  Color(0xFF993399)
                ]
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
            ),
            child: SizedBox.expand(
              child: FlatButton(
                onPressed:() async {
                  if(editUsers.username != null && editUsers.username.isNotEmpty && 
                  editUsers.email != null && editUsers.email.isNotEmpty &&
                  editUsers.name != null && editUsers.name.isNotEmpty &&
                  editUsers.password != null && editUsers.password.isNotEmpty && editUsers !=null){
                    await database.insertUsers(editUsers);
                    
                    
            }
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowUsers(editUsers)));
                
              }, child: Text(
              "Sign up", 
              textAlign: TextAlign.center, 
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white
                ),
              ),
              )
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "By signing up, you agree to our Terms, Data Policy and Cookies Policy.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white,),
          ),
        ]
      )
    )
    );
  }
}