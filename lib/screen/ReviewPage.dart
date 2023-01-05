import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sneaker_app/widget/CustomAppBar.dart';
import 'package:sneaker_app/widget/Loading.dart';

import '../bloc/review/bloc/review_bloc.dart';
import '../model/product.dart';
import '../model/review.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage({super.key, required this.product});
  final Product product;
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    BlocProvider.of<ReviewBloc>(context).add(LoadReview(widget.product));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Review',
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if(state is ReviewLoading){
          return Loading();
        }
        else if(state is ReviewLoaded){
          return Column(
          children: [
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.listCategory.length,
                  itemBuilder: (context, index) {
                  return state.listCategory[index]!=state.selectedCategory?_itemCategory(state.listCategory[index],(){
                    BlocProvider.of<ReviewBloc>(context).add(ChooseCategory(state.listCategory[index]));
                  },context):_itemSelectedCategory(state.listCategory[index],(){},context);
                },),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: state.listReview.length,
                  itemBuilder: (context, index) {
                  return _ItemReview(state.listReview[index],context);
                },),
              ),)
          ],
        );
        }
        else{
          return Container();
        }
      },
      ),
    );
  }
}

Widget _itemCategory(String category,Function() onTap, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Container(
        height: 35,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 2,color: Theme.of(context).canvasColor),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.star_rate), SizedBox(width: 6), Text(category,style: TextStyle(fontWeight: FontWeight.w600),)]),
      ),
    ),
  );
}
Widget _itemSelectedCategory(String category,Function() onTap,BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Container(
        height: 35,
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 2,color: Theme.of(context).canvasColor),
          color: Theme.of(context).canvasColor
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.star_rate,color: Colors.white,), SizedBox(width: 6), Text(category,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),)]),
      ),
    ),
  );
  
}

String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' day ago';
      } else {
        time = diff.inDays.toString() + ' days ago';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' weeks ago';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' weeks ago';
      }
    }

    return time;
  }
Widget _ItemReview(Review review, BuildContext context){
  
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Row(children: [CircleAvatar(backgroundImage: NetworkImage(review.image!),backgroundColor: Colors.transparent),
          SizedBox(width:10),
          Text(review.fullName!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),],),
          Container(
          height: 30,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 2,color: Theme.of(context).canvasColor),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.star_rate,size: 16,), SizedBox(width: 6), 
              Text(review.star.toString(),style: TextStyle(fontWeight: FontWeight.w600),)]),
        ),
        ],),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(review.content!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        ),
        Text(readTimestamp(review.dateCreated!.seconds))
      ],),
    ),
  );
}