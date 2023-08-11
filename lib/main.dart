


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/view/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<String>('data');
  
  runApp(const ProviderScope(child: Home()));
}


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return ScreenUtilInit(
      designSize: const Size(414, 861),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(

            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(

                textTheme: GoogleFonts.interTextTheme(
                  Theme.of(context).textTheme.apply(
                      bodyColor: Colors.white,
                      displayColor: Colors.white
                  ),
                ),
                scaffoldBackgroundColor: Colors.black,
                appBarTheme: const AppBarTheme(
                    color: Colors.black
                )
            ),
            home:   HomePage()
        );
      },
    );
  }
}
