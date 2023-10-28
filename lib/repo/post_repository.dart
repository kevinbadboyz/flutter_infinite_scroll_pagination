import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_infinite_scroll_pagination_basic/models/post_model.dart';

class PostRepository {
  Future<List<PostModel>?> getAllPostPagination(int pageKey, int pageSize) async {
    try {
      final response = await Dio().get(
          'https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$pageSize');
      debugPrint('PostResponse : ${response.data}');

      if(response.statusCode == 200){
        List listResponse = response.data;
        List<PostModel> listPost = listResponse
            .map((data) => PostModel(
            id: data['id'], title: data['title'], body: data['body']))
            .toList();
        return listPost;
      }
      return null;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
