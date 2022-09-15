import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
var data;
Future<void> getuserApi()async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if(response.statusCode == 200){
    data = jsonDecode(response.body);
  }else{

  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Four Api Tutorial'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getuserApi(),
                builder: (context, snapshot){

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Text('Loading');
                }else{
                  return ListView.builder(
                      itemBuilder: (context, index){
                        return Card(
                          child: Column(
                            children: [
                              ReusableRow(title: 'Name', value: data[index]['name'].toString()),
                              ReusableRow(title: 'UserName', value:data[index]['username'].toString()),
                              ReusableRow(title: 'Address', value: data[index]['address']['street'].toString()),
                              ReusableRow(title: 'Geo Lat', value: data[index]['address']['geo']['lat'].toString()),
                              ReusableRow(title: 'Geo Lang', value: data[index]['address']['geo']['lng'].toString())

                            ],
                          ),
                        );
                      });

                }
                }),
          )
        ],
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title, value ;
  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
