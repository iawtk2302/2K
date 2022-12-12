import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  const CustomAppBar({super.key, required this.title, this.onTap});
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: InkWell(
          onTap: onTap,
          child: Icon(Icons.chevron_left,size: 26,),
        ),
        title: Text(
          title,
          style: TextStyle( fontWeight: FontWeight.w600),
        ),
      );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}