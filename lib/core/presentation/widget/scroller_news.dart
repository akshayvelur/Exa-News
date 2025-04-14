import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exa_news/core/data/api_service.dart';
import 'package:exa_news/core/data/model/news_model.dart';
import 'package:exa_news/core/presentation/screen/home_screen/bloc/home_bloc.dart';
import 'package:exa_news/core/presentation/utils/color/colors.dart';
import 'package:exa_news/core/presentation/utils/mediaquery/mediaquery.dart';
import 'package:exa_news/core/presentation/widget/content_data.dart';
import 'package:exa_news/core/presentation/widget/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ScrollerNews extends StatefulWidget {
  ScrollerNews({super.key, required this.newsData,required this.page});
  late Future<List<Article>> newsData;
  int page;
  bool isLoadingMore=false;

  @override
  State<ScrollerNews> createState() => _ScrollerNewsState();
}

class _ScrollerNewsState extends State<ScrollerNews> {
    ApiService _apiService = ApiService();
  final scrollController=ScrollController();
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return FutureBuilder(
          future: widget.newsData,
          builder: (context, snapshot) {
            // error handling
            if (snapshot.hasError) {
              return Center(child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Text(snapshot.error.toString()),
              ));
            } else if (snapshot.hasData) {
              log(snapshot.data!.length.toString());
              return ListView.builder(
                itemCount:widget.isLoadingMore?snapshot.data!.length+1: snapshot.data!.length,controller: scrollController,
                itemBuilder: (context, index) {

                  if(index<snapshot.data!.length){  
                final data = snapshot.data![index];
                  String date = DateFormat(
                    'dd MMM yyyy',
                  ).format(data.publishedAt);
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      width: mediaqueryWidth(100, context),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: const Color.fromARGB(141, 202, 202, 202),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.clrBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //  image view
                          ImageCard(data: data),
                          // article title
                          InkWell(onTap: () {
                          context.read<HomeBloc>().add(UrlLaunchEvent(Url: data.url.toString()));
                          },child: ArticleTitle(data: data)),
                          // description
                          Description(data: data),
                          // summary
                          Summary(data: data, date: date),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );}
                  else{
                    return Center(child: CircularProgressIndicator(color: AppColor.clrLightGreen,),);
                  }
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            }
          },
        );
      },
    );
  }
  void _scrollListener(){
  
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
  print(" call");


  setState(() {
    widget.isLoadingMore=true;
  });
    widget.page=widget.page+1;
      _apiService.newsFetching(page: widget.page);
    }else{
       setState(() {
    widget.isLoadingMore=false;
  });
      print("dontcall");
    }
  }
}
