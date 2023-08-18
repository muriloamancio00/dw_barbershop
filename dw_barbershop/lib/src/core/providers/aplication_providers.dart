import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:dw_barbershop/src/repositories/barbershop_repository.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository_impl.dart';
import 'package:dw_barbershop/src/services/users_login/user_login_service.dart';
import 'package:dw_barbershop/src/services/users_login/user_login_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/barbershop_repository_impl.dart';

// o riverpod precisa manter essa sessao como um singleton dentro do sistema
// RestClientRef é gerado pelo sistema

part 'aplication_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
  UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)  
UserLoginService userLoginService(UserLoginServiceRef ref) =>
  UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

//provedor que possui uma logica de negocio envolvido
@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  //isso é diferente do modelo singlton
  //isso parece buscar todas as vezes os dados
  return switch(result) {
    Success(value:final userModel) => userModel,
    Failure (:final exception) => throw exception,
  };
  //isso inicia, guarda a informação e destroi, com o uso do keepAlive,
  // esses itens ppermanecem em cache, quando for pedido ele retorna esses dados de user
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async{
  final barbershopRepository = ref.watch(barbershopRepositoryProvider);

  //primeira vez a ser executado ele me retorna o getme
  //segunda vez ele me retorna direto o objeto montado
  final userModel = await ref.watch(getMeProvider.future);
  final result = await barbershopRepository.getMyBarbershop(userModel);

  return switch(result)  {
    Success(value: final barbershop) => barbershop,
    Failure (:final exception) => throw exception,
  };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMyBarbershopProvider);
  Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!)
      .pushNamedAndRemoveUntil('/auth/login', (route) => false);
}