
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:use_of_block/posts/bloc/model/post_model.dart';
import 'package:use_of_block/posts/bloc/posts_event.dart';
import 'package:use_of_block/posts/bloc/posts_state.dart';
import 'package:use_of_block/posts/repository/posts_repo.dart';

class PostsBloc extends Bloc<PostsEvent,PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
    on<PostDeleteEvent>(postDeleteEvent);
  }

  FutureOr<void> postsInitialFetchEvent(PostsInitialFetchEvent event,
      Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());

    List<PostModel> posts = await PostsRepo.fetchPosts();


    emit(PostFetchingSuccessfulState(posts: posts));
  }

  FutureOr<void> postAddEvent(PostAddEvent event, Emitter<PostsState> emit) async {
    Map<String, dynamic>? newPostDetails = await PostsRepo.addPosts();
    if (newPostDetails != null) {
      List<PostModel> currentStatePosts = [];
      if (state is PostFetchingSuccessfulState) {
        currentStatePosts.addAll((state as PostFetchingSuccessfulState).posts);
      }
      dynamic userIdValue = newPostDetails['userId'];
      int? userId;

      if (userIdValue is int) {

        userId = userIdValue;
      } else if (userIdValue is String) {

        userId = int.tryParse(userIdValue);
      }
      if (userId != null) {

        PostModel newlyAddedPost = PostModel(
          id: newPostDetails['id'],
          title: newPostDetails['title'],
          body: newPostDetails['body'],
          userId: userId,

        );

        final currentState = state;
        if (currentState is PostFetchingSuccessfulState) {

          List<PostModel> posts = await PostsRepo.fetchPosts();

          currentStatePosts = posts;

          currentStatePosts.add(newlyAddedPost);

          emit(PostFetchingSuccessfulState(posts: currentStatePosts));
        }
        else {
          emit(PostsAdditionErrorState());
        }
        emit(PostsAdditionErrorState());
      }
    }
    }

    FutureOr<void> postDeleteEvent(PostDeleteEvent event,
        Emitter<PostsState> emit) async {
      bool success = await PostsRepo.deletePosts();
      if (success) {
        emit(PostsDeleteSuccessState());
      } else {
        emit(PostsDeleteErrorState());
      }
    }
  }

