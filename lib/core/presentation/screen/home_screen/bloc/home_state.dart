part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  
}

class HomeInitial extends HomeState {}
class UrlOpenState extends HomeState{}
class InternetConnectedState extends HomeState{


}
class InternetNotConnected extends HomeState{

}

class PaginationState extends HomeState{
  final List posts;

  PaginationState({required this.posts});
}
class SearchState extends HomeState{
  final String searchText;

  SearchState({required this.searchText});
}
class SearchCompletedState extends HomeState{

}
class LoadingSuccessState extends HomeState{}