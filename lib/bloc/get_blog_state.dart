part of 'get_blog_cubit.dart';

abstract class GetBlogState extends Equatable {}

final class GetBlogInitial extends GetBlogState {
  @override
  List<Object?> get props => [];
}

final class GetBlogLoadingState extends GetBlogState {
  @override
  List<Object?> get props => [];
}

final class GetBlogLoadedState extends GetBlogState {
  final GetBlogResponseModel model;
  GetBlogLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class GetBlogErrorState extends GetBlogState {
  final String errorMessage;
  GetBlogErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
