import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/PostsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    List<PostsModel> postList = [] ;
  Future<List<PostsModel>> getPostApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Api Tutorial'),
        centerTitle: true,
      ),
      body: Column(
        children: [
Expanded(
  child:   FutureBuilder(
    future: getPostApi(),
      builder: (context, snapshots){
        if(!snapshots.hasData){
          return Image(

              image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/c/c7/Loading_2.gif?20170503175831'));
        }else{
          return ListView.builder(
            itemCount: postList.length,
              itemBuilder: (context, index){
  
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Id\n\n'+postList[index].id.toString()),
                        SizedBox(height: 15,),
                        Text('Title\n\n'+postList[index].title.toString()),
                        SizedBox(height: 15,),
                        Text('Description\n\n'+postList[index].body.toString())

                      ],
                    ),
                  ),
                );
              }
          );
        }
      }
  ),
)
        ],
      ),
    );
  }
}
