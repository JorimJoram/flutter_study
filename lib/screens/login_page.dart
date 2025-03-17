import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jorim_flutter/provider/AccessTokenProvider.dart';
import 'package:jorim_flutter/retrofit/auth_api.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = "";

  void _authenticate() async {
    String phone = _phoneController.text;
    String password = _passwordController.text;
    Map<String, String> credentials = {'phone': phone, 'password': password};

    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    final client = AuthApi(dio);

    Map<String, String> response = await client.userAuth(credentials);
    String? token = response["accessToken"];

    setState(() {
      if (token != null) {
        _message = "로그인 성공, $token";
        Provider.of<Accesstokenprovider>(
          context,
          listen: false,
        ).setAccessToken(token);
      } else {
        _message = "fail Authenticate";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LoginPage")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _authenticate, child: Text("Login")),
            SizedBox(height: 20),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
