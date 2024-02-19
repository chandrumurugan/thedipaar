import 'package:flutter/material.dart';
import 'package:thedipaar/constants/imageConstants.dart';
import 'package:thedipaar/modal/directoryListModal.dart';
import 'package:thedipaar/modal/searchDirectoryModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/utils/keyboardUtils.dart';
import 'package:thedipaar/utils/loaderUtils.dart';
import 'package:thedipaar/utils/samplePlugins.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:thedipaar/utils/toastUtils.dart';

class SearchDirectoryScreen extends StatefulWidget {
  const SearchDirectoryScreen({super.key});

  @override
  State<SearchDirectoryScreen> createState() => _SearchDirectoryScreenState();
}

class _SearchDirectoryScreenState extends State<SearchDirectoryScreen> {
  final boxController = BoxController();

  final textController = TextEditingController();

  List<DirectoryList> _directoryList = [];
  List<SearchDirectory> _searchdirectory = [];

  bool isLoading = false;
  bool isListloading = false;

  @override
  void initState() {
    super.initState();
    _fetchDirectoryList();
  }

  Future<void> _fetchDirectoryList() async {
    setState(() {
      isLoading = true;
    });
    try {
      final news = await webservice.fetchDirectoryList();

      setState(() {
        _directoryList = news;

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("exception occurs" + e.toString());
    }
  }

  Future<void> _messageUs(String name, String email, String phonenumber,
      String subject, String message) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await webservice.messageUsPost(
        name: name,
        email: email,
        subject: subject,
        comments: message,
        phone: phonenumber,
      );

      // Handle the response here
      ToastUtil.show("Message sent successfully",1);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Exception occurs: $e');
    }
  }

  Future<void> _fetchSearchDirectoryScreen(String id) async {
    setState(() {
      isListloading = true;
    });
    try {
      final news = await webservice.fetchSearchDirectory(id);


      setState(() {
        _searchdirectory = news;

        isListloading = false;
      });
    } catch (e) {
      setState(() {
        isListloading = false;
      });
      print("exception occurs" + e.toString());
    }
  }

  List slideImages = [
    {"id": 1, "bannerView": AppImages.banner11},
    {"id": 2, "bannerView": AppImages.banner12},
    {"id": 3, "bannerView": AppImages.banner13},
    {"id": 4, "bannerView": AppImages.banner14}
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: SizedBox(
            height: 50,
            width: 150,
            child: Image.asset(AppImages.app_logo),
          ),
          // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt))],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SearchBarUtils(
                //   isEdit: true,
                // ),
                FieldSuggestion<DirectoryList>(
                  sizeByItem: 30,
                  inputDecoration: InputDecoration(
                      hintText: 'Search directory',
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: const Color(0xFFE93314),
                      suffixIcon: const Icon(Icons.mic),
                      suffixIconColor: const Color(0xFFE93314),
                      // enabled: widget.isEdit,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Color(0xff23527C),
                          width: 2.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Color(0xff23527C),
                          width: 2.0,
                        ),
                      )),
                  inputType: TextInputType.name,
                  textController: textController,
                  suggestions: _directoryList,
                  boxController: boxController,
                  search: (item, input) {
                    // Disable box, if item selected.
                    if (item.companyName == input) return false;

                    return item.companyName
                        .toString()
                        .toLowerCase()
                        .contains(input.toLowerCase());
                  },
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          textController.text =
                              _directoryList[index].companyName;
                        });

                        textController.selection = TextSelection.fromPosition(
                          TextPosition(offset: textController.text.length),
                        );
                        KeyboardUtil.hideKeyboard(context);
                        _fetchSearchDirectoryScreen(
                            _directoryList[index].companyId);
                      },
                      child: Container(
                        padding: EdgeInsets.all(0),
                        // color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.70,
                                child: Text(
                                  _directoryList[index].companyName,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _directoryList.removeAt(index);
                                boxController.refresh?.call();
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.77,
                  child: isListloading || isLoading
                      ? Center(
                          child: CommonLoader(),
                        )
                      : _searchdirectory.isEmpty
                          ? Center(
                              child: Text('No Data found'),
                            )
                          : ListView.separated(
                              itemBuilder: (BuildContext context, index) =>
                                  DirectoryItemView(
                                image: _searchdirectory[index].img,
                                sendForm: _messageUs,
                              ),
                              itemCount: _searchdirectory.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DirectoryItemView extends StatefulWidget {
  String image;
  Function sendForm;
  DirectoryItemView({super.key, required this.image, required this.sendForm});

  @override
  State<DirectoryItemView> createState() => _DirectoryItemViewState();
}

class _DirectoryItemViewState extends State<DirectoryItemView> {
  List socialIcons = [
    {"id": 1, "socialIcons": AppImages.whatsapp},
    {"id": 1, "socialIcons": AppImages.facebook},
    {"id": 1, "socialIcons": AppImages.google},
    {"id": 1, "socialIcons": AppImages.twitter},
    {"id": 1, "socialIcons": AppImages.pinterest},
    {"id": 1, "socialIcons": AppImages.linkedin},
  ];

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController messageController = TextEditingController();

  final TextEditingController subjectController = TextEditingController();

  double messageFieldHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return eventsView(context);
  }

  Widget eventsView(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.symmetric(horizontal: 12,),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 239, 239),
        borderRadius: BorderRadius.circular(6), // Adjust the radius as needed
        border: Border.all(
          color: const Color(0xff23527C), // Set the border color here
          width: 1, // Set the border width here
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 140,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              "https://thedipaar.com/user_admin/directory/${widget.image}",
              width: MediaQuery.of(context).size.width,
              // fit: BoxFit.,
            ),
            // color: Colors.amberAccent,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewExample(
                                  loadUrl:
                                      'https://www.thedipaar.ca/directory/1410/matrix-legal-services',
                                )));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 50,
                    width: 120,
                    // width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff23527C),
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    child: const Text(
                      'Contact us',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showPopup(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 50,
                    width: 120,
                    // width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff23527C),
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    child: const Text(
                      'Message us',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  socialIcons.length,
                  (index) => CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color(0xff23527C),
                      child: Image.asset(
                        socialIcons[index]['socialIcons'],
                        fit: BoxFit.fill,
                      )),
                )),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

    String? validateName(String? value) {
    if (value != null && value.length > 15) {
      return 'Name should not exceed 15 characters';
    }
    return null;
  }

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return null; // Return null for empty value
  } else if (!RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      .hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return null; // Return null for empty value
  } else if (value.length != 10) {
    return 'Phone number should be 10 digits';
  }
  return null;
}

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: const Text(
                  'Please send your short message..!\nWe will get back to you '),
                  icon: IconButton(onPressed: (){ Navigator.of(context).pop();}, icon:  const Icon(Icons.close)),
              // actions: [
              //   IconButton(
              //     icon: const Icon(Icons.close),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   ),
              // ],
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration:  InputDecoration(labelText: 'Name',  errorText: validateName(nameController.text),),
                    ),
                    TextField(
                      controller: emailController,
                      decoration:  InputDecoration(labelText: 'Email', errorText: validateEmail(emailController.text)),
                    ),
                    TextField(
                      controller: phoneController,
                      maxLength: 10,
                      decoration:  InputDecoration(labelText: 'Phone',errorText: validatePhone(phoneController.text)),
                    ),
                    TextField(
                      controller: subjectController,
                      // expands: true,
                      // maxLength: 150,
                      // minLines: 25,
                      decoration: const InputDecoration(labelText: 'Subject'),
                    ),
                    TextField(
                      controller: messageController,
                      // expands: true,
                      // maxLength: 150,
                      // minLines: 25,
                      decoration: const InputDecoration(labelText: 'Message'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _validateForm();
                       
                      },
                      child: const Text('Send Enquiry'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _validateForm() {

  setState(() {
    String? nameError = validateName(nameController.text);
    String? emailError = validateEmail(emailController.text);
    String? phoneError = validatePhone(phoneController.text);

    if (nameError != null || emailError != null || phoneError != null) {
      // Display error messages or handle invalid input
    ToastUtil.show('Please fill the valid details', 0);
      return;
    }
    if (nameController.text.isEmpty) {
      ToastUtil.show('Please fill the name', 0);
    } else if (emailController.text.isEmpty) {
      ToastUtil.show('Please fill the email', 0);
    } else if (phoneController.text.isEmpty) {
      ToastUtil.show('Please fill the phone number', 0);
    } else if (subjectController.text.isEmpty) {
      ToastUtil.show('Please fill the subject', 0);
    } else if (messageController.text.isEmpty) {
      ToastUtil.show('Please fill the message', 0);
    } else {
       Navigator.of(context).pop();
      widget.sendForm(nameController.text, emailController.text, phoneController.text,
          subjectController.text, messageController.text);
    }
  });
  }
}

class UserModel {
  final String? email;
  final String? username;
  final String? password;

  const UserModel({this.email, this.username, this.password});
}
