import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'food.dart';


void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {




  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String countryname, message;
  late bool error;
  var data;

  String mgdh ='https://mgdh.in/api/v2/user/product/type';

  @override
  void initState(){
    super.initState();
    countryname = "Nepal";
    callapicat();
  }
  // Widget cityList(){
  //   List<Category> categorylist = List<Category>.from(
  //     data["data"].map((i){
  //       return Category.fromJSON(i);
  //     })
  //   );

  // }
  Widget cityList() {
    //widget function for city list
    List<Category> citylist = List<Category>.from(
        data["data"].map((i) {
          return Category.fromJSON(i);
        })
    );

    return DropdownButton(
      hint: Text("select"),
        isExpanded: true,
        items: citylist.map((category){
          return DropdownMenuItem(
              child: Text(category.name),
            value: category.name,
          );
        }).toList(),
        onChanged: (value){
        print("Selected city is ${value}");
        });

    //sear
  }

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Dropdown button"),
      ),
      body: Column(
        children: [
          Container(
            child:cityList(),

          ),
        ],
      ),

    );
  }

  Future<void> callapicat() async {
    Map<String, String> header = {
      "token": 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1MDUiLCJuYW1lIjoiU2hvcCBVc2VyIiwibW9iaWxlIjoiOTk5OTk5OTk5OSIsImNyZWF0ZWRfYXQiOiIyMDIxLTA1LTIxIDE1OjM5OjA3IiwidXBkYXRlZF9hdCI6IjIwMjEtMDUtMjEgMTU6Mzk6MDciLCJ0aW1lIjoxNjI3OTAyMDM4fQ.zo_YfBHZe8J6a_OeoR5DLxVvjgdEEV_I60ReoUCBXRI'
    };
    var res = await http.get(Uri.parse(mgdh),headers:header );
    if(res.statusCode==200){
      setState(() {
        data = json.decode(res.body);
        print(data);
      });
    }


  }


}
class Category {
  late String id;
  late String name;

  Category({required this.id,required this.name});
  factory Category.fromJSON(Map<String,dynamic>json){
    return Category(
        id: json["id"],
        name: json['name']
    );
  }
}





