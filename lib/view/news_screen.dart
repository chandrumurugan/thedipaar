import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/foundation.dart';
import 'package:thedipaar/modal/newsCategoryModal.dart';
import 'package:thedipaar/modal/newsListModal.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/utils/newsItemContainer.dart';
import 'package:thedipaar/service/web_service.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchNewsCategory();
  }

 DropListModel? dropListModel;
  OptionItem optionItemSelected = OptionItem(title: "Select categories");


    Future<void> _fetchNewsCategory() async {
    setState(() {
      isLoading = true;
    });
    try {
      final news = await webservice.fetchNewsCategory();
      print('example=====>${news.length}');

      setState(() {
        _newsCategory = news;

          dropListModel = DropListModel(
          _newsCategory
              .map((category) =>
                  OptionItem( title: category.categoryName))
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
      print('getted value==>' + news[0].id.toString());
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
                    'Dont miss daily news',
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
                  showBorder: true,
                  paddingTop: 0,
                  width: MediaQuery.of(context).size.width,
                  // paddingDropItem: 10,
                  suffixIcon: Icons.arrow_drop_down,
                  containerPadding: const EdgeInsets.all(10),
                  icon: const Icon(Icons.person, color: Colors.black),
                  onOptionSelected: (optionItem) {
                    print('itemslected===>' + optionItem.title);

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
                          created_date: _newsList[index].created_date, shorts: _newsList[index].shorts,
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
