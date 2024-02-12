import 'dart:convert';

import 'package:time_stellar/model/todo.dart';
import 'package:http/http.dart' as http;

class TodoService {
  final String url = "https://dummyjson.com/todos/";

  //Respond time ve asenkron
  Future<List<Todo>> getUncompletedTodos() async {
    final response = await http.get(Uri.parse(url));
    List<dynamic> resp = jsonDecode(response.body)["todos"];
    List<Todo> todos = List.empty(growable: true);

    resp.forEach((element) {
      Todo task = Todo.fromJson(element);
      if (task.completed! == false) {
        todos.add(task);
      }
    });

    return todos;
  }

  Future<List<Todo>> getCompletedTodos() async {
    final response = await http.get(Uri.parse(url));
    List<dynamic> resp = jsonDecode(response.body)["todos"];
    List<Todo> todos = List.empty(growable: true);

    resp.forEach((element) {
      Todo task = Todo.fromJson(element);
      if (task.completed! == true) {
        todos.add(task);
      }
    });

    return todos;
  }
}
