import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/bloc/seach/bloc/search_bloc.dart';
import 'package:sneaker_app/modal/brand.dart';
import 'package:sneaker_app/modal/product.dart';
import 'package:sneaker_app/widget/Loading.dart';
import 'package:sneaker_app/widget/item_product_without_anim.dart';

class PageTest extends StatefulWidget {
  const PageTest({super.key, this.searchText});
  final searchText;
  @override
  State<PageTest> createState() => _PageTest();
}

class _PageTest extends State<PageTest> {
  bool isLoading=true;
  final firestore=FirebaseFirestore.instance.collection('Product');
  RangeValues values=const RangeValues(0.0, 1500.0);
  List<Product>listProduct=[];
  List<Product>listProductCore=[];
  List<String>listBrand=['All'];
  List<String>listGender=['All','Men','Women'];
  List<String>listSort=['Price High','Price Low',];
  int currentCategory=0; 
  int currentGender=0; 
  int currentSort=0; 
  SearchLoaded? searchLoaded;
  @override
  void initState() {
    // TODO: implement initState
    // context.read()<SearchBloc>().add(LoadProductSearch(widget.searchText));
    getData();
    super.initState(); 
  }
  getData(){
    // context.read()<SearchBloc>().add(LoadProductSearch(widget.searchText.toString()));
    BlocProvider.of<SearchBloc>(context).add(LoadProductSearch(widget.searchText));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.chevron_left,color: Colors.black,),onPressed: (){Navigator.pop(context);},),
        title: Center(child: Text(widget.searchText,style: TextStyle(color: Colors.black),)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(icon: Icon(Icons.tune,color: Colors.black,),onPressed: _showBottomSheetFilter),
          )
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if(state is SearchLoading){            
            return Loading();
          }
          else if(state is SearchLoaded)
          {
            searchLoaded=state;
            return SearchLoadedPage(state);
          }
          else{
            return Container();
          }
      },)
      // body: Container(),
    );


  }
  Widget _notfound(){
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
              image: AssetImage('assets/images/clipboard.png')),
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
  _showBottomSheetFilter(){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) { 
      return StatefulBuilder(builder: (context, state) {
        Size size =MediaQuery.of(context).size;
        RangeLabels rangeLabels= RangeLabels(values.start.toString(), values.end.toString());
        return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
          color: Colors.white
        ),
        height: size.height*0.72,
        child: Column(children: [
          SizedBox(height: 6,),
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFFE2E2E2),
            ),
          ),
          SizedBox(height: 20),
          Text('Sort & Filter',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Color(0xFFE2E2E2),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Align(
              alignment: Alignment.centerLeft,
              child: Text('Categories', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
            SizedBox(height: 15),
            Container(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: searchLoaded!.listBrand.length,
                itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){state(() {
                    currentCategory=index;
                  });},
                  child: FilerItem(name: searchLoaded!.listBrand[index], isChoose: currentCategory, index: index));
              },),
            ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Align(
              alignment: Alignment.centerLeft,
              child: Text('Gender', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
            SizedBox(height: 15),
            Container(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: searchLoaded!.listGender.length,
                itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){state(() {
                    currentGender=index;
                  });},
                  child: FilerItem(name: searchLoaded!.listGender[index], isChoose: currentGender, index: index));
              },),
            ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Price Range', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
          ),
          SizedBox(height: 15),
            
            RangeSlider(
              values: values, 
              min: 0,
              max: 1500,
              divisions: 10,
              activeColor: Colors.black,
              inactiveColor: Color(0xFFE6E6E6),
              labels: rangeLabels,
              onChanged: (value) {
                state(() {
                  values=value;
                });
              },),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Align(
              alignment: Alignment.centerLeft,
              child: Text('Sort by', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
            SizedBox(height: 15),
            Container(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: searchLoaded!.listSort.length,
                itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){state(() {
                    currentSort=index;
                  });},
                  child: FilerItem(name: searchLoaded!.listSort[index], isChoose: currentSort, index: index));
              },),
            ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Color(0xFFE2E2E2),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              InkWell(
                onTap: (){},
                child: Container(
                  height: 60,
                  width: 170,
                  child: Center(child: Text('Reset',style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
              ),
              InkWell(
                onTap: (){_filter();},
                child: Container(
                  height: 60,
                  width: 170,
                  child: Center(child: Text('Apply',style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
              ),
            ],),
          )
        ]),
      );
      },);
     });
  }
  _filter(){
    BlocProvider.of<SearchBloc>(context).add(FilterProduct(widget.searchText.toString(),searchLoaded!.listBrand[currentCategory] , searchLoaded!.listGender[currentGender], values, searchLoaded!.listSort[currentSort]));
  }
  SearchLoadedPage(SearchLoaded state){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:state.listSearch.isEmpty?_notfound():Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Results for '+'"'+"${widget.searchText}"+'"',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  state.listSearch.length==1?Text(state.listSearch.length.toString()+' found',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)):Text(state.listSearch.length.toString()+' founds',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Expanded(
              child: GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 20,
                              childAspectRatio: 0.65,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                            ),
                            children: 
                              state.listSearch.map((e) => ItemProductWithoutAnim(product: e,isLiked: false,key: Key(e.idProduct.toString()),)).toList()
                            ,
                            )                         
            )
          ],
        ),
      );
  }
}
class FilerItem extends StatelessWidget {
  const FilerItem({
    Key? key,
    required this.name,
    required this.isChoose,
    required this.index,
  }) : super(key: key);
  final String name;
  final int isChoose;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.9),
            color: isChoose == index ? Colors.black : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            name,
            style: TextStyle(
                color: isChoose == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist',
                fontSize: 16),
          ),
        ));
  }
}