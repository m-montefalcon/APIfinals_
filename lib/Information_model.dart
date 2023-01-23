import 'dart:convert';

InformationModel todoModelFromJson(String str) => InformationModel.fromJson(json.decode(str));

String todoModelToJson(InformationModel data) => json.encode(data.toJson());

class InformationModel {
  InformationModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  int? userId;
  int? id;
  String? title;
  bool? completed;

  factory InformationModel.fromJson(Map<String, dynamic> json) => InformationModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}
