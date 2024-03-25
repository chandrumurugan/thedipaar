import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/foundation.dart';
import 'package:thedipaar/modal/newsCategoryModal.dart';
import 'package:thedipaar/modal/newsListModal.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/utils/newsItemContainer.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/utils/shareUtils.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<NewsListModal> _newsList = [];
  List<NewsCategory> _newsCategory = [];
  bool showList = false;
  bool isLoading = false;
  String? shareBaseURL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchNewsCategory();
      _getconfig();
  }

     _getconfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shareBaseURL = prefs.getString('share_baseurl');
    });
  }

  DropListModel? dropListModel;
  OptionItem optionItemSelected = OptionItem(title: "Select categories");

  Future<void> _fetchNewsCategory() async {
    setState(() {
      isLoading = true;
    });
    try {
      final news = await webservice.fetchNewsCategory();

      setState(() {
        _newsCategory = news;

        dropListModel = DropListModel(
          _newsCategory
              .map((category) => OptionItem(title: category.categoryName))
              .toList(),
        );
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("exception occurs" + e.toString());
    }
  }

  Future<void> _fetchNewsList(String name) async {
    try {
      setState(() {
        isLoading = true;
      });
      final news = await webservice.fetchNewsList(name);
      setState(() {
        _newsList = news;
        isLoading = false;
        showList = true;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("exception occurs" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        surfaceTintColor:Colors.white ,
        title: SizedBox(
          height: 50,
          width: 150,
          child: Image.asset(AppImages.app_logo),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                const SizedBox(height: 25),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Most recent world news',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Don't miss out on the daily news",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                SelectDropList(
                  itemSelected: optionItemSelected,
                  dropListModel: dropListModel ?? DropListModel([]),
                  showIcon: false,
                  showArrowIcon: true,
                  hintColorTitle:  Color(0xFFE93314),
                  showBorder: true,
                  paddingDropItem:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  paddingTop: 0,
                  width: MediaQuery.of(context).size.width,
                  textColorItem: Colors.black87,
                  textSizeItem : 18,
                  heightBottomContainer: 200,
                  borderColor:Color(0xFFE93314) ,
                  // paddingDropItem: 10,
                  suffixIcon: Icons.arrow_drop_down,
                  containerPadding: const EdgeInsets.symmetric(horizontal: 10),
                  icon: const Icon(Icons.person, color: Color(0xFFE93314)),
                  textColorTitle: Colors.black87, // Change color to red (example)
                  textSizeTitle: 18,
                  // containerDecoration: BoxDecoration(color: Colors.blue),
                  onOptionSelected: (optionItem) {

                    setState(() {
                      optionItemSelected = optionItem;
                      showList = false;
                    });
                    _fetchNewsList(optionItem.title);
                  },
                ),
                showList
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: _newsList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            NewsItem(
                          id: _newsList[index].id,
                          img: _newsList[index].img,
                          cat_name: _newsList[index].cat_name,
                          title: _newsList[index].title,
                          created_date: _newsList[index].created_date,
                          shorts: _newsList[index].shorts, onShare: ()async { 
 await ShareUtils.share(
              _newsList[index].title,
              "http://thedipaar.com/uploads/news/${_newsList[index].img}",
              "${shareBaseURL}${_newsList[index].id}");
                           },
                        ),
                      )
                    : isLoading
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: const Center(
                              child: CommonLoader(),
                            ))
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: const Center(
                                child: Text('No item selected',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
