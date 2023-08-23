import 'dart:convert';

class UserModal {
  String userName;
  String userProfession;

  UserModal({
    required this.userName,
    required this.userProfession,
  });
}

class TodoModal {
  String title;
  String description;
  String targetDate;
  String targetTime;

  TodoModal({
    required this.title,
    required this.description,
    required this.targetDate,
    required this.targetTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'targetDate': targetDate,
      'targetTime': targetTime,
    };
  }

  factory TodoModal.fromMap(Map<String, dynamic> map) {
    return TodoModal(
      title: map['title'],
      description: map['description'],
      targetDate: map['targetDate'],
      targetTime: map['targetTime'],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory TodoModal.fromJson(String source) {
    return TodoModal.fromMap(jsonDecode(source));
  }
}

UserModal userModal = UserModal(
  userName: "userName",
  userProfession: "userProfession",
);

List<TodoModal> listOfTodo = [];
