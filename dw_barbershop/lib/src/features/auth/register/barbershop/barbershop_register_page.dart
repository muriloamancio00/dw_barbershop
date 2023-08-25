import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:dw_barbershop/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:dw_barbershop/src/features/auth/register/barbershop/barbershop_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/messages.dart';
import '../../../../core/ui/widgets/hours_panel.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {

  const BarbershopRegisterPage({ super.key });

  @override
  ConsumerState<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends ConsumerState<BarbershopRegisterPage> {

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {
    //sempre que é preciso da referencia, isso tem que ser visto pelo riverpod
    //extender widgets do river
    final barbershopRegisterVm = ref.watch(barbershopRegisterVmProvider.notifier);

    ref.listen(barbershopRegisterVmProvider, (_, state) {
      switch(state.status){
        case BarbershopRegisterStateStatus.initial:
          break;
        case BarbershopRegisterStateStatus.error:
          Messages.showError('Desculpe, ocorreu um erro ao registrar barbearia', context);
        case BarbershopRegisterStateStatus.success:
          Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
      }
    });

       return Scaffold(
           appBar: AppBar(title: const Text('Cadastrar Estabelecimento'),),
           body: Padding(
            padding:  const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: nameEC,
                      validator: Validatorless.required('Nome Obrigatorio'),
                      onTapOutside: (_) => context.unfocus(),
                      decoration: const InputDecoration(
                        label: Text('Nome'),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: emailEC,
                      validator: Validatorless.multiple([
                        Validatorless.required('E-mail Obrigatorio'),
                        Validatorless.email('E-mail inválido'),
                      ]),
                      onTapOutside: (_) => context.unfocus(),
                      decoration: const InputDecoration(
                        label: Text('E-mail'),
                      ),
                    ),
                     const SizedBox(
                      height: 24,
                    ),
                     WeekdaysPanel(
                      onDayPressed: (value) {
                        barbershopRegisterVm.addOrRemoveOpenDay(value);
                      },
                     ),
                     const SizedBox(
                      height: 24,
                    ),
                    HoursPanel(
                      startTime: 6,
                      endTime: 23,
                      onHourPressed: (int value){
                        barbershopRegisterVm.addOrRemoveOpenHour(value);
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton( 
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56)
                    ),
                    onPressed: (){
                      switch(formKey.currentState?.validate()){
                        case false|| null:
                          Messages.showError('Formulario inválido',context);
                        case true:
                        barbershopRegisterVm.register(
                          nameEC.text,emailEC.text);
                      }
                    },
                    child: const Text('CADASTRAR ESTABELECIMENTO') ,
                    ),
                  ]),
              ),
            ),
           ),
       );
  }
}