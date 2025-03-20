import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'juso_api.g.dart';

@RestApi(baseUrl: "https://business.juso.go.kr/addrlink")
abstract class JusoApi {
  factory JusoApi(Dio dio, {String baseUrl}) = _JusoApi;

  @POST("/addrLinkApi.do")
  Future<String> getJuso(@Queries() Map<String, dynamic> queries);
}
