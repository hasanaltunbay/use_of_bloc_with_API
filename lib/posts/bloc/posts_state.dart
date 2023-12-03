
import 'model/post_model.dart';

abstract class PostsState{}

abstract class PostActionState extends PostsState{}

class PostsInitial extends PostsState{}

class PostsFetchingLoadingState extends PostsState{}

class PostsFetchingErrorState extends PostsState{}

class PostFetchingSuccessfulState extends PostsState{
  final List<PostModel> posts;

  PostFetchingSuccessfulState({required this.posts});
}

class PostsAdditionSuccessState extends PostActionState{}

class PostsAdditionErrorState extends PostActionState{}

class PostsDeleteSuccessState extends PostActionState{}

class PostsDeleteErrorState extends PostActionState{}

