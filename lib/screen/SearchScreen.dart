import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/modal/product.dart';
import 'package:sneaker_app/widget/Loading.dart';

import '../widget/item_product_without_anim.dart';

class CustomSearchScreen extends SearchDelegate {
  CustomSearchScreen(this.hintText);
  final String hintText;
  final _firestore=FirebaseFirestore.instance.collection('Product');
  
                           
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if(query.isEmpty){
              close(context, query);
            }
            else{
              query='';
              showSuggestions(context);
            }
          },
          icon: const Icon(
            Icons.clear,
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
    if(query!=''){
      return StreamBuilder<QuerySnapshot>(
    stream: _firestore.snapshots().asBroadcastStream(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData){
        return const Loading();
      } 
      else{
        // final results = snapshot.data?.docs.where((QueryDocumentSnapshot a) => a['name'].toString().toLowerCase().contains(query.toLowerCase())).map((e) => Product.fromJson(e));
        print(snapshot.data);
      final results=snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> a) => a['name'].toString().toLowerCase().contains(query.toLowerCase()));
      if(!results.isEmpty){
        return Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                          ),
                  children: results.map((QueryDocumentSnapshot<Object?> element) {
                  // final data=Product(
                  //           gender: element.get('gender') as List<dynamic>,
                  //           idCategory: element.get('idCategory'),
                  //           description: element.get('description'),
                  //           name: element.get('name'),
                  //           idProduct: element.get('idProduct'),
                  //           image: element.get('image') as List<dynamic>,
                  //           price: element.get('price'));
                    // return ItemProductWithoutAnim(
                    //   product: data,
                    //   isLiked: false,
                    // );
                    return Container();
                    // return Text(data.image![0].toString());
                  }).toList(),),
            ),
          ),
        ],
      );
      }
      else{
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
              image: AssetImage(
                  'assets/images/clipboard.png'),
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
      }  
    },
  );
    }
    else{
      return Container();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  //   return StreamBuilder(
  //   stream: FirebaseFirestore.instance.collection('Product').snapshots(),
  //   builder: (context, snapshot) {
  //     if (!snapshot.hasData) return const Loading();
  //     final results = snapshot.data?.docs.where((DocumentSnapshot a) => a['name'].toString().toLowerCase().contains(query.toLowerCase()));
  //     return ListView(
  //       children: results!.map<Widget>((a) => InkWell(onTap: () {
          
  //         // query=a['name'];
  //         // buildResults(context);
  //       }, child: Text(a['name']))).toList(),
  //     );
  //   },
  // );
  return Container();
  }
  
}
