import 'package:flutter/material.dart';

class SearchScreen1 extends StatefulWidget {
  const SearchScreen1({super.key});

  @override
  State<SearchScreen1> createState() => _SearchScreen1State();
}

class _SearchScreen1State extends State<SearchScreen1> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children:[
        ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.black,
                ),
          ),
          child: Material(
            color: Color(0xFFF5F5F5),
            child: TextField(
                onTap: () async {
                  
                },
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),
                )),
          ),
        ),
      ),
    )
      ]
    ),);
  }
}