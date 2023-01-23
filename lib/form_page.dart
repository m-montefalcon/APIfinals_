import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Information_model.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

Future<InformationModel?> submitData(String id, String userId, String title, String status) async {
  var url = Uri.parse(baseUrl);
  var bodyData = json.encode({
    'id':id,
    'userId':userId,
    'title': title,
    'completed': status});
  var response = await http.post(url, body: bodyData);



  if (response.statusCode == 201) {
    print('Successfully added ToDo!');
    var display = response.body;
    print(display);

    String todoResponse = response.body;
    todoModelFromJson(todoResponse);
  } else {
    return null;
  }
}

class _FormPageState extends State<FormPage> {

  InformationModel? todoModel;
  var formKey = GlobalKey <FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  String? status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(
                  hintText: 'Example: 1',
                  labelText: 'ID'
                ),
                validator: (value){
                  return value == null || value.isEmpty ? 'Input Name' : null;
                },
              ),
              TextFormField(
                controller: userIdController,
                decoration: const InputDecoration(
                  hintText: 'Example: 2',
                  labelText: 'User ID'
                ),
                validator: (value){
                  return value == null || value.isEmpty ? 'Input Section' : null;
                },
              ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: 'Example: Ang Probinsyano',
                    labelText: 'Title'
                ),
                validator: (value){
                  return value == null || value.isEmpty ? 'Input Section' : null;
                },
              ),
              DropdownButtonFormField(
                hint: const Text('Status'),
                  items: const [
                    DropdownMenuItem(
                      value: 'True',
                      child: Text('True')
                    ),
                    DropdownMenuItem(
                      value: 'False',
                      child: Text('False')
                    )
                  ],
                  onChanged: (value){
                    setState(() {
                      status = value;
                    });
                  }
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async{
                    if (formKey.currentState!.validate()) {
                      InformationModel? data = await submitData(
                          idController.text,
                          userIdController.text,
                          titleController.text,
                          status.toString()
                      );
                      setState(() {
                        todoModel = data;
                      });
                    } else {
                      return null;
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Submit')
              )
            ],
          )
        ),
      ),
    );
  }
}
