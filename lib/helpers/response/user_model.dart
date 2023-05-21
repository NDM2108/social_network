class UserModel {
  String? token;
  User? user;

  UserModel({
    this.token,
    this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? picturePath;
  List<String>? friends;
  int? viewedProfile;
  int? impressions;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.picturePath,
    this.friends,
    this.viewedProfile,
    this.impressions,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        picturePath: json["picturePath"],
        friends: json["friends"] == null ? [] : List<String>.from(json["friends"]!.map((x) => x)),
        viewedProfile: json["viewedProfile"],
        impressions: json["impressions"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "picturePath": picturePath,
        "friends": friends == null ? [] : List<dynamic>.from(friends!.map((x) => x)),
        "viewedProfile": viewedProfile,
        "impressions": impressions,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
