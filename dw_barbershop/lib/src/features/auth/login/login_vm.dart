

import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/providers/aplication_providers.dart';
import 'package:dw_barbershop/src/features/auth/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/fp/either.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

   Future<void> login(String email, String password) async {

    // async notation
    final loaderHandle = AsyncLoaderHandler()..start();

    // 1 passo é retornar
    final loginService = ref.watch(userLoginServiceProvider);
    final result = await loginService.execute(email, password);

    // 2 passo, analisar oque foi retornado
    switch(result){
      case Success():
      // buscar dados do usuario logado
      // fazer analise para qual o tipo do login
        break;
        // Destruction para economizar variavel, estraindo so a mensagem da exeption
      case Failure(exception: ServiceException(: final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message
        ); 
    }
    loaderHandle.close();
    }

}