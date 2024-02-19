import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thedipaar/modal/NewsDetailModal.dart';
import 'package:thedipaar/modal/appconfigModal.dart';
import 'package:thedipaar/modal/directoryListModal.dart';
import 'package:thedipaar/modal/eventDetailModal.dart';
import 'package:thedipaar/modal/eventsListModal.dart';
import 'package:thedipaar/modal/newsCategoryModal.dart';
import 'package:thedipaar/modal/newsListModal.dart';
import 'package:thedipaar/modal/searchDirectoryModal.dart';
import 'package:thedipaar/modal/sponserListModal.dart';
import 'package:thedipaar/utils/toastUtils.dart';

class webservice {
  static const String newsDetailUrl =
      'http://52.77.122.228/api/frontend/news/get/';
  static const String newsListUrl =
      "http://52.77.122.228/api/frontend/news/category/";
  static const String newscategoryUrl =
      "http://52.77.122.228/public/api/frontend/news/categories";
  static const String directoryList =
      "http://52.77.122.228/api/frontend/directory/get-category";
  static const String searchDirectory =
      "http://52.77.122.228/api/frontend/directory/get-category-by-sub/";

  static const String sponserList =
      "http://52.77.122.228/api/frontend/sponsor/all";
  static const String eventsList =
      "http://52.77.122.228/api/frontend/events/all";
      static const String eventsDetailUrl = "http://52.77.122.228/api/frontend/events/get/";
       static const String messageUsUrl = 'http://52.77.122.228/api/frontend/contactus';
        static const String appconfigUrl = 'http://52.77.122.228/api/frontend/getconfig';
        static const String newsListAll = "http://52.77.122.228/api/frontend/news/all";

  static Future<News> fetchNews(String id) async {
    final response = await http.get(
      Uri.parse('$newsDetailUrl$id'),
      // Additional headers or body parameters if needed
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final news = News.fromJson(data['data']);
      return news;
    } else {
      ToastUtil.show("Failed to load news", 0);
      throw Exception('Failed to load news');
    }
  }

    static Future<EventDetails> fetchEventsDetail(String id) async {
    final response = await http.get(
      Uri.parse('$eventsDetailUrl$id'),
      // Additional headers or body parameters if needed
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final news = EventDetails.fromJson(data['data']);
      return news;
    } else {
      ToastUtil.show("Failed to load news", 0);
      throw Exception('Failed to load news');
    }
  }
      static Future<Appconfig> fetchAppconfig() async {
    final response = await http.get(
      Uri.parse('$appconfigUrl'),
      // Additional headers or body parameters if needed
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final news = Appconfig.fromJson(data['data']);
      return news;
    } else {
      ToastUtil.show("Failed to load news", 0);
      throw Exception('Failed to load news');
    }
  }



  static Future<List<NewsListModal>> fetchNewsList(String name,bool isAll) async {
    final response = await http.get(
      Uri.parse(isAll ? "${newsListAll}":'$newsListUrl$name'),
    );

    
    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];

      List<NewsListModal> newsList =
          dataList.map((item) => NewsListModal.fromJson(item)).toList();
          newsList.sort((a, b) => DateTime.parse(b.created_date).compareTo(DateTime.parse(a.created_date)));
      return newsList;
    } else {
      ToastUtil.show("Failed to load news", 0);
      throw Exception('Failed to load news');
    }
  }

  static Future<List<SearchDirectory>> fetchSearchDirectory(String id) async {
    final response = await http.get(
      Uri.parse('$searchDirectory$id'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];
      List<SearchDirectory> newsList =
          dataList.map((item) => SearchDirectory.fromJson(item)).toList();
      return newsList;
    } else {
      ToastUtil.show("Failed to load news", 0);
      throw Exception('Failed to load news');
    }
  }

  static Future<List<NewsCategory>> fetchNewsCategory() async {
    final response = await http.get(
      Uri.parse(newscategoryUrl),
    );


    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];
      List<NewsCategory> newsCategory =
          dataList.map((item) => NewsCategory.fromJson(item)).toList();

      return newsCategory;
    } else {
      ToastUtil.show("Failed to load news", 0);
      throw Exception('Failed to load news');
    }
  }

  static Future<List<SponsorList>> fetchSponserList() async {

    final response = await http.get(
      Uri.parse(sponserList),
    );


    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];
      List<SponsorList> sponserList =
          dataList.map((item) => SponsorList.fromJson(item)).toList();

      return sponserList;
    } else {
      ToastUtil.show("Failed to load news", 0);
      throw Exception('Failed to load news');
    }
  }

  static Future<List<EventsList>> fetchEventList() async {

    final response = await http.get(
      Uri.parse(eventsList),
    );

 
    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];
      List<EventsList> eventsList =
          dataList.map((item) => EventsList.fromJson(item)).toList();

      return eventsList;
    } else {
      ToastUtil.show("Failed to load news", 0);
      throw Exception('Failed to load news');
    }
  }

  static Future<List<DirectoryList>> fetchDirectoryList() async {
 
    final response = await http.get(
      Uri.parse(directoryList),
    );


    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];
      List<DirectoryList> newsCategory =
          dataList.map((item) => DirectoryList.fromJson(item)).toList();

      return newsCategory;
    } else {
      ToastUtil.show("Failed to load news", 0);
      throw Exception('Failed to load news');
    }
  }


  static Future<String> messageUsPost({
    required String name,
    required String email,
    required String subject,
    required String comments,
    required String phone,
  }) async {
    try {
      var response = await http.post(
        Uri.parse(messageUsUrl),
        body: {
          'name': name,
          'email': email,
          'subject': subject,
          'comments': comments,
          'phone': phone,
        },
      );

      if (response.statusCode == 200) {
        return response.body; // Return the response body if successful
      } else {
         ToastUtil.show("Failed to send message", 0);
        throw Exception('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
        ToastUtil.show("Failed to send message", 0);
      throw Exception('Exception during API call: $e');
      
    }
  }
}
