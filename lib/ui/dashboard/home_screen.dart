import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(child: Text("Home"))
   );
  }

}