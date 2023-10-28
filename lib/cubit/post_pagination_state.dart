part of 'post_pagination_cubit.dart';

@immutable
abstract class PostPaginationState {}

class PostPaginationInitial extends PostPaginationState {}

class PostPaginationLoading extends PostPaginationState {
  final List<PostModel> oldListPost;
  final bool isFirstFetch;
  PostPaginationLoading(this.oldListPost, {this.isFirstFetch = false});
}

class PostPaginationLoaded extends PostPaginationState {
  final List<PostModel> listPostModel;
  PostPaginationLoaded({required this.listPostModel});
}

class PostPaginationError extends PostPaginationState {
  final String message;

  PostPaginationError({required this.message});
}
