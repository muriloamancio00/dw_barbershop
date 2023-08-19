import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/aplication_providers.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../model/barbershop_model.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm{
  @override
  Future<HomeAdmState> build() async{

    final repository = ref.read(userRepositoryProvider);
    final BarbershopModel(id: barbershopId) = await ref.read(getMyBarbershopProvider.future);

    final employeesResult = await repository.getEmployees(barbershopId);

    switch(employeesResult){
      case Success(value:final employees):
        return HomeAdmState(status: HomeAdmStateStatus.loaded, employees: employees);
      case Failure():
        return HomeAdmState(status: HomeAdmStateStatus.loaded, employees: []);
    } 
    
  }

//chamo nosso provider, instancio como future e direciona para a pagina que eu quero
  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}