import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/aplication_providers.dart';
import 'package:dw_barbershop/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'barbershop_register_vm.g.dart';

@riverpod
class BarbershopRegisterVm extends _$BarbershopRegisterVm {
@override
  BarbershopRegisterState build() => BarbershopRegisterState.initial();

  void addOrRemoveOpenDay(String weekDay){
    final openingDays = state.openingDays;

    if(openingDays.contains(weekDay)){
      openingDays.remove(weekDay);
    }else{
      openingDays.add(weekDay);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  void addOrRemoveOpenHour(int hour){
    final openingHours = state.openingHours;

    if(openingHours.contains(hour)){
      openingHours.remove(hour);
    }else{
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }

//1- buscar instancia do repository
//2- montar ddt (buscando days,hours usando nosso destructor L40)
  Future<void>register(String name, String email) async {
    final repository = ref.watch(barbershopRepositoryProvider);
    final BarbershopRegisterState(:openingDays, :openingHours) = state;

    final dto =(
          name:name,
          email:email,
          openingDays: openingDays,
          openingHours: openingHours,
    );
//3- precisamos chamar o repository para salvar, esperando tudo ser salvo
//4- switch, limpa o cash e da o resultado do registro
    final registerResult = await repository.save(dto);

    switch(registerResult){
      case Success():
      ref.invalidate(getMyBarbershopProvider);
        state = state.copyWith(status: BarbershopRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: BarbershopRegisterStateStatus.error);
    }
  }
  
}
//nessa classe vamos precisar guardar o estado da tela,
//guardando oque foi clicado aqui dentro, horas e dias selecionados
//poderia ser guardado dentro da view, mas assim é mais organizado