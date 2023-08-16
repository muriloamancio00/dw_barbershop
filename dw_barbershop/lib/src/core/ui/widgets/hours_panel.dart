import 'package:flutter/material.dart';

import '../constants.dart';

class HoursPanel extends StatelessWidget {
  final int startTime;
  final int endTime;

  const HoursPanel({
   super.key,
    required this.startTime,
    required this.endTime,
  });

   @override
   Widget build(BuildContext context) {
       return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecione os horarios de atendimento',
              style: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 16,
              children: [
                TimeButton(label: '06:00'),
                TimeButton(label: '07:00'),
                TimeButton(label: '08:00'),
                TimeButton(label: '09:00'),
                TimeButton(label: '10:00'),
                TimeButton(label: '11:00'),
                TimeButton(label: '12:00'),
                TimeButton(label: '13:00'),
                TimeButton(label: '14:00'),
                TimeButton(label: '15:00'),
                TimeButton(label: '16:00'),
                TimeButton(label: '17:00'),
                TimeButton(label: '18:00'),
                TimeButton(label: '19:00'),
                TimeButton(label: '20:00'),
                TimeButton(label: '21:00'),
                TimeButton(label: '22:00'),
                TimeButton(label: '23:00'),
              ],
            ),
          ],
          
       );
  }
}

class TimeButton extends StatelessWidget {
  final String label;

  const TimeButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: ColorsConstants.grey,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: FontConstants.fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}