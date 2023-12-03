import 'package:flutter/material.dart';
import 'package:use_of_block/posts/ui/posts_page.dart';


void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostsPage(),
    );
  }
}

