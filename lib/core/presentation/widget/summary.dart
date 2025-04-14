
import 'package:exa_news/core/data/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Summary extends StatelessWidget {
  const Summary({
    super.key,
    required this.data,
    required this.date,
  });

  final Article data;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,),
            child: Text("Summary by ",style: GoogleFonts.roboto(fontSize: 12,color: const Color.fromARGB(173, 44, 43, 43)),),
          ),
          Text(data.source.name,style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.bold),),
        Spacer()
        ,Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(date,style: GoogleFonts.roboto(fontSize: 10),),
        )],
      ),
    );
  }
}
