import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps/screens/widget/splash.dart';
import 'package:google_maps/view_models/addressess_view_model.dart';
import 'package:google_maps/view_models/adressesViewModel.dart';
import 'package:google_maps/view_models/location_view_model.dart';
import 'package:google_maps/view_models/map_view_model.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MapsViewModel()),
      ChangeNotifierProvider(create: (_) => AddressesViewModel()),
      ChangeNotifierProvider(create: (_) => AddressesViewModel2()),
      ChangeNotifierProvider(create: (_) => LocationViewModel()),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);

          return  MaterialApp(

            debugShowCheckedModeBanner: false,
            home: const MySplashScreen(),
          );


      },
    );
  }
}



