import 'package:counter/app/constant.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../responses/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") email,
    @Field("password") password,
    @Field("imei") imei,
    @Field("deviceType") deviceType,
  );

  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
    @Field("country_mobile_code") countryMobileCode,
    @Field("user_name") userName,
    @Field("email") email,
    @Field("password") password,
    @Field("mobile_number") mobileNumber,
    @Field("profile_picture") profilePicture,
  );
}
