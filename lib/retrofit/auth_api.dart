import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: "http://192.168.0.229:12500/api/v1")
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("/auth")
  Future<Map<String, String>> userAuth(@Body() Map<String, String> credentials);
}
