import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchBarUtils extends StatefulWidget {
  final bool isEdit;

  const SearchBarUtils({Key? key, required this.isEdit}) : super(key: key);

  @override
  _SearchBarUtilsState createState() => _SearchBarUtilsState();
}

class _SearchBarUtilsState extends State<SearchBarUtils> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Focus the field after build, if isEdit is true
    if (widget.isEdit) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: TextFormField(
        // focusNode: _focusNode,
        // autofocus: widget.isEdit,
        readOnly: widget.isEdit,
        decoration: InputDecoration(
          hintText: 'Search directory',
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Color(0xFFE93314),
          suffixIcon: Icon(Icons.mic),
          suffixIconColor: Color(0xFFE93314),
          enabled: widget.isEdit,
             enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color:  Color(0xff23527C), 
             width: 2.0, 
            // Change this color as needed
           // Optional, sets the width of the border
          ),
        ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            
          ),
            focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color:  Color(0xff23527C), // Change this color as needed
            width: 2.0, // Optional, sets the width of the border
          ),
        )
        ),
      ),
    );
  }
}



