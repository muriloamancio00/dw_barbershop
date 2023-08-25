class ScheduleModel {
  final int id;
  final int barbershopId;
  final int userId;
  final String clientName;
  final DateTime date;
  final int hour;

  ScheduleModel({
    required this.id,
    required this.barbershopId,
    required this.userId,
    required this.clientName,
    required this.date,
    required this.hour,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> json) {
    switch (json) {
      case {
          'id': int id,
          'barbershop_id': int barbershopId,
          'user_id': int userId,
          'client_name': String clientName,
          'date': String scheduleDate,
          'time': int hour,
        }:
        return ScheduleModel(
            id: id,
            barbershopId: barbershopId,
            userId: userId,
            clientName: clientName,
            date: DateTime.parse(scheduleDate),
            hour: hour);
      case _:
        throw ArgumentError('Invalid JSON');
    }
  }
}

    // {
    //     "id": 2,
    //     "barbershop_id": 3,
    //     "user_id": 6,
    //     "client_name": "Cliente teste 1",
    //     "date": "2023-08-30T00:00:00.000Z",
    //     "time": 14
    // }