import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// o riverpod precisa manter essa sessao como um singleton dentro do sistema
// RestClientRef é gerado pelo sistema

part 'aplication_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();