import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/post_model.dart';
import '../repo/post_repository.dart';

part 'post_pagination_state.dart';

class PostPaginationCubit extends Cubit<PostPaginationState> {
  final postRepository = PostRepository();
  int page = 1;
  PostPaginationCubit() : super(PostPaginationInitial());

  void getPostPagination(){
    try{
      if(state is PostPaginationLoading) return;

      final currentState = state;
      var oldPosts = <PostModel>[];
      if(currentState is PostPaginationLoaded){
        oldPosts = currentState.listPostModel;
      }

      emit(PostPaginationLoading(oldPosts, isFirstFetch: page == 1));
      postRepository.getAllPostPagination(page, 10).then((value) {
        page++;

        final posts = (state as PostPaginationLoading).oldListPost;
        posts.addAll(value!);
        emit(PostPaginationLoaded(listPostModel: posts));
      });
    }catch (e){
      emit(PostPaginationError(message: e.toString()));
    }
  }
}
