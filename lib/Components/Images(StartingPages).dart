// Used in IntoPage for Image Icon and Discription

import 'package:flutter/material.dart';

class Pages extends StatelessWidget {
  final String photo;
  final String heading;
  final String text;
  final double? height;
  final double? width;

  const Pages({
    super.key,
    required this.photo,
    required this.heading,
    required this.text,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 300,
            child: Image(
              image: AssetImage('assets/images/$photo.png'),
              alignment: Alignment.center,
              height: height,
              width: width,
            ),
          ),
          Text(
            heading,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 35,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

