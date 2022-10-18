class Doctor {
  String dob;
  String email;
  String firstname;
  String lastname;
  String mobilenumber;
  String password;
  String certificate;

  Doctor(this.dob, this.email, this.firstname, this.lastname, this.mobilenumber,
      this.password, this.certificate);

  Map toJson() => {
        'dob': dob,
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'mobilenumber': mobilenumber,
        'password': password,
        'certificate': certificate
      };

  factory Doctor.fromJson(dynamic json) {
    return Doctor(
        json['dob'] as String,
        json['email'] as String,
        json['firstname'] as String,
        json['lastname'] as String,
        json['mobilenumber'] as String,
        json['password'] as String,
        json['certificate'] as String);
  }
}
