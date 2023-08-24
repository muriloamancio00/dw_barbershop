import 'package:flutter/material.dart';

import '../constants.dart';

class HoursPanel extends StatelessWidget {
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  final List<int>? enableTimes;

  const HoursPanel({
   super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enableTimes,
  });

   @override
   Widget build(BuildContext context) {
       return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione os horarios de atendimento',
              style: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 16,
              children: [
                for(int i = startTime; i<= endTime; i++)
                  TimeButton(
                    enableTimes: enableTimes,
                    label: '${i.toString().padLeft(2,'0')}:00',
                    value: i,
                    onPressed: onHourPressed,
                    ),
              ],
            ),
          ],
          
       );
  }
}

class TimeButton extends StatefulWidget {
  final String label;
  final int value;
  final ValueChanged<int> onPressed;
  final List<int>? enableTimes;


  const TimeButton({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
    this.enableTimes,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {

    final textColor = selected ? Colors.white : ColorsConstants.grey;
    var buttonColor = selected ? ColorsConstants.brow : Colors.white;
    final buttonBorderColor = selected ? ColorsConstants.brow : ColorsConstants.grey;

    final TimeButton(:value, :label, :enableTimes, :onPressed) = widget;

    final disableTime = enableTimes != null && !enableTimes.contains(value); 

    if(disableTime) {
      buttonColor = Colors.grey[400]!;
    }


    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disableTime ? null : () {
        setState(() {
          selected = !selected;
          onPressed(value);
        });
      },
      child: Container(
        width: 64,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
          border: Border.all(
            color: buttonBorderColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}