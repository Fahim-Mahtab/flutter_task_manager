/*
{
"status": "success",
"data": [
{
"_id": "673cc6cfea7d73dfecf573eb",
"title": "A",
"description": "v",
"status": "New",
"email": "email@gmail.com",
"createdDate": "2024-11-01T12:20:25.564Z"
},*/
import 'package:intl/intl.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String createdDate;
  final String email;

  TaskModel({
    required this.id,
    required this.email,
    required this.title,
    required this.description,
    required this.status,
    required this.createdDate,
  });
  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      id: jsonData["_id"],
      email: jsonData["email"],
      title: jsonData["title"],
      description: jsonData["description"],
      status: jsonData["status"],
      createdDate: DateFormat().format(DateTime.parse(jsonData["createdDate"])),
    );
  }
  /*Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "title": title,
      "description": description,
      "status": status,
    };
  }*/
}
