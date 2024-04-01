import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../utils/colors/app_colors.dart';
import '../../view_models/map_view_model.dart';
import '../ui/ui/addresses_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 7));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddressesScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MapsViewModel>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        // title: Text("Splash Screen"),
      ),
      body: Expanded(
        child: Center(
          child: Lottie.asset('assets/lottie/my_lottie.json'),
        ),
      )
    );
  }
}