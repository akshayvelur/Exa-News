import 'dart:async';

import 'package:exa_news/core/data/api_service.dart';
import 'package:exa_news/core/data/model/news_model.dart';
import 'package:exa_news/core/presentation/screen/home_screen/bloc/home_bloc.dart';
import 'package:exa_news/core/presentation/utils/color/colors.dart';
import 'package:exa_news/core/presentation/utils/mediaquery/mediaquery.dart';
import 'package:exa_news/core/presentation/widget/app_bar.dart';
import 'package:exa_news/core/presentation/widget/lost_connection.dart';
import 'package:exa_news/core/presentation/widget/scroller_news.dart';
import 'package:exa_news/core/presentation/widget/search_news.dart';
import 'package:flutter/cupertino.dart';
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
 late Future<List<Article>>searchData;
  int page = 1;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    newsData = _apiService.newsFetching(page: page);
    searchData=_apiService.newsFetching(page: page);
    context.read<HomeBloc>().add(InternetConnectionEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          // App Bar
          child:  HomeAppBar(searchController: searchController),
        ),
        
        body: BlocConsumer<HomeBloc, HomeState>( 
          listener: (context, state) {
         if(state is SearchState){
              searchData=_apiService.Search(searchText: state.searchText);
            }
          },
          builder: (context, state) {
            // news List
            if (state is LoadingSuccessState) {
              return ScrollerNews(newsData: newsData, page: page);
            }
            if(state is SearchState){
              return SearchNews(newsData: searchData,);
            }
            // not connected internet message
            if (state is InternetNotConnected) {
              return LostConnection();
            }
            
            return Center(
              child: CircularProgressIndicator(color: AppColor.clrLightGreen),
            );
          },
        ),
      ),
    );
  }
}
