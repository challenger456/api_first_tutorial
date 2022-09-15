import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({Key? key}) : super(key: key);

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {

  List<Photos> photosList = [];



  Future<List<Photos>> getPhotos ()async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
   var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id'], thumbnailUrl: i['thumbnailUrl']);
        photosList.add(photos);
      }
      return photosList;
    }else{
      return photosList;
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Second Api Tutorial'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(

              future: getPhotos(),

                builder: (context, AsyncSnapshot<List<Photos>> snapshot){
                  return ListView.builder(
                    itemCount: photosList.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(photosList[index].url),
                              ),
                              title: Text(photosList[index].title.toString()),
                              subtitle: Text('NOTES ID: '+photosList[index].id.toString()),
                            ),
                            Image(


                                image: NetworkImage(photosList[index].thumbnailUrl)
                            ),
                          ],
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}


class Photos{
  String title , url ,thumbnailUrl;
  int id;
  Photos({required this.title, required this.url, required this.id, required this.thumbnailUrl});
}