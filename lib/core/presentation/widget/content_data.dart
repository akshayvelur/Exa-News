
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exa_news/core/data/model/news_model.dart';
import 'package:exa_news/core/presentation/utils/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.data,
  });

  final Article data;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.only(top: 6,left: 10, right: 10),
    child: Text(
      data.description!,
      style: GoogleFonts.roboto(
        
        fontSize: 14,
      ),
    ),
                          );
  }
}

class ArticleTitle extends StatelessWidget {
  const ArticleTitle({
    super.key,
    required this.data,
  });

  final Article data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Text(
        data.title,
        style: GoogleFonts.roboto(decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.data,
  });

  final Article data;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColor.clrBlack,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child:
       ClipRRect(
        borderRadius: BorderRadius.circular(10),
     
        child: 
       Center(
         child: CachedNetworkImage(imageUrl:"${data.urlToImage}" ,
            height: 250,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(color:AppColor. clrLightGreen,
               ),
            ),errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
          ),
       ),
      ),
                         );
  }
}
