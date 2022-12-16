import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneaker_app/bloc/address/address_bloc.dart';
import 'package:sneaker_app/bloc/cart/card_bloc.dart';
import 'package:sneaker_app/bloc/home/home_bloc.dart';
import 'package:sneaker_app/bloc/home/user_bloc.dart';
import 'package:sneaker_app/bloc/list_order/list_order_bloc.dart';
import 'package:sneaker_app/bloc/my_order/my_order_bloc.dart';
import 'package:sneaker_app/bloc/order/order_bloc.dart';
import 'package:sneaker_app/bloc/review/bloc/review_bloc.dart';
import 'package:sneaker_app/bloc/seach/bloc/search_bloc.dart';
import 'package:sneaker_app/model/product.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/screen/AddAddress.dart';
import 'package:sneaker_app/screen/AuthPage.dart';
import 'package:sneaker_app/screen/CartPage.dart';
import 'package:sneaker_app/screen/CheckoutPage.dart';
import 'package:sneaker_app/screen/ChooseAddressPage.dart';
import 'package:sneaker_app/screen/ChooseVoucherPage.dart';
import 'package:sneaker_app/screen/FillProfilePage.dart';
import 'package:sneaker_app/screen/ForgotPassPage.dart';
import 'package:sneaker_app/screen/HomePage.dart';
import 'package:sneaker_app/screen/LoginPage.dart';
import 'package:sneaker_app/screen/MainPage.dart';
import 'package:sneaker_app/screen/Register.dart';
import 'package:sneaker_app/screen/PageTest.dart';
import 'package:sneaker_app/screen/ReviewPage.dart';
import 'package:sneaker_app/screen/SearchPage.dart';
import 'package:sneaker_app/screen/SearchResultPage.dart';
import 'package:sneaker_app/screen/SplashScreen.dart';
import 'package:sneaker_app/screen/enter_pin_code.dart';
import 'package:sneaker_app/themes/Colors.dart';
import 'package:sneaker_app/themes/LanguageService.dart';
import 'package:sneaker_app/themes/ThemeService.dart';

import 'bloc/product/product_bloc.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await showFlutterNotification(message);
}

Future<void> showFlutterNotification(RemoteMessage message) async {
  print(message.data);
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: -1, // -1 is replaced by a random number
      channelKey: 'alerts',
      title: message.data['title'],
      body: message.data['body'],
      // bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
      largeIcon: message.data['url'],
      //'asset://assets/images/balloons-in-sky.jpg',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  await GetStorage.init();
  Future<String?> messaging =
      FirebaseMessaging.instance.getToken().then((value) {
    print(value);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await AwesomeNotifications().initialize(
      null, //'resource://drawable/res_app_icon',//
      [
        NotificationChannel(
            channelKey: 'alerts',
            channelName: 'Alerts',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            onlyAlertOnce: true,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: Colors.black,
            ledColor: Colors.black)
      ],
      debug: true);
  FirebaseMessaging.onMessage.listen(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()..add(LoadHome())),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => AddressBloc()),
        BlocProvider(create: (context) => UserBloc()..add(LoadInfoUser())),
        BlocProvider(create: (context) => CartBloc()..add(LoadCart())),
        BlocProvider(create: (context) => MyOrderBloc()..add(LoadMyOrder())),
        BlocProvider(create: (context) => ListOrderBloc()),
        BlocProvider(create: (context) => ReviewBloc())
      ],
      child: GetMaterialApp(
        translations: LocalizationService(),
        locale: LocalizationService().locale,
        title: '2K',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        onGenerateRoute: getRoute,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeService().theme,
      ),
    );
  }
}

Route? getRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      {
        return MaterialPageRoute(
            builder: (context) => const LoginPage(), settings: settings);
      }
    case Routes.register:
      {
        return MaterialPageRoute(
            builder: (context) => const RegisterPage(), settings: settings);
      }
    case Routes.forgot:
      {
        return MaterialPageRoute(
            builder: (context) => const ForgotPassPage(), settings: settings);
      }
    case Routes.home:
      {
        return MaterialPageRoute(
            builder: (context) => const HomePage(), settings: settings);
      }
    case Routes.main:
      {
        return MaterialPageRoute(
            builder: (context) => const MainPage(), settings: settings);
      }
    case Routes.fillProfilePage:
      {
        return MaterialPageRoute(
            builder: (context) => const FillProfilePage(), settings: settings);
      }
    case Routes.auth:
      {
        return MaterialPageRoute(
            builder: (context) => const AuthPage(), settings: settings);
      }
    case Routes.search:
      {
        return MaterialPageRoute(
            builder: (context) => const SearchPage(), settings: settings);
      }
    case Routes.searchResult:
      {
        final value = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => SearchResultPage(
                  searchText: value,
                ),
            settings: settings);
      }
    case Routes.addAddress:
      {
        return MaterialPageRoute(
            builder: (context) => const AddAddressPage(), settings: settings);
      }
    case Routes.searchResult1:
      {
        final value = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => PageTest(
                  searchText: value,
                ),
            settings: settings);
      }
    case Routes.checkout:
      {
        final listProduct = settings.arguments as List<ProductCart>;
        return MaterialPageRoute(
            builder: (context) => CheckoutPage(listProduct: listProduct),
            settings: settings);
      }
    case Routes.chooseAddress:
      {
        return MaterialPageRoute(
            builder: (context) => const ChooseAddressPage(),
            settings: settings);
      }
    case Routes.chooseVoucher:
      {
        return MaterialPageRoute(
            builder: (context) => const ChooseVoucherPage(),
            settings: settings);
      }
    case Routes.review:
      {
        final product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (context) => ReviewPage(
                  product: product,
                ),
            settings: settings);
      }
    case Routes.enterPin:
      {
        final text = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => EnterPinCode(
                  text: text,
                ),
            settings: settings);
      }
  }
  return null;
}
