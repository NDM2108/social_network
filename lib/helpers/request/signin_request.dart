class SignInRequest {
  SignInRequest({
    this.email,
    this.password,
  });
  final String? email;
  final String? password;

  factory SignInRequest.fromJson(Map<String, dynamic> json) => SignInRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
