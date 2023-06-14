class User {
  String name;
  String email;
  String phoneNumber;
  int createdAcres;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.createdAcres,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        createdAcres = json['createdAcres'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAcres': createdAcres,
    };
  }
}