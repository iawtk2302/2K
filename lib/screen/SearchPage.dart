import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/bloc/seach/bloc/search_bloc.dart';
import 'package:sneaker_app/model/historySearch.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/widget/CustomSearch.dart';
import 'package:sneaker_app/widget/Loading.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  final firestore = FirebaseFirestore.instance
      .collection('historySearch')
      .withConverter<HistorySearch>(
        fromFirestore: (snapshot, _) =>
            HistorySearch.fromJson(snapshot.data()!),
        toFirestore: (history, _) => history.toJson(),
      );
  late List<String> listSearchLocal;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    check();
  }

  check() async {
    await firestore
        .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        await firestore.doc(FirebaseAuth.instance.currentUser!.uid).set(
            HistorySearch(
                idUser: FirebaseAuth.instance.currentUser!.uid, search: []));
        // listSearch=[];
        listSearchLocal = [];
      }
      // else{
      //   listSearch=value.docs.first.data().search;
      // }
      // return listSearch;
      else {
        listSearchLocal =
            value.docs.first.data().search.map((e) => e as String).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20),
                  child: CustomSearch(
                    hintText: "Seach".tr,
                    prefixIcon: Icon(Icons.search),
                    // suffixIcon: Icon(Icons.tune),
                    onSubmitted: _onSubmitted,
                    controller: searchController,
                  ),
                ),
                // CustomSearch(hintText: "Seach", prefixIcon: Icon(Icons.search), suffixIcon: Icon(Icons.tune)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Recent".tr,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () async {
                          listSearchLocal.clear();
                          await firestore
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({'search': []});
                        },
                        child: Text('Clear All'.tr,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    height: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: firestore
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loading();
                      }
                      final data = snapshot.data!.data();
                      if (data?.search != null) {
                        final listSearch =
                            data!.search.map((e) => e as String).toList();
                        return ListView.builder(
                          itemCount: data.search.length,
                          itemBuilder: (context, index) {
                            return ItemSearch(
                                data.search[index], index, listSearch);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Center(child: RawMaterialButton(
  onPressed: () {
    Navigator.pop(context);
  },
  elevation: 2.0,
  fillColor: Theme.of(context).cardColor,
  child: Icon(
    Icons.close,
    size: 35.0,
  ),
  padding: EdgeInsets.all(12.0),
  shape: CircleBorder(),
)),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  _onSubmitted(String text) async {
    listSearchLocal.insert(0, text);
    // listSearchLocal.add(text);

    Navigator.pushNamed(context, Routes.searchResult1, arguments: text);
    await firestore
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'search': listSearchLocal});
  }

  Widget ItemSearch(String text, int index, List<String> data) {
    return InkWell(
      onTap: () {
        // context.read()<SearchBloc>().add(LoadProductSearch(text));
        Navigator.pushNamed(context, Routes.searchResult1, arguments: text);
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return PageTest();
        // },));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
              onPressed: () async {
                listSearchLocal.remove(text);
                data.removeAt(index);
                await firestore
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({'search': data});
              },
              icon: Icon(Icons.clear))
        ],
      ),
    );
  }
}
