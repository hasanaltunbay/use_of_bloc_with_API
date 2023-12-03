
import 'package:flutter/cupertino.dart';

@immutable
abstract class PostsEvent{}

class PostsInitialFetchEvent extends PostsEvent{}

class PostAddEvent extends PostsEvent{}

class PostDeleteEvent extends PostsEvent{}