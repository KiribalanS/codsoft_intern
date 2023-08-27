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
  String startTime;
  String targetTime;
  String startDate;
  String targetDate;
  double progress;

  TodoModal({
    required this.title,
    required this.description,
    required this.targetDate,
    required this.startDate,
    required this.targetTime,
    required this.startTime,
    this.progress = 0.1,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'targetDate': targetDate,
      'targetTime': targetTime,
      'startDate': startDate,
      'startTime': startTime,
      'progress': progress,
    };
  }

  factory TodoModal.fromMap(Map<String, dynamic> map) {
    return TodoModal(
      title: map['title'],
      description: map['description'],
      targetDate: map['targetDate'],
      targetTime: map['targetTime'],
      startDate: map['startDate'],
      startTime: map['startTime'],
      progress: map['progress'],
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
List<TodoModal> listOfFinishedTodo = [];
