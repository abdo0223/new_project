class User {
  final String userId, email;
  String idToken, refreshToken;
  DateTime expiryDate;

  User.fromJson(dynamic json)
      : this.userId = json['localId'],
        this.email = json['email'],
        this.idToken = json['idToken'],
        this.refreshToken = json['refreshToken'],
        this.expiryDate =
            DateTime.now().add(Duration(seconds: int.parse(json['expiresIn'])));
}
