import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jorim_flutter/util/theme/colors.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isModalVisible = false;

  void _toggleModal() {
    setState(() {
      _isModalVisible = !_isModalVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Search")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
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
                Center(
                  child: ElevatedButton(
                    onPressed: _showModalBottomSheet,
                    child: Text("모달 열기"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width - 10,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Test",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 30),
                  Image.network(
                    "https://imgnews.pstatic.net/image/076/2025/03/19/2025031901001214200178992_20250319170012109.jpg?type=w647",
                    width: double.infinity,
                    height: 300,
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
