class UserModel
{
  final String? id;
  final String name;
  final String email;
  final String password;


const UserModel({
  this.id,
  required this.email,
  required this.password,
  required this.name
});

toJson(){
  return {
    "Name":name,
    "Email":email,
    "Password":password
  };
}
}