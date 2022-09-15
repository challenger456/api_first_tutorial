import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/ProductsModel.dart';

class LastExampleScreen extends StatefulWidget {
  const LastExampleScreen({Key? key}) : super(key: key);

  @override
  State<LastExampleScreen> createState() => _LastExampleScreenState();
}

class _LastExampleScreenState extends State<LastExampleScreen> {


  Future<ProductsModel> getProductApi()async{
    final response = await http.get(Uri.parse('https://webhook.site/5ff8451f-7678-472e-aedb-5aed902eddf3'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }else{
      return ProductsModel.fromJson(data);

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Five Tutorial'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductsModel>(
                future: getProductApi(),
                  builder:(context, snapshot){

                  if(snapshot.hasData){

                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                height: MediaQuery.of(context).size.height *.3,
                                width: MediaQuery.of(context).size.width *1,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.data![index].products![index].images!.length,
                                    itemBuilder: (context, position){
                                      return Container(
                                        height: MediaQuery.of(context).size.height *.25,
                                        width: MediaQuery.of(context).size.width *.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot.data!.data![index].products![index].images![position].url.toString())
                                          )
                                        ),

                                      );

                                    }),
                              ),
                            ],
                          );
                        });
                  }else{
                    return Center(
                        child: Container(
                            height: 20,

                            child: LinearProgressIndicator()));
                  }

                  },),
            )

          ],
        ),
      ),
    );
  }
}

