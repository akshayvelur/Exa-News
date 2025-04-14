part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}
class UrlLaunchEvent extends HomeEvent{
  final String Url;

  UrlLaunchEvent({required this.Url});
}
class InternetConnectionEvent extends HomeEvent{
  
}
class _EmitConnectedEvent extends HomeEvent {}

class _EmitDisconnectedEvent extends HomeEvent {}
