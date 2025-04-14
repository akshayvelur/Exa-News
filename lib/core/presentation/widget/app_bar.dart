
import 'package:exa_news/core/presentation/screen/home_screen/bloc/home_bloc.dart';
import 'package:exa_news/core/presentation/utils/color/colors.dart';
import 'package:exa_news/core/presentation/utils/mediaquery/mediaquery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.clrwhite,
      title: Text(
        "Exa News",
        style: GoogleFonts.bebasNeue(fontSize: 32, color: Colors.green),
      ),
      actions: [
        
           Container(
            width: mediaqueryWidth(0.52, context),
            child: CupertinoSearchTextField(controller: searchController,onSubmitted: (value) {
               context.read<HomeBloc>().add(SeachEvent(searchText: value));
            },onSuffixTap: () {
              searchController.clear();
               context.read<HomeBloc>().add(SearchBackEvent());
            },),
          ),
        
        IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              const Color.fromARGB(26, 180, 180, 180),
            ),
          ),
          onPressed: () {if(searchController.text.isNotEmpty){
           
           context.read<HomeBloc>().add(SeachEvent(searchText: searchController.text));
          }},
          icon: ImageIcon(AssetImage("assets/search (1).png"), size: 25),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
