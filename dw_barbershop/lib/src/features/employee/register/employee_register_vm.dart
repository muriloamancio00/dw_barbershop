import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/providers/aplication_providers.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setRegisterAdm(bool isRegisterADM) {
    state = state.copyWith(registerADM: isRegisterADM);
  }

  void addOrRemoveWorkdays(String weekDay) {
    final EmployeeRegisterState(:workdays) = state;

    if (workdays.contains(weekDay)) {
      workdays.remove(weekDay);
    } else {
      workdays.add(weekDay);
    }
  }

  void addOrRemoveWorkhours(int hour) {
    final EmployeeRegisterState(:workhours) = state;

    if (workhours.contains(hour)) {
      workhours.remove(hour);
    } else {
      workhours.add(hour);
    }
  }

  //opcionais pois see o cadastro foi adm, esses registros sao nulos
  Future<void> register({String? name, String? email, String? password}) async {
    final EmployeeRegisterState(:registerADM, :workdays, :workhours) = state;
    //async loader lincado ao nosso modulo como todo, nao esta linkado apenas a um ou outro
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final UserRepository(:registerAdmAsEmployee, :registerEmployee) =
        ref.read(userRepositoryProvider);

    final Either<RepositoryException, Nil> resultRegister;

    if (registerADM) {
      final dto = (
        workDays: workdays,
        workHours: workhours,
      );
      resultRegister = await registerAdmAsEmployee(dto);
    } else {
      final BarbershopModel(:id) =
          await ref.watch(getMyBarbershopProvider.future);
      final dto = (
        barbershopId: id,
        name: name!,
        email: email!,
        password: password!,
        workDays: workdays,
        workHours: workhours,
      );
      resultRegister = await registerEmployee(dto);
    }

    switch (resultRegister) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStateStatus.error);
    }
  }
}
