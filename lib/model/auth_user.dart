UserAuthentication toMap(Map<String, dynamic> map) =>
    UserAuthentication.fromMap(map);

class UserAuthentication {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;

  UserAuthentication({this.uid, this.email, this.firstName, this.lastName});

// Convert object to map to ask server to save
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  // Data from server
  factory UserAuthentication.fromMap(Map<String, dynamic> map) =>
      UserAuthentication(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
      );
}
