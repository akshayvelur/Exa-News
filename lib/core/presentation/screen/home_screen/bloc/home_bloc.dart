import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
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
  on<_EmitConnectedEvent>((event, emit) => emit(InternetConnectedState()));
on<_EmitDisconnectedEvent>((event, emit) => emit(InternetNotConnected()));
  }

  FutureOr<void> urlLaunchEvent(UrlLaunchEvent event, Emitter<HomeState> emit)async{


    try{
      final Uri uri=Uri.parse(event.Url);
      if(await canLaunchUrl(uri)){
      await launchUrl(uri,mode: LaunchMode.externalApplication);
      }
      }catch(e){
        log(e.toString());
      }
    }
  

  FutureOr<void> internetConnectionEvent(InternetConnectionEvent event, Emitter<HomeState> emit) async{
    _internetSubscription?.cancel(); // Just in case

    _internetSubscription = InternetConnection().onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        add(_EmitConnectedEvent());
      } else {
        add(_EmitDisconnectedEvent());
      }
    });

  }
  
  }
