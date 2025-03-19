import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Search")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(labelText: "검색"),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: searchPressed, child: Text("검색")),
              ],
            ),
            SizedBox(height: 20),
            Image.network(
              'https://imgnews.pstatic.net/image/108/2025/03/19/0003312543_001_20250319073308427.jpg?type=w647',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  void searchPressed() {
    FocusScope.of(context).requestFocus(FocusNode());
    Fluttertoast.showToast(
      msg: "클릭했네?",
      toastLength: Toast.LENGTH_LONG,
      //gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }
}
