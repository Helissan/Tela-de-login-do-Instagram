class Users{
  int ind;
  String email;
  String name;
  String username;
  String password;

  Users(this.ind, this.email, this.name, this.username, this.password);

  Map<String,dynamic> toMap(){

    var map = <String,dynamic> {
      'ind' : ind,
      'email' : email,
      'name' : name,
      'username' : username,
      'password' : password,
    };

    return map;
  }

  Users.fromMap(Map<String,dynamic> map){
    ind = map['ind'];
    email = map['email'];
    name = map['name'];
    username = map['username'];
    password = map['password'];
  }
}