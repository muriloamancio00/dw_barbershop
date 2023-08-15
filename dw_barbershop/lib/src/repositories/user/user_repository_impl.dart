import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final RestClient restClient;

  UserRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<AuthException, String>> login(
    String email, String password) async {
    final Response(:data) = await restClient.unAuth.post('/auth',data: {
      'email': email,
      'password': password,
    });

    return Success(data['access_token']);

  }



}