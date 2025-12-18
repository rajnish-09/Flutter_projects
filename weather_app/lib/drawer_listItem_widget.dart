import 'package:flutter/material.dart';
class DrawerListItem extends StatelessWidget {
  final String title;
  final Function(String) changeWeather;
  const DrawerListItem({
    super.key,
    required this.title,
    required this.changeWeather,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.location_on, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        changeWeather(title);
        Navigator.pop(context);
      },
    );
  }
}