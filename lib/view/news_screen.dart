import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/foundation.dart';
import 'package:thedipaar/utils/newsItemContainer.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "All"),
    OptionItem(id: "2", title: "World"),
    OptionItem(id: "3", title: "Technology"),
    OptionItem(id: "4", title: "Business"),
    OptionItem(id: "5", title: "Sports"),
  ]);
  OptionItem optionItemSelected = OptionItem(title: "Select categories");

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
                // SizedBox(
                //   height: 60,
                //   width: MediaQuery.of(context).size.width,
                //   child: CustomDropdownSelect<String>(
                //     items: items,
                //     value: selectedValue,
                //     onChanged: _onDropdownChanged,
                //   ),
                // ),
                SelectDropList(
                  itemSelected: optionItemSelected,
                  dropListModel: dropListModel,
                  showIcon: false,
                  showArrowIcon: true,
                  showBorder: true,
                  paddingTop: 0,
                  width: MediaQuery.of(context).size.width,
                  paddingDropItem: 10,
                  suffixIcon: Icons.arrow_drop_down,
                  containerPadding: const EdgeInsets.all(10),
                  icon: const Icon(Icons.person, color: Colors.black),
                  onOptionSelected: (optionItem) {
                    optionItemSelected = optionItem;
                    setState(() {});
                  },
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height,
                //   child: Expanded( // Use Expanded to take remaining available space
                //     child: ListView.builder(
                //       itemCount: 4,
                //       itemBuilder: (BuildContext context, int index) => NewsItem(),
                     
                //     ),
                //   ),
                // ),
                  ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) => NewsItem(),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

