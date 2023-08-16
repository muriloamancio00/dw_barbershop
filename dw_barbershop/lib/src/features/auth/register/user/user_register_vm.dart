import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/aplication_providers.dart';
import 'package:dw_barbershop/src/features/auth/register/user/user_register_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

enum UserRegisterStateStatus {
  initial,
  success,
  error,
}

@riverpod
class UserRegisterVm  extends _$UserRegisterVm{
@override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;

  Future<void> register({
    required String name, 
    required String email, 
    required String password
  }) async {
    //vm recebe provider
    final userRegisterAdmService = ref.watch(userRegisterAdmServiceProvider);

//data transferobject
    final userDTO =(
      name:name,
      email:email,
      password:password,
    );
    final registerResult = await userRegisterAdmService.execute(userDTO).asyncLoader();

    switch(registerResult){
      case Success():
        ref.invalidate(getMeProvider);
        state = UserRegisterStateStatus.success;
      case Failure():
        state = UserRegisterStateStatus.error;
    }
  }
}