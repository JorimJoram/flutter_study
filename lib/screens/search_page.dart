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
                    onPressed: _toggleModal,
                    child: Text("모달 열기"),
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
              left: 0,
              right: 0,
              bottom: _isModalVisible ? 0 : -300,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text(
                          "테스트임",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
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
                ),
              ),
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
