import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/post_model.dart';

class BasedScrollPaginationPage extends StatefulWidget {
  const BasedScrollPaginationPage({super.key});

  @override
  State<BasedScrollPaginationPage> createState() =>
      _BasedScrollPaginationPageState();
}

class _BasedScrollPaginationPageState extends State<BasedScrollPaginationPage> {
  final PagingController<int, PostModel> pagingController =
      PagingController(firstPageKey: 1);
  final int pageSize = 10;

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      fetchData(pageKey);
    });

    // Make message when the connection is off
    // pagingController.addStatusListener((status) {
    //   if (status == PagingStatus.subsequentPageError) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text('Terjadi kesalahan ketika memuat data...'),
    //       action: SnackBarAction(
    //         label: 'Muat ulang',
    //         onPressed: () => pagingController.retryLastFailedRequest(),
    //       ),
    //     ));
    //   }
    // });
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Post'),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => pagingController.refresh()),
        child: PagedListView<int, PostModel>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<PostModel>(
            animateTransitions: true,
            itemBuilder: (context, model, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(model.id.toString()),
                ),
                title: Text(model.title),
                subtitle: Text(model.body),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> fetchData(int pageKey) async {
    try {
      final response = await Dio().get(
          'https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$pageSize');
      debugPrint('PostResponse : ${response.data}');
      List listResponse = response.data;
      List<PostModel> listPost = listResponse
          .map((data) => PostModel(
              id: data['id'], title: data['title'], body: data['body']))
          .toList();

      // pagingController.appendPage(listPost, pageKey + 1);

      final isLastPage = listPost.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(listPost);
      } else {
        pagingController.appendPage(listPost, pageKey + 1);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }
}
