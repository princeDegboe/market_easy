// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.fullName,
    required this.username,
    required this.role,
    required this.password,
    required this.email,
    required this.imageUrl,
    this.nationality,
    this.birthday,
    this.idCardPath,
    this.tel,
  });
  String id;
  String fullName;
  String username;
  int role;
  String password;
  String email;
  String imageUrl;
  String? nationality;
  String? birthday;
  String? idCardPath;
  String? tel;

  UserModel copyWith({
    String? id,
    String? fullName,
    String? username,
    int? role,
    String? password,
    String? email,
    String? imageUrl,
    String? nationality,
    String? birthday,
    String? idCardPath,
    String? tel,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      role: role ?? this.role,
      password: password ?? this.password,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      nationality: nationality ?? this.nationality,
      birthday: birthday ?? this.birthday,
      idCardPath: idCardPath ?? this.idCardPath,
      tel: tel ?? this.tel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'username': username,
      'role': role,
      'password': password,
      'email': email,
      'imageUrl': imageUrl,
      'nationality': nationality,
      'birthday': birthday,
      'idCardPath': idCardPath,
      'tel': tel,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      username: map['username'] as String,
      role: map['role'] as int,
      password: map['password'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      nationality:
          map['nationality'] != null ? map['nationality'] as String : null,
      birthday: map['birthday'] != null ? map['birthday'] as String : null,
      idCardPath:
          map['idCardPath'] != null ? map['idCardPath'] as String : null,
      tel: map['tel'] != null ? map['tel'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, username: $username, role: $role, password: $password, email: $email, imageUrl: $imageUrl, nationality: $nationality, birthday: $birthday, idCardPath: $idCardPath, tel: $tel)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.username == username &&
        other.role == role &&
        other.password == password &&
        other.email == email &&
        other.imageUrl == imageUrl &&
        other.nationality == nationality &&
        other.birthday == birthday &&
        other.idCardPath == idCardPath &&
        other.tel == tel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        username.hashCode ^
        role.hashCode ^
        password.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        nationality.hashCode ^
        birthday.hashCode ^
        idCardPath.hashCode ^
        tel.hashCode;
  }
}
