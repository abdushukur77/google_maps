import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../utils/colors/app_colors.dart';
import '../view_models/location_view_model.dart';
import '../view_models/maps_view_model.dart';
import 'google_maps_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LocationViewModel>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            LatLng? latLng = context.read<LocationViewModel>().latLng;
            if (latLng != null) {
              Provider.of<MapsViewModel>(context, listen: false)
                  .setLatInitialLong(latLng);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GoogleMapsScreen();
                  },
                ),
              );
            }
          },
          child: Text("MAP"),
        ),
      ),
    );
  }
}
