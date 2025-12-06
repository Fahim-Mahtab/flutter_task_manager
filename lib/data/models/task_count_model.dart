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

class TaskCountModel {
  final String id;
  final int sum;

  TaskCountModel({required this.id, required this.sum});
  factory TaskCountModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskCountModel(id: jsonData["_id"], sum: jsonData["sum"]);
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
