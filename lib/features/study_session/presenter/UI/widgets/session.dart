import 'package:flutter/material.dart';

class Session extends StatelessWidget {
  final String title;
  final String elapsedTime;
  final String date;

  Session({this.title, this.elapsedTime, this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Column(
          children: [
            Text(elapsedTime),
            Text(date, style: TextStyle(fontWeight: FontWeight.w200))
          ],
        ),
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
      ),
    );
  }
}
