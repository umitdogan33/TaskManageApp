import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  CustomAppBar({super.key,required this.title});
  late String title;

  @override
  Widget build(BuildContext context) {
   return AppBar(
        title: Text(title.toString()),
        backgroundColor: Colors.amber[800],
        automaticallyImplyLeading: false,
      );
  }

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}