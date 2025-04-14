import 'package:exa_news/core/presentation/screen/home_screen/bloc/home_bloc.dart';
import 'package:exa_news/core/presentation/screen/home_screen/hoem_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [Provider(create: (context) => HomeBloc(),)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Exa News',
        theme: ThemeData.light(
        ),
        home:HoemScreen(
      
        )
      ),
    );
  }
}
