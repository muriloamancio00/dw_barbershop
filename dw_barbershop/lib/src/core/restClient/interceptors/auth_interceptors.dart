
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/constants/local_storage_keys.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:flutter/material.dart';
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

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;

//se for requisiçãso autentificada
    if(extra case {'DIO_AUTH_KEY': true}) { 
//se for a requisiçãso receber status 403('forbiden')
      if(response != null && response.statusCode == HttpStatus.forbidden) {
//vamos redirecionar a tela para o login
        Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!)
          .pushNamedAndRemoveUntil('/auth/login', (route) => false);
      }
    }
//see não vamos rejeitar nossa requisição ('nao autentificada')
    handler.reject(err);
  }  
}