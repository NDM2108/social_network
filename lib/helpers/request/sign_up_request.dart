class SignUpRequest {
    SignUpRequest({
        this.firstName,
        this.lastName,
        this.email,
        this.password,
    });

    final String? firstName;
    final String? lastName;
    final String? email;
    final String? password;

    factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
    };
}
