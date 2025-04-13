
import 'dart:convert' show jsonDecode;
import'dart:developer';
import 'package:exa_news/core/data/constands.dart';
import 'package:exa_news/core/data/model/news_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

// String baseUrl="https://newsapi.org/?v2/everythingq=popularity&apiKey=84134bd3b0ad4588b9966d62c3f9ad4a";
String baseUrl="https://newsapi.org/v2/everything?q=apple&from=2025-04-12&to=2025-04-12&sortBy=popularity&apiKey=84134bd3b0ad4588b9966d62c3f9ad4a";
String endpoint="/?v2/everythingq=popularity&";
String key="apiKey=${Constants.apiKey}";

Future<List<Article>> newsFetching()async{
  final response=await http.get(Uri.parse(baseUrl));
  if(response.statusCode==200){
    print("data fetched");
    try{
    final decodeData=jsonDecode(response.body)["articles"]as List;
        print(decodeData);
return decodeData.map((article)=>Article.fromJson(article)).toList();
    }catch(e){
    log(e.toString());
    }

  }
  else{
    print("not get");
  }
return [];
}
}