import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
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

class ScrollerNews extends StatelessWidget {
  ScrollerNews({super.key, required this.newsData});
  late Future<List<Article>> newsData;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return FutureBuilder(
          future: newsData,
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
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
                  );
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

}
