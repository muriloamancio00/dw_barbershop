import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HomeEmployee extends StatelessWidget {

  const HomeEmployee({ super.key });

   @override
   Widget build(BuildContext context) {
       return Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: ColorsConstants.grey)
        ),
       );
  }
}