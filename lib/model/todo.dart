class Todo {
  //https://javiercbk.github.io/json_to_dart/
  int? id;
  String? todo;
  bool? completed;
  //date
  int? userId;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    //date
    required this.userId,
  });

  //From json (Json üzerinden mappin ile dinamik olan özelliklerimizi çağrıyoruz)
  Todo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    todo = json["todo"];
    completed = json["completed"];
    userId = json["userId"];
  }

  //To json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["id"] = id;
    data["todo"] = todo;
    data["completed"] = completed;
    data["userId"] = userId;
    return data;
  }
}
