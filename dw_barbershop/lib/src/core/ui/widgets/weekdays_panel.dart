import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
    final ValueChanged<String> onDayPressed;
  const WeekdaysPanel({ super.key, required this.onDayPressed});

   @override
   Widget build(BuildContext context) {
       return  SizedBox(
        width: double.infinity,
         child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione os dias da semana',
              style: TextStyle(
                fontFamily: FontConstants.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            const SizedBox(
                 height: 16,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonDay(label: 'Seg', onDaySelected: onDayPressed),
                    ButtonDay(label: 'Ter', onDaySelected: onDayPressed),
                    ButtonDay(label: 'Qua', onDaySelected: onDayPressed),
                    ButtonDay(label: 'Qua', onDaySelected: onDayPressed),
                    ButtonDay(label: 'Sex', onDaySelected: onDayPressed),
                    ButtonDay(label: 'Sab', onDaySelected: onDayPressed),
                    ButtonDay(label: 'Dom', onDaySelected: onDayPressed),
                  ],
                ),
              ),
          ],
         ),
       );
  }
}

class ButtonDay extends StatefulWidget {
  final String label;

  final ValueChanged<String> onDaySelected;

  const ButtonDay({
    super.key,
    required this.label,
    required this.onDaySelected,
  });

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {

  var selected = false;

  @override
  Widget build(BuildContext context) {

    final textColor = selected ? Colors.white : ColorsConstants.grey;
    var buttonColor = selected ? ColorsConstants.brow : Colors.white;
    final buttonBorderColor = selected ? ColorsConstants.brow : ColorsConstants.grey;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: (){
          setState(() {
            widget.onDaySelected(widget.label);
            selected = !selected;
          });
        },
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonColor,
            border: Border.all(
              color: buttonBorderColor,
            ),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
                fontWeight: FontWeight.w500,
              )
              ),
            ),
        ),
      ),
    );
  }
}