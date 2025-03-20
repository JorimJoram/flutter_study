import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jorim_flutter/retrofit/juso_api.dart';
import 'package:jorim_flutter/util/logger.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> jusoList = [];
  String address = "";

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
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _showModalBottomSheet,
                    child: Text("모달 열기"),
                  ),
                ),
                Text(
                  (address.isEmpty) ? "주소를 등록해주세요" : "주소: $address",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet() {
    setState(() {
      jusoList = [];
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width, // - 10,
            height: 400, //(jusoList.isNotEmpty) ? 500 : 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    jusoTextField("예시: 도로명(반포대로58), 건물명(독립기념관), 지번(혜화동)"),
                    SizedBox(height: 20),
                    SizedBox(
                      height: (jusoList.length > 3) ? 400 : 200,
                      child: jusoListView(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget jusoTextField(String hint) {
    return TextField(
      onSubmitted: (value) {
        searchJuso(value);
      },
      decoration: InputDecoration(border: OutlineInputBorder(), hintText: hint),
    );
  }

  Widget jusoListView() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics:
          (jusoList.length > 3)
              ? BouncingScrollPhysics()
              : NeverScrollableScrollPhysics(), //AlwaysScrollableScrollPhysics(),
      itemCount: jusoList.length,
      itemBuilder: (context, index) {
        var item = jusoList[index];
        return ListTile(
          title: Text(item['roadAddr']),
          subtitle: Text(item["jibunAddr"]),
          onTap:
              () => {
                logMessage("onclick - ${item['roadAddr']}"),
                setState(() {
                  address = item["jibunAddr"];
                }),
                Navigator.pop(context),
              },
        );
      },
    );
  }

  void searchJuso(String value) async {
    final dio = Dio();
    final client = JusoApi(dio);

    Map<String, dynamic> queries = {
      "confmKey": dotenv.env['JUSO_SECRET'],
      "keyword": value,
      "countPerPage": 20,
      "resultType": "json",
    };
    List<Map<String, dynamic>> resultList =
        (json.decode(await client.getJuso(queries))['results']['juso'] as List)
            .cast<Map<String, dynamic>>();
    logMessage("juso sample\n${resultList[0]}");

    setState(() {
      jusoList = resultList;
    });
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
