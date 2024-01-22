class UserModel {
  String? uid;
  String? name;
  String? bio;
  String? email;
  String? profilepic;

  UserModel({this.uid, this.name, this.bio, this.email, this.profilepic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    name = map['name'];
    bio = map['bio'];
    email = map['email'];
    profilepic = map['profilepic'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'bio': bio,
      'email': email,
      'profilepic': profilepic
    };
  }
}
