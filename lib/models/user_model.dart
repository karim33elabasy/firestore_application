class UserModel {
  final String name;
  final String age;
  final String hobby;
  UserModel({required this.name, required this.age, required this.hobby});

  Map<String,dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'hobby': hobby,
    };
  }

  factory UserModel.fromJson(var json) {
    return UserModel(
      name: json['name'],
      age: json['age'],
      hobby: json['hobby'],
    );
  }

 }