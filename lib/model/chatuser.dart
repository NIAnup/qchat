class Chatuser {
  late final String id;
  late final String email;
  late final String name;
  late final String bio;
  late final String image;
  late final String createdDate;
  late final bool isOnline;
  late final String pushToken;
  late final String lastActive;

  Chatuser({
    required this.id,
    required this.email,
    required this.name,
    required this.bio,
    required this.image,
    required this.createdDate,
    required this.isOnline,
    required this.pushToken,
    required this.lastActive,
  });

  Chatuser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    bio = json['bio'];
    image = json['image'];
    createdDate = json['created_date'];
    isOnline = json['is_online'];
    pushToken = json['push_token'];
    lastActive = json['last_active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['name'] = name;
    _data['bio'] = bio;
    _data['image'] = image;
    _data['created_date'] = createdDate;
    _data['is_online'] = isOnline;
    _data['push_token'] = pushToken;
    _data['last_active'] = lastActive;
    return _data;
  }

  // Future<void> creatinguser()async{
  //   final chatuser =Chatuser(id: id, email: email, name: name, bio: bio, image: image, createdDate: createdDate, isOnline: isOnline, pushToken: pushToken, lastActive: lastActive)
  // }
}
