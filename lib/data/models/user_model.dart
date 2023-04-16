class UserModel {
  String? uid, name, email, phone, gender, photo, coverPhoto;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phone,
      required this.gender,
      required this.photo,
      required this.coverPhoto});

  UserModel.fromJson(Map<String, dynamic>? json) {
    uid = json?['userId'];
    name = json?['userName'];
    email = json?['userEmail'];
    phone = json?['userPhone'];
    gender = json?['userGender'];
    photo = json?['userPhoto'];
    coverPhoto = json?['coverPhoto'];
  }

  Map<String, dynamic> toMap() => {
        'userId': uid,
        'userName': name,
        'userEmail': email,
        'userPhone': phone,
        'userGender': gender,
        'userPhoto': photo,
        'coverPhoto': coverPhoto,
      };
}
