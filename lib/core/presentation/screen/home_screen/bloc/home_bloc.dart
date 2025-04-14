import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:exa_news/core/data/api_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  StreamSubscription<InternetStatus>? _internetSubscription;

  HomeBloc() : super(HomeInitial()) {
    on<UrlLaunchEvent>(urlLaunchEvent);
    on<InternetConnectionEvent>(internetConnectionEvent);
    on<_EmitConnectedEvent>(_emitConnectedEvent);
    on<_EmitDisconnectedEvent>((event, emit) => emit(InternetNotConnected()));
    on<PaginationEvent>(paginationEvent);
    on<SeachEvent>(seachEvent);
    on<SearchBackEvent>((event, emit) => emit(LoadingSuccessState()));
  }

  FutureOr<void> urlLaunchEvent(
    UrlLaunchEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final Uri uri = Uri.parse(event.Url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> internetConnectionEvent(
    InternetConnectionEvent event,
    Emitter<HomeState> emit,
  ) async {
    _internetSubscription?.cancel(); // Just in case

    _internetSubscription = InternetConnection().onStatusChange.listen((
      status,
    ) {
      if (status == InternetStatus.connected) {
        add(_EmitConnectedEvent());
      } else {
        add(_EmitDisconnectedEvent());
      }
    });
  }

  FutureOr<void> paginationEvent(
    PaginationEvent event,
    Emitter<HomeState> emit,
  ) {
    List posts = [];

    emit(PaginationState(posts: posts));
  }

  FutureOr<void> seachEvent(SeachEvent event, Emitter<HomeState> emit) {
    ApiService _apiService=ApiService();
    print("calling search function${event.searchText }");
    try{
      if(event.searchText.isNotEmpty){
       String search =event.searchText.trim();
    // _apiService.Search(searchText: event.searchText);
    emit(SearchState(searchText: search));
      }
    }catch(e){
      log(e.toString());
    }
}
  FutureOr<void> _emitConnectedEvent(_EmitConnectedEvent event, Emitter<HomeState> emit) {
     emit(InternetConnectedState());
     emit(LoadingSuccessState());
  }
}
