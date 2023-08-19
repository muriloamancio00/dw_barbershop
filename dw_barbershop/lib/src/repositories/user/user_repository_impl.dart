import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final RestClient restClient;

  UserRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<AuthException, String>> login(
    String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth',data: {
      'email': email,
      'password': password,
    });
  
  return Success(data['access_token']);
  } on DioException catch (e, s) {
    if(e.response != null){
      final Response(:statusCode) = e.response!;
      if(statusCode == HttpStatus.forbidden) {
        log('Login ou Senha inválidos', error: e, stackTrace: s);
        return Failure(AuthUnauthorizedException());
      }
    }
    log('Erro ao Realizar login', error: e, stackTrace: s);
    return Failure(AuthError(message: 'Erro ao Realizar Login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success (UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'erro ao buscar ussuario logado'));
    } on ArgumentError catch(e,s){
      log('Invalid Json', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({String email, String name, String password}) userData) async {
    try {
      await restClient.unAuth.post('/users', data: {
      'name': userData.name,
      'email': userData.email,
      'password': userData.password,
      'profile': 'ADM'
    });
      return Success(nil);
    } on DioException catch (e, s) {
        log('Erro ao registrar usuário',error: e, stackTrace: s);
        return Failure(RepositoryException(message: 'Erro ao registrar usuário admin')
      );
    }
  }
  
  @override
 Future<Either<RepositoryException, List<UserModel>>> getEmployees(
    int barbershopId) async {
      try {
  final Response(:List data) = await restClient.auth
    .get('/users', queryParameters: {'barbershop_id': barbershopId});
  
    final employees = data.map((e) => UserModelEmployee.fromMap(e)).toList();
    return Success(employees);
  } on DioException catch (e, s) {
    //erro de requisição
    log('Erro ao buscar colaboradores', error: e, stackTrace: s);
    return Failure(RepositoryException(message: 'Erro ao buscar colaboradores'));
  }on ArgumentError catch (e, s) {
    //erro de conversão
    log('Erro ao converter colaboradores (Invalid Json)', error: e, stackTrace: s);
    return Failure(RepositoryException(message: 'Erro ao buscar colaboradores'));
      }
  }
}