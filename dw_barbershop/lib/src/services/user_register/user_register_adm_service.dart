import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';

import '../../core/fp/nil.dart';

abstract interface class UserRegisterAdmService {

  Future<Either<ServiceException, Nil>> execute(({
    String email, String name, String password
  }) userData);

}