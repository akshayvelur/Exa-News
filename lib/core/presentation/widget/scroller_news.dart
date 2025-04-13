import 'package:exa_news/core/data/model/news_model.dart';
import 'package:exa_news/core/presentation/utils/mediaquery/mediaquery.dart';
import 'package:flutter/material.dart';

class ScrollerNews extends StatelessWidget {
   ScrollerNews({super.key,required this.newsData});
   late Future<List<Article>> newsData;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: newsData,
        builder: (context, snapshot) {
          // error handling
           if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          
          else if(snapshot.hasData){
            return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              final data=snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  height: mediaqueryHight(.50, context),
                  width: mediaqueryWidth(100, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 235, 228, 228),
                    ),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(shadowColor:Colors.black,shape: BeveledRectangleBorder( borderRadius:BorderRadius.circular(10))
                       , child: ClipRRect(borderRadius: BorderRadius.circular(10),
                         child: Image.network(
                            "${data.urlToImage}",
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                       ),
                      ),
                      Text(data.source.name)
                    ],
                  ),
                ),
              );
            },
          );
          }
          else{
            return Center(child: CircularProgressIndicator(color: Colors.green,),);
          }
        },
      );
  }
}