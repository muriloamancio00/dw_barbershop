import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';

import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/aplication_providers.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';

import 'package:dw_barbershop/src/model/barbershop_model.dart';

import 'package:dw_barbershop/src/model/user_model.dart';

import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
    UserModel userModel) async {
      
      switch(userModel) {
        case UserModelADM():
              // é necessario puxar o primeiro da lista pois a informação vem como lista, e é preciso converter
          final Response(data: List(first: data)) = await restClient.auth.get(
            '/barbershop', queryParameters: {
              'user_id': '#userAuthRef' //#userAuthRef -> ele substitui no backend para o id do user logado
            },
          );
          return Success(BarbershopModel.fromMap(data));

        case UserModelEmployee():
            // no caso do colaborador ele ja possui o id pois ele trabalha no loca, sendo assim vem como objeto
            //auto promoção de tipo!
          final Response(:data) = await restClient.auth.get(
            '/barbershop/${userModel.barbershopId}',
          );
          return Success(BarbershopModel.fromMap(data));
      }
  }

}