import 'package:api/edit_page.dart';
import 'package:api/form_page.dart';
import 'package:api/information_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List mapResponse = <dynamic>[];
  String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  getTodo() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = convert.jsonDecode(response.body) as List<dynamic>;
      });
    } else {
      return null;
    }
  }

  deleteTodo(var object) async {
    var url = Uri.parse('$baseUrl/${object["id"]}');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
              'Successfully Deleted!')));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: (
        ListView.builder(
          itemCount: mapResponse.length,
          itemBuilder: (context, index){
            return Card(
              shadowColor: Colors.black,
              child: ListTile(
                title: Text('Title: ${mapResponse[index]['title']}'),
                leading: IconButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPage(todo: mapResponse[index])
                          )
                      );
                    },
                    icon: const Icon(Icons.edit)
                ),
                trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        deleteTodo(mapResponse[index]);
                        mapResponse.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete)),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InformationPage(
                              todo: mapResponse[index]
                          )
                      )
                  );
                },
              ),
            );
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var info = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormPage()
              )
          );
          setState(() {
            mapResponse.add(info);
          });
        }
      ),
    );
  }
}
