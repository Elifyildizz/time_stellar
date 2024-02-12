import 'package:time_stellar/constants/tasktype.dart';

class Task {
  Task(
      {required this.type,
      required this.title,
      required this.desc,
      required this.isCompleted});

  final TaskType type;
  final String title;
  final String desc;
  bool isCompleted;
}
