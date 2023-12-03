import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use_of_block/posts/bloc/posts_bloc.dart';
import 'package:use_of_block/posts/bloc/posts_event.dart';

import '../bloc/posts_state.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  
  final PostsBloc postsBloc = PostsBloc();
  
  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts Page"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          postsBloc.add(PostAddEvent());

        },
      ),
      body: BlocConsumer<PostsBloc,PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is !PostActionState,
        listener: (BuildContext context, PostsState state){
        },

        builder: (BuildContext context, PostsState state) {
          switch(state.runtimeType){
            case PostsFetchingLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case PostFetchingSuccessfulState:
              final successState = state as PostFetchingSuccessfulState;

              return Container(
                child: ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder:(context, index) {
                    return Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(15),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(successState.posts[index].title),
                          Text(successState.posts[index].body),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(successState.posts[index].userId.toString()),
                              IconButton(onPressed: (){
                                postsBloc.add(PostDeleteEvent());
                                setState(() {
                                  successState.posts.removeAt(index);
                                });


                              }, icon: Icon(Icons.delete)),
                            ],
                          ),


                        ],
                      ),
                    );
                  },
                ),
              );
            default:
            return SizedBox();
          }


        },

      ),
    );
  }
}
