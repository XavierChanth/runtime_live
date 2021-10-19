import 'dart:convert';

class Todo {
  String value;
  bool checked;

  Todo(this.value, {this.checked = false});

  factory Todo.fromJson(String json) {
    var data = jsonDecode(json);
    return Todo(data['value'], checked: data['checked']);
  }

  String toJson() {
    return jsonEncode({value: value, checked: checked});
  }
}
