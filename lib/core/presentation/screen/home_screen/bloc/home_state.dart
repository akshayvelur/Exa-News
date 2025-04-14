part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class UrlOpenState extends HomeState{}
class InternetConnectedState extends HomeState{


}
class InternetNotConnected extends HomeState{

}
