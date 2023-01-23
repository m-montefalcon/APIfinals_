import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {

  final dynamic todo;
  const InformationPage({required this.todo,Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do Details"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              child: Row(
                children: [
                  const Expanded(
                  flex: 3,
                    child: Text("ID"),
                  ),
                  const SizedBox(width: 5),
                  Text(widget.todo["id"].toString())
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Text("User ID"),
                  ),
                  const SizedBox(width: 5),
                  Text(widget.todo["userId"].toString())
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Text("Title"),
                  ),
                  const SizedBox(width: 5),
                  Text(widget.todo["title"].toString())
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Text("Completed"),
                  ),
                  const SizedBox(width: 5),
                  Text(widget.todo["completed"].toString())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
