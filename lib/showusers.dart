import 'package:flutter/material.dart';
import 'package:meuapp/helpers/database-helper.dart';
import 'package:meuapp/models/users.dart';
import 'package:meuapp/user-page.dart';

class ShowUsers extends StatefulWidget {
  ShowUsers(Users editUsers);

  @override
  _ShowUsersState createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  
  DatabaseHelper database = DatabaseHelper(); 

  List<Users> users = List<Users>();

  void _exibeTodosUsers(){  
    database.getUsers().then((lista){
      setState(() {
        users = lista;
      });
    });
  }

  void exibeUsersPage({Users users}) async {
    final userRecebido = await Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => Userpage(users: users)
      ),
      );

      if(userRecebido != null){
        if (users != null){
          await database.updateUsers(userRecebido);
        }else{
          await database.insertUsers(userRecebido);
        }
        _exibeTodosUsers();
      }
  }
  
  void _confirmaExclusao(BuildContext context, int usersind, ind){
    showDialog(context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir usuário"),
          content: Text("Confirmar a exclusão do usuário"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: Text("Cancelar"),
              ),
            FlatButton(
              onPressed: () {
                setState(() {
                  users.removeAt(ind);
                  database.deleteUsers(usersind);
                });
                Navigator.of(context).pop();
              }, 
              child: Text("Excluir"),
            )
          ],
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();

  _exibeTodosUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: users.length,
        itemBuilder: (context, ind){
          return _listaUsers(context, ind);
        }
        ),
    );
  }

  _listaUsers(BuildContext context, int ind) {
        return GestureDetector(
          child: Card( 
            child: Padding(
              padding: EdgeInsets.all(10),         
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("User: " + users[ind].username ?? "",
                        style: TextStyle(fontSize: 20),
                        ),
                        Text("Email: "+ users[ind].email ?? "",
                        style: TextStyle(fontSize: 14),
                        ),
                        Text("Full Name: " + users[ind].name ?? "",
                        style: TextStyle(fontSize: 14),
                        ),
                        Text("Password: " + users[ind].password ?? "",
                        style: TextStyle(fontSize: 14),
                        ),
                      ]
                    )
                  ),
                  IconButton(
                    icon: Icon(Icons.delete), 
                    onPressed: () {
                      _confirmaExclusao(context, users[ind].ind, ind);
                    }
                  )
            ],
          )
      ),
      ),
      onTap: () {
          exibeUsersPage(users: users[ind]);
      },
      );
  }
}