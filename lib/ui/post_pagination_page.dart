import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_infinite_scroll_pagination_basic/cubit/post_pagination_cubit.dart';
import 'package:latihan_infinite_scroll_pagination_basic/models/post_model.dart';

class PostPagination extends StatelessWidget {
  const PostPagination({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostPaginationCubit()..getPostPagination(),
      child: PostPaginationPage(),
    );
  }
}

class PostPaginationPage extends StatelessWidget {
  PostPaginationPage({super.key});

  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PostPaginationCubit>(context).getPostPagination();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PostPaginationCubit>(context).getPostPagination();
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Post'),
      ),
      body: BlocBuilder<PostPaginationCubit, PostPaginationState>(
        builder: (context, state) {
          if (state is PostPaginationLoading && state.isFirstFetch) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<PostModel> list = [];
          bool isLoading = false;

          if (state is PostPaginationLoading) {
            list = state.oldListPost;
            isLoading = true;
          } else if (state is PostPaginationError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is PostPaginationLoaded) {
            list = state.listPostModel;
          }
          return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                if (index < list.length) {
                  PostModel postModel = list[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(postModel.id.toString()),
                    ),
                    title: Text(postModel.title),
                    subtitle: Text(postModel.body),
                  );
                } else {
                  Timer(Duration(microseconds: 30), () {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 1.0,
                );
              },
              itemCount: list.length + (isLoading ? 1 : 0));
        },
      ),
    );
  }
}
