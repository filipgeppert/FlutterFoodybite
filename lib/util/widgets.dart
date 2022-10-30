import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget createTagCard(String text) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0)
      ),
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}