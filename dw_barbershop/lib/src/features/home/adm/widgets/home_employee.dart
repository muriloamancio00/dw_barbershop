import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HomeEmployee extends StatelessWidget {
  final imageNetwork = false;

  const HomeEmployee({ super.key });

   @override
   Widget build(BuildContext context) {

    
       return Container(
        width: 200,
        height: 100,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorsConstants.grey),
        ),
        child: Row(children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (imageNetwork) {
                  true => const NetworkImage('url'),
                  false => const AssetImage(ImageConstants.avatar)
                } as ImageProvider,
              ),
            ),
          ),
          const SizedBox(
             height: 16,
          ),
           Expanded(
             child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
              const Text(
                'Nome e sobrenome',
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12)
                    ),
                    onPressed: () {}, 
                    child: const Text('AGENDAR')),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    onPressed: () {}, 
                    child: const Text('VER AGENDA')),
                  Icon(BarbershopIcons.penEdit,size: 12,color: ColorsConstants.brow,),
                  Icon(BarbershopIcons.trash,size: 16,color: ColorsConstants.red,)
                ],
              )
                     ],
                     ),
           ),

        ]),
       );
  }
}