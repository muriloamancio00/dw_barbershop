import 'package:dw_barbershop/src/core/providers/aplication_providers.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final bool hideFilter;

  const HomeHeader({super.key, this.hideFilter = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(getMyBarbershopProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 16),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(
            ImageConstants.backgroundChair,
          ),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //passando o provider la em cima, podemos usar a instancia do provider aqui
          //!= maybewhen é que so precisamos implementar o orElse,
          //? se tudo der errado isso vai ocorrer, e no when somos obrigado
          //? a implementar todos os metodos da função
          barbershop.maybeWhen(data: (barbershopData) {
            return Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xffbdbdbd),
                  child: SizedBox.shrink(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: Text(
                    barbershopData.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Expanded(
                  child: Text(
                    'editar',
                    style: TextStyle(
                      color: ColorsConstants.brow,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      ref.read(homeAdmVmProvider.notifier).logout();
                    },
                    icon: const Icon(
                      BarbershopIcons.exit,
                      color: ColorsConstants.brow,
                      size: 32,
                    )),
              ],
            );
          }, orElse: () {
            return const Center(child: BarbershopLoader());
          }),

          const SizedBox(
            height: 24,
          ),
          const Text(
            'Bem Vindo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Agende um Cliente',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 40,
            ),
          ),
          Offstage(
            offstage: hideFilter,
            child: const SizedBox(
              height: 24,
            ),
          ),
          Offstage(
            offstage: hideFilter,
            child: TextFormField(
              decoration: const InputDecoration(
                  label: Text('Buscar colaborador'),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 24.0),
                    child: Icon(
                      BarbershopIcons.search,
                      color: ColorsConstants.brow,
                      size: 26,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
