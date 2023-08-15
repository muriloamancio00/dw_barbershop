import 'package:dw_barbershop/src/core/constants/local_storage_keys.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {

  final UserRepository userRepository;

  UserLoginServiceImpl({
    required this.userRepository,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
    String email, String password) async {
    // repository nao sobe exeption, pois trata disso com o trycath dentro dele
    final loginResult = await userRepository.login(email, password);

    switch(loginResult){
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);
        
        // Se existir erro, ele é veriricado e tratado
      case Failure(:final exception):
        return switch(exception){
           AuthError() => 
            Failure(ServiceException(message: 'Erro ao realizar login')),
           AuthUnauthorizedException() => 
            Failure(ServiceException(message: 'Login ou senha invalidos')),
        };
      }
    }
  }
