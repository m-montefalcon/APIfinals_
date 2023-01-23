import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPage extends StatefulWidget {

  final dynamic todo;
  const EditPage({required this.todo, Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  var formKey = GlobalKey <FormState>();
  TextEditingController titleController = TextEditingController();
  String? completed;
  var id = '';
  var check;

  @override
  void initState() {
    id = widget.todo["id"].toString();
  }

  editInformation() async {
    var newTitle = titleController.text;
    var url = Uri.parse('$baseUrl/$id');
    var Data = json.encode({
      'title': newTitle,
    });
    var response = await http.patch(url, body: Data);
    if (response.statusCode == 200) {
      print('\nSuccessfully edited ToDo id: $id!');
      var display = response.body;
      print(display);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Card(
                child: TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                      hintText: 'e.g Ang Probinsyano'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title!';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (check != titleController.text){
                        await editInformation();
                        Navigator.pop(context,check);
                      }else{
                        return null;
                      }
                    }else{
                      return null;
                    }
                  },
                  child: const Text('Submit'))
            ],
          )
        ),
      ),
    );
  }
}
