import 'dart:convert' show jsonDecode;
import 'dart:developer';
import 'package:exa_news/core/data/constands.dart';
import 'package:exa_news/core/data/model/news_model.dart';
import 'package:exa_news/core/presentation/screen/home_screen/bloc/home_bloc.dart';
import 'package:http/http.dart' as http;


class ApiService {
  // String baseUrl="https://newsapi.org/?v2/everythingq=popularity&apiKey=84134bd3b0ad4588b9966d62c3f9ad4a";
  //String baseUrl="https://newsapi.org/v2/everything?q=apple&from=2025-04-12&to=2025-04-12&sortBy=popularity_page=1&apiKey=84134bd3b0ad4588b9966d62c3f9ad4a";
  String baseUrl = "https://newsapi.org";
  String endpoint =
      "/v2/everything?q=tesla&from=2025-04-10&sortBy=publishedAt&";
  String key = "apiKey=${Constants.apiKey}";

  Future<List<Article>> newsFetching({required int page}) async {
    List posts=[];
    String pageAndsize = "page=${page}&pageSize=20&";
    final response = await http.get(
      Uri.parse(baseUrl + endpoint + pageAndsize + key),
    );
     switch (response.statusCode) {
        case 200:
          // print("Response Status: ${response.statusCode}");
             final decodeData = jsonDecode(response.body)["articles"] as List;
        return decodeData.map((article) => Article.fromJson(article)).toList();
        case 400:
          print("Bad Request: ${response.statusCode} ${response.reasonPhrase}");
          throw Exception("Bad Request: Failed to load Articles");
        case 401:
          print(
              "Unauthorized: ${response.statusCode} ${response.reasonPhrase}");
          throw Exception("Unauthorized: Failed to load Articles");
        case 404:
          print("Not Found: ${response.statusCode} ${response.reasonPhrase}");
          throw Exception("Not Found: Failed to load Articles");
        case 500:
          print(
              "Internal Server Error: ${response.statusCode} ${response.reasonPhrase}");
          throw Exception("Internal Server Error: Failed to load Articles");
        default:
          print("Error: ${response.statusCode} ${response.reasonPhrase}");
          throw Exception("Failed to load Articles");
      }
  }

  // searching
    Future<List<Article>> Search({required String searchText}) async {
    String searchpoint = "/v2/everything?q=${searchText}&";
    final response = await http.get(
      Uri.parse(baseUrl + searchpoint+ key),
    );
     switch (response.statusCode) {
        case 200:
         //  print("Response Status: ${response.statusCode}");
             final decodeData = jsonDecode(response.body)["articles"] as List;
        return decodeData.map((article) => Article.fromJson(article)).toList();
        case 400:
          print("Bad Request: ${response.statusCode} ${response.reasonPhrase}");
          throw Exception("Bad Request: Failed to load Articles");
        case 401:
          print(
              "Unauthorized: ${response.statusCode} ${response.reasonPhrase}");
          throw Exception("Unauthorized: Failed to load Articles");
        case 404:
          print("Not Found: ${response.statusCode} ${response.reasonPhrase}");
          throw Exception("Not Found: Failed to load Articles");
        case 500:
          print(
              "Internal Server Error: ${response.statusCode} ${response.reasonPhrase}");
          throw Exception("Internal Server Error: Failed to load Articles");
        default:
          print("Error: ${response.statusCode} ${response.reasonPhrase}");
          throw Exception("Failed to load Articles");
      }
  }
}
