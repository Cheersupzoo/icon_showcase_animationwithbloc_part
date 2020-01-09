import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconModel {
  final String title;
  final IconData icon;
  final String cardkey;
  final String titlekey;
  final String iconkey;

  IconModel({
    this.title,
    this.icon,
    String cardkey,
    String titlekey,
    String iconkey,
  }) : this.cardkey = cardkey ?? 'card${UniqueKey()}',
  this.titlekey = titlekey ?? 'title${UniqueKey()}',
  this.iconkey = iconkey  ?? 'icon${UniqueKey()}';
}

final List<IconModel> iconList = [
  IconModel(title: 'Motorcycle', icon: Icons.motorcycle),
  IconModel(title: 'Car', icon: Icons.directions_car),
  IconModel(title: 'Train', icon: Icons.directions_railway),
  IconModel(title: 'Laptop', icon: Icons.laptop_windows),
  IconModel(title: 'Home', icon: Icons.home),
];

List<IconModel> newIconList () => [
  IconModel(title: 'Motorcycle', icon: Icons.motorcycle),
  IconModel(title: 'Car', icon: Icons.directions_car),
  IconModel(title: 'Train', icon: Icons.directions_railway),
  IconModel(title: 'Laptop', icon: Icons.laptop_windows),
  IconModel(title: 'Home', icon: Icons.home),
  IconModel(title: 'Bus Shuttle', icon: Icons.airport_shuttle),
  IconModel(title: 'Home', icon: Icons.home),
  IconModel(title: 'Dice', icon: Icons.casino),
  IconModel(title: 'Refrigerator', icon: Icons.kitchen),
];
