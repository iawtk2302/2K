import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/screen/CartPage.dart';
import 'package:sneaker_app/screen/FillProfilePage.dart';
import 'package:sneaker_app/screen/HomePage.dart';
import 'package:sneaker_app/screen/OrdersPage.dart';
import 'package:sneaker_app/screen/ProfilePage.dart';

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
    const FillProfilePage()
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
        if (state is UserInitial) {
          return Loading();
        } else if (state is UserNotExist) {
          return FillProfilePage();
        } else if (state is UserExist) {
          return Scaffold(
            body: pages[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                currentIndex: currentIndex,
                onTap: onTap,
                elevation: 0,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_bag), label: "Cart"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: "Orders"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ]),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}
