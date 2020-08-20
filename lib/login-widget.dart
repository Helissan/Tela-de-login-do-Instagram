import 'package:flutter/material.dart';
import 'package:meuapp/buttonlogin-widget.dart';
import 'package:meuapp/signup-route.dart';

class WidgetLogin extends StatefulWidget {
  @override
  _WidgetLoginState createState() => _WidgetLoginState();
}

class _WidgetLoginState extends State<WidgetLogin> {
  bool _animabutton = false;

  _onTap(){
    setState(() {
      _animabutton = !_animabutton;
    });
    
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
            height: 40,
          ),
          Text(
            "Sign in and use more features",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white,),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              labelText: "Email or username",
              filled: true,
              fillColor: Colors.white24,
              border: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              )
            ),
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
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
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            height: 20,
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
              child: ButtonWidget(
              onTap: _onTap, 
              animabutton: _animabutton
              )
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 20,
            child: FlatButton(
              color: Colors.white,
              onPressed: (null), 
              child: Text.rich(
                TextSpan(
                  text: "Forgot your login details? ",
                  style: TextStyle(fontSize: 11, color: Colors.white,),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Get help signing in",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )
                    ),
                  ],
                ),
              )
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "----------------------------   OR   -----------------------------",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white,),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 20,
            child: FlatButton.icon(
              color: Colors.white, 
              icon: Image.asset("assets/facebooklogo.jpg"),
              onPressed: (null),
              label: Text(
              "Continue with Facebook", 
              textAlign: TextAlign.center, 
              style: TextStyle(fontSize: 11, color: Colors.white),
              )
            ),
          ),
           SizedBox(
            height: 50,
          ),
          Container(
            height: 20,
            child: FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupRoute()));
              }, 
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(fontSize: 11, color: Colors.white,),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Sign up.",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )
                    ),
                  ],
                ),
              )
            ),
          ),
        ]
      ),
    )
  );
}
}