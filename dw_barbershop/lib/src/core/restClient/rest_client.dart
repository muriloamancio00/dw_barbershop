import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dw_barbershop/src/core/restClient/interceptors/auth_interceptors.dart';

final class RestClient extends DioForNative{
  RestClient() :super(BaseOptions(
    baseUrl: 'http://192.168.1.104:8080',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 60))) {
      interceptors.addAll([
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
        AuthInterceptors(),
      ]);
    }

  RestClient get auth{
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClient get unAuth{
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}