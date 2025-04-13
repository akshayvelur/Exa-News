import 'package:exa_news/core/data/api_service.dart';
import 'package:exa_news/core/data/model/news_model.dart';
import 'package:exa_news/core/presentation/utils/mediaquery/mediaquery.dart';
import 'package:exa_news/core/presentation/widget/app_bar.dart';
import 'package:exa_news/core/presentation/widget/scroller_news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HoemScreen extends StatefulWidget {
  const HoemScreen({super.key});

  @override
  State<HoemScreen> createState() => _HoemScreenState();
}

class _HoemScreenState extends State<HoemScreen> {
  ApiService _apiService = ApiService();
  late Future<List<Article>> newsData;
  @override
  void initState() {
    newsData = _apiService.newsFetching();
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
      // news List
      body: ScrollerNews(newsData: newsData,)
    );
  }
}
