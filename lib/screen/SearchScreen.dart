import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomSearchScreen extends SearchDelegate {
  CustomSearchScreen(this.hintText);
  final String hintText;
  List<String> allData = [
    'Nike',
    'Adidas',
    'Puma',
    'Vans',
    'Balenciaga',
    'Converse',
    'New balance'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.tune,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(
          Icons.arrow_back,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    print('1');

    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    if (matchQuery.length != 0) {
      return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: ((context, index) {
            var results = matchQuery[index];
            return ListTile(
              title: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('results'),
              ),
            );
          }));
    } else
      return Center(
        child: Text('bnu;;'),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    if (matchQuery.length != 0) {
      return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: ((context, index) {
            var results = matchQuery[index];
            return InkWell(
              onTap: () {
                final snackBar = SnackBar(
                  content: const Text('Yay! A SnackBar!'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      results,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    IconButton(
                        splashRadius: 25,
                        onPressed: () {},
                        icon: Icon(Icons.cancel_presentation))
                  ],
                ),
              ),
            );
          }));
    } else
      return Center(
        child: Column(
          children: [
            Spacer(),
            Spacer(),
            Spacer(),
            Spacer(),
            Spacer(),
            Image(
              width: MediaQuery.of(context).size.width - 120,
              image: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/sneakerapp-f4de5.appspot.com/o/clipboard.png?alt=media&token=18e3b67e-a0f2-49bb-b1dc-eb78caeb138e'),
            ),
            Spacer(),
            Text(
              'Not found',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Sorry, the keyword you entered can\'t be found. Please check again or search with another keyword',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
      );
  }

  @override
  void showResults(BuildContext context) {}
}
