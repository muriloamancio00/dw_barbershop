import 'dart:developer';

import 'package:dw_barbershop/src/core/providers/aplication_providers.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  //definição da key state da pagina
  var registerAdm = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: barbershopAsyncValue.when(
        error: (error, stackTrace) {
          log('Erro ao carregar página', error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Erro ao carregar a página'),
          );
        },
        loading: () => const BarbershopLoader(),
        data: (barbershopModel) {
          final BarbershopModel(:openingDays, :openingHours) = barbershopModel;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    children: [
                      const AvatarWidget(),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          //nosso botao que controla o state
                          Checkbox.adaptive(
                              value: registerAdm,
                              onChanged: (value) {
                                setState(() {
                                  registerAdm = !registerAdm;
                                  employeeRegisterVm
                                      .setRegisterAdm(registerAdm);
                                });
                              }),
                          const Expanded(
                            //envolvendo o text no expanded, ele quebra para baixo
                            child: Text(
                              'Sou administrador e quero me cadastrar como Colaborador',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Offstage(
                        //envolvemoos a coluna que queremos esconder
                        //passamos a key state
                        offstage: registerAdm,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameEC,
                              validator:
                                  Validatorless.required('Nome obrigatório'),
                              decoration:
                                  const InputDecoration(label: Text('Nome')),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: emailEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('E-mail obrigatório'),
                                Validatorless.email('E-mail invalido'),
                              ]),
                              decoration:
                                  const InputDecoration(label: Text('E-mail')),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: passwordEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha obrigatoria'),
                                Validatorless.min(6,
                                    'Senha deve conter pelo menos 6 caracter'),
                              ]),
                              decoration:
                                  const InputDecoration(label: Text('Senha')),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      WeekdaysPanel(
                          enableDays: openingDays,
                          onDayPressed: employeeRegisterVm.addOrRemoveWorkdays),
                      const SizedBox(
                        height: 24,
                      ),
                      HoursPanel(
                        startTime: 6,
                        endTime: 23,
                        onHourPressed: employeeRegisterVm.addOrRemoveWorkhours,
                        enableTimes: openingHours,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        onPressed: () {
                          switch (formKey.currentState?.validate()) {
                            case false || null:
                              Messages.showError(
                                  'Existem campos inválidos', context);
                            case true:
                              final EmployeeRegisterState(
                                :workdays,
                                :workhours
                              ) = ref.watch(employeeRegisterVmProvider);
                              if (workdays.isEmpty || workhours.isNotEmpty) {
                                Messages.showError(
                                    'Por favor selecione os dias da semana e horário de atendimento',
                                    context);
                                return;
                              }
                              final name = nameEC.text;
                              final email = emailEC.text;
                              final password = passwordEC.text;
                              employeeRegisterVm.register(name:name, email:email, password:password);
                          }
                        },
                        child: const Text('CADASTRAR COLABORADOR'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
