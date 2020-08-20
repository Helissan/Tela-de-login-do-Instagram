import 'package:flutter/material.dart';
import 'package:meuapp/models/users.dart';

class Userpage extends StatefulWidget {

  final Users users;

  const Userpage({Key key, this.users}) : super(key: key);

  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool edited = false;
  
  Users editUsers;

  @override
  void initState() {
    super.initState();

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

  void _exibeAlerta(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Informação"),
          content: new Text("Informe a informação que falta para o usuário"),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: new Text("Fechar"),
              )
          ],
        );
      }
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(editUsers != null){
            Navigator.pop(context, editUsers);
          }else{
            _exibeAlerta();
          }
        },
        child: Icon(Icons.save, color: Colors.black,),
        backgroundColor: Colors.white,
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                ),
                style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white),
                onChanged: (text){
                  edited = true;
                  editUsers.username = text;
                },
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white),
                onChanged: (text){
                  edited = true;
                  editUsers.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                ),
                style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white),
                onChanged: (text){
                  edited = true;
                  editUsers.name = text;
                },
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white),
                onChanged: (text){
                  edited = true;
                  editUsers.password = text;
                },
              )
          ]
        ),
      ),
    );
  }
}