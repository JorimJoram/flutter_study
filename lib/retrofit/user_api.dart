import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi(baseUrl: "http://192.168.0.229:12400/api/")
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET("/search")
  Future<Map<String, String>> getUsersForSearch(
    @Body() Map<String, String> search,
  );
}
