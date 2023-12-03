import 'dart:convert';

import 'package:use_of_block/posts/bloc/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostModel>> fetchPosts() async {
    var client = http.Client();

    List<PostModel> posts = [];

    try {
      var response = await client.get(
          Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        PostModel post = PostModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      return posts;
    }
    catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<Map<String, dynamic>?> addPosts() async {
    var client = http.Client();

    try {
      var response = await client.post(
          Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      body: {
            "title" : "Hasan is a student",
            "body" : "Hasan trying to learn flutter language",
             "userId" : "47",
      }
      );
      if(response.statusCode>=200 && response.statusCode<300){
        return json.decode(response.body);
      }
      else{
        return null;
      }


    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<bool> deletePosts() async {
    var client = http.Client();

    try {
      var response = await client.delete(
          Uri.parse("https://jsonplaceholder.typicode.com/posts/"),
      );
      if(response.statusCode>=200 && response.statusCode<300){
        return true;
      }
      else{
        return false;
      }


    }
    catch (e) {
      print(e.toString());
      return false;
    }
  }
}