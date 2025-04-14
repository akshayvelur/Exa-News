import 'dart:async';

import 'package:exa_news/core/data/api_service.dart';
import 'package:exa_news/core/data/model/news_model.dart';
import 'package:exa_news/core/presentation/screen/home_screen/bloc/home_bloc.dart';
import 'package:exa_news/core/presentation/utils/mediaquery/mediaquery.dart';
import 'package:exa_news/core/presentation/widget/app_bar.dart';
import 'package:exa_news/core/presentation/widget/lost_connection.dart';
import 'package:exa_news/core/presentation/widget/scroller_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class HoemScreen extends StatefulWidget {
  const HoemScreen({super.key});

  @override
  State<HoemScreen> createState() => _HoemScreenState();
}

class _HoemScreenState extends State<HoemScreen> {
  ApiService _apiService = ApiService();
  late Future<List<Article>> newsData;
  bool isConnectedInternet=false;
 // StreamSubscription? _internetConnectionStreamSubscription;
  @override
  void initState() {
    newsData = _apiService.newsFetching();
    context.read<HomeBloc>().add(InternetConnectionEvent());
    // TODO: implement initState
    super.initState();
  
  }
@override
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        // App Bar
        child: HomeAppBar(),
      ),

      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if(state is InternetConnectedState){
            print("connected");
          }
        },
        builder: (context, state) {
      // news List
       if(state is InternetConnectedState){
          return ScrollerNews(newsData: newsData);
       }
          // not connected internet message
        return LostConnection();
       
     
        },
      ),
    );
  }
}
