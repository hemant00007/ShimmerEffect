import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shimmer/shimmer.dart';

import 'food.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  _Myhome createState() => _Myhome();

}
class _Myhome extends State<MyHomePage> {
  bool isLoading = false;
  List<Food> foods = [];
  @override
  void initState() {
     super.initState();

loaddata();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Shimmer effect"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: loaddata
          , icon: Icon(Icons.refresh))
        ],
      ),
      body:ListView.builder(
        itemCount: isLoading ?5 : foods.length,
        itemBuilder: (context,index){
          if(isLoading){
            return buildFoodShimmer();
          }else {
            final food = foods[index];
            return buildfood(food);
          }
        },

      )


    );
  }

  Widget buildFoodShimmer() =>ListTile(
    leading: ShimerWidget.circular(width:64,height:64,
    shapeBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    )
    ),
    
title: ShimerWidget.rectangular(height:16),
    subtitle: ShimerWidget.rectangular(height: 12),
  );

  Future loaddata()  async{

    setState(() {
      isLoading =true;
    });
    await Future.delayed(Duration(seconds: 2),() {

    });
    foods = List.of(allFoods);
    setState(() {
      isLoading = false;
    });
  }

  List<Food> allFoods = [
    Food(urlImage: 'https://www.magadhtmt.com/wp-content/uploads/2019/04/Magadh-Mahan-mail-logo-ratina.png', title: "This is a testing work", description: "I am providing a description for testing "),
  Food(urlImage: 'https://www.magadhtmt.com/wp-content/uploads/2019/04/Magadh-Mahan-mail-logo-ratina.png', title: "This is a testing work", description: "I am providing a description for testing "),
  Food(urlImage: 'https://www.magadhtmt.com/wp-content/uploads/2019/04/Magadh-Mahan-mail-logo-ratina.png', title: "This is a testing work", description: "I am providing a description for testing "),
  Food(urlImage: 'https://www.magadhtmt.com/wp-content/uploads/2019/04/Magadh-Mahan-mail-logo-ratina.png', title: "This is a testing work", description: "I am providing a description for testing "),
  Food(urlImage: 'https://www.magadhtmt.com/wp-content/uploads/2019/04/Magadh-Mahan-mail-logo-ratina.png', title: "This is a testing work", description: "I am providing a description for testing "),
  ];

  Widget buildfood(Food food) => ListTile(
    leading: CircleAvatar(
      radius: 32,
      backgroundImage: NetworkImage(food.urlImage),
    ),
    title: Text(
      food.title,
      style: TextStyle(
        fontSize: 16,
      ),
    ),
    subtitle: Text(
      food.description,
      style: TextStyle(
        fontSize: 12
      ),
    ),

  );
}




class ShimerWidget  extends StatelessWidget{
  final double width;
  final double height;
  final ShapeBorder  shapeBorder;

  const ShimerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
}): this.shapeBorder = const RoundedRectangleBorder();

  const ShimerWidget.circular({
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder()
  });
 @override
  Widget build(BuildContext context) =>
     Shimmer.fromColors(
       baseColor: Colors.grey[400]!,
       highlightColor: Colors.grey[300]!,
       child: Container(
   width: width,
   height: height,
   decoration: ShapeDecoration(
     color: Colors.grey[400]!,
     shape: shapeBorder
   ),

 ),
     );
}


