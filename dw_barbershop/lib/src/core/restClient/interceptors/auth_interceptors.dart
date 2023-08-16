
import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/constants/local_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Interceptor, coisas que acontecem no ciclo de vida de uma requisição HTTP
//bate ou não backend, volta com success, ou erro, 4 passos
class AuthInterceptors extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    // se existir essa chave no extra, ele entra
    if(extra case {'DIO_AUTH_KEY': true} ){
      final sp = await SharedPreferences.getInstance();
      headers.addAll({
        authHeaderKey: 'Bearer ${sp.getString(LocalStorageKeys.accessToken)}'
      });
    }
    handler.next(options);
  }
  
}