class User {
  User({this.id, this.nickName, this.email, this.podRole, this.groupRole});
  final String id;
  final String nickName;
  final String email;
  final List<String> podRole;
  final List<String> groupRole;
  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        nickName = data['nickName'],
        email = data['email'],
        podRole = data['podRole'],
        groupRole = data['groupRole'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickName': nickName,
      'email': email,
      'podRole': podRole,
      'groupRole': groupRole,
    };
  }
}
