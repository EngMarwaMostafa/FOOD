import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/providers/wishlist_provider.dart';
import 'package:food_app/screens/Home/home_screen.dart';
import 'package:food_app/screens/my_profile/my_profile.dart';
import 'package:food_app/screens/productOverview/productOverview.dart';
import 'package:food_app/screens/search/search.dart';
import 'package:provider/provider.dart';
import 'auth/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
   providers: [
     ChangeNotifierProvider<ProductProvider>(
         create:(context)=>ProductProvider(),
     ),
     ChangeNotifierProvider<ReviewCartProvider>(
     create:(context)=>ReviewCartProvider(),
     ),
    ChangeNotifierProvider<WishListProvider>(
    create:(context)=>WishListProvider(),
    ),
     ChangeNotifierProvider<CheckOutProvider>(
       create:(context)=>CheckOutProvider(),
     ),
   ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: scaffoldBackgroundColor),
        debugShowCheckedModeBanner: false,
    home: StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapShot) {
    if (snapShot.hasData) {
    return HomeScreen();
    }
    return SignIn();
    },
    ),
    ),
    );
  }
}

