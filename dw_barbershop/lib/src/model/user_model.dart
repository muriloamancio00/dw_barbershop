sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar
  });
}

class UserModelADM extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;
  UserModelADM({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });

  factory UserModelADM.fromMap(Map<String,dynamic> json){
    return switch(json){
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } => UserModelADM(
        id: id,
        name: name,
        email: email,
        avatar: json['avatar'],
        workDays: json['work_days']?.cast<String>(),
        workHours: json['work_hours']?.cast<String>(),
        ),
      // isso é o coringa, se nao for ele resolve o problema
      _=> throw ArgumentError('Invalid Json'),
    };
  }  
}

class UserModelEmployee extends UserModel {
  final int barbershopId;
  final List<String> workDays;
  final List<int> workHours;
  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    required this.barbershopId,
    required this.workDays,
    required this.workHours,
    super.avatar,
  });  

  factory UserModelEmployee.fromMap(Map<String,dynamic>json) {
    return switch(json){
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'barbershop_id': final int barbershop_id,
        'work_days': final List work_days,
        'work_hours': final List work_hours,
      } => UserModelEmployee(
        id: id,
        name: name,
        email: email,
        avatar: json['avatar'],
        barbershopId: barbershop_id,
        workDays: work_days.cast<String>(),
        workHours: work_hours.cast<int>(),
        ),
      // isso é o coringa, se nao for ele resolve o problema
      _=> throw ArgumentError('Invalid Json'),
    };
  }
}
