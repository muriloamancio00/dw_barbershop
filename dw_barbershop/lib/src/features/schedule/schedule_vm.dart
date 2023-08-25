import 'package:asyncstate/class/async_loader_handler.dart';
import 'package:dw_barbershop/src/core/providers/aplication_providers.dart';
import 'package:dw_barbershop/src/features/schedule/schedule_state.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';

part 'schedule_vm.g.dart';

@riverpod
class ScheduleVm extends _$ScheduleVm {
  @override
  ScheduleState build() => ScheduleState.initial();

  void hourSelected(int hour) {
    if (hour == state.scheduleHour) {
      state = state.copyWith(scheduleHour: () => null);
    } else {
      state = state.copyWith(
        scheduleHour: () => hour,
      );
    }
  }

  void dateSelecte(DateTime date) {
    state = state.copyWith(scheduleDate: () => date);
  }

  Future<void> register(
      {required UserModel userModel, required String clientName}) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();
    final ScheduleState(:scheduleDate, :scheduleHour) = state;

    final scheduleRepository = ref.read(scheduleRepositoryProvider);
    //é necessario o id do barber shop, quem promove iss?
    final BarbershopModel(id: barbershopId) =
        await ref.watch(getMyBarbershopProvider.future);

    final dto = (
      barbershopId: barbershopId,
      userId: userModel.id,
      clientName: clientName,
      date: scheduleDate!,
      time: scheduleHour!
    );

    final scheduleResult = await scheduleRepository.scheduleClient(dto);

    switch (scheduleResult) {
      case Success():
        state = state.copyWith(status: ScheduleStateStatus.success);
      case Failure():
        state = state.copyWith(status: ScheduleStateStatus.error);
    }

    asyncLoaderHandler.close();
  }
}
