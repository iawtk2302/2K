import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/bloc/cart/card_bloc.dart';
import 'package:sneaker_app/screen/CartPage.dart';
import 'package:sneaker_app/screen/FillProfilePage.dart';
import 'package:sneaker_app/screen/HomePage.dart';
import 'package:sneaker_app/screen/OrdersPage.dart';
import 'package:sneaker_app/screen/ProfilePage.dart';
import 'package:sneaker_app/screen/enter_pin_code.dart';

import '../bloc/home/user_bloc.dart';
import '../widget/Loading.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pages = [
    const HomePage(),
    const CartPage(),
    const OrdersPage(),
    const ProfilePage(),
    const FillProfilePage(),
    const EnterPinCode(
      text: 'Add a Pin number to make your account more secure',
    )
  ];
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // bool firstAuth=false;
  // bool isLoading=true;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _checkFirstAuth();
  // }

  // _checkFirstAuth()async{
  // await FirebaseFirestore.instance
  //   .collection('User')
  //   .doc(FirebaseAuth.instance.currentUser!.uid)
  //   .get()
  //   .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       print('Document data: ${documentSnapshot.data()}');
  //       setState(() {
  //         isLoading=false;
  //       });
  //     } else {
  //       setState(() {
  //         firstAuth=true;
  //         isLoading=false;
  //       });
  //     }
  //   });
  // }
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(LoadInfoUser());
    super.initState();
  }

  int currentIndex = 0;
  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Loading();
        } else if (state is UserExistExceptPinCode) {
          return const EnterPinCode(
            text: 'Add a Pin number to make your account more secure',
          );
        } else if (state is UserNotExist) {
          return FillProfilePage();
        } else if (state is UserExist) {
          return Scaffold(
            body: pages[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Theme.of(context).backgroundColor,
                currentIndex: currentIndex,
                onTap: onTap,
                elevation: 0,
                selectedItemColor: Theme.of(context).textTheme.bodyText2!.color,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home".tr,
                  ),
                  BottomNavigationBarItem(
                      icon: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if(state is CartLoaded){
                            if(state.cart.products.length==0){
                              return Icon(Icons.shopping_bag);
                            }else if(state.cart.products.length>0&&state.cart.products.length<10){
                              return Badge(
                              label: Text(state.cart.products.length.toString()),
                              child: Icon(Icons.shopping_bag));
                            }
                            else{
                              return Badge(
                              label: Text("9+"),
                              child: Icon(Icons.shopping_bag));
                            }
                          }
                          else{
                            return Icon(Icons.shopping_bag);
                          }
                        },
                      ),
                      label: "Cart".tr),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: "Orders".tr),    
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile".tr),
                ]),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}
