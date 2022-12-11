import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final Function() onTap;
  final Icon icon;
  final Text title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: title,
    );
  }
}
