import 'package:flutter/material.dart';
import 'package:jorim_flutter/provider/AccessTokenProvider.dart';
import 'package:jorim_flutter/screens/login_page.dart';
import 'package:jorim_flutter/screens/search_page.dart';
import 'package:jorim_flutter/util/logger.dart';
import 'package:jorim_flutter/util/theme/colors.dart';
import 'package:provider/provider.dart';
import "../services/api_service.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _responseText = "No Data";

  void _getData() async {
    final data = await ApiService.fetchData();
    setState(() {
      _responseText = data != null ? data.toString() : "Fail to get Data";
    });
  }

  @override
  Widget build(BuildContext context) {
    String accessToken = Provider.of<Accesstokenprovider>(context).accessToken;
    return Scaffold(
      appBar: AppBar(title: Text("Jorim Flutter Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_responseText),
            Text("token: $accessToken"),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _getData, child: Text("get data...")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: jorimGreen,
                foregroundColor: Colors.blueGrey,
              ),
              onPressed: goToLogin,
              child: Text("to Login"),
            ),
            ElevatedButton(onPressed: goToSearch, child: Text("To Search")),
          ],
        ),
      ),
    );
  }

  void goToSearch() {
    logMessage("검색화면으로 이동", level: LogLevel.INFO);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  void goToLogin() {
    logMessage("로그인화면으로 이동", level: LogLevel.INFO);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}

/**
 * 25.03.18
 * TODO "Error Exception 처리하는 방법에 대해 시도 해볼 것"
 */
