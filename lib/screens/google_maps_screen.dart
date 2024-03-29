import 'package:flutter/material.dart';
import 'package:google_maps/screens/widgets/map_type_item.dart';
import 'package:google_maps/services/local_notification_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../utils/images/app_images.dart';
import '../view_models/location_view_model.dart';
import '../view_models/maps_view_model.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({
    super.key,
  });

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  @override
  Widget build(BuildContext context) {
    CameraPosition? cameraPosition;
    LatLng? latLng = context.watch<LocationViewModel>().latLng;

    return Scaffold(
      body: Consumer<MapsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.initialCameraPosition == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              GoogleMap(
                markers: viewModel.markers,
                onCameraIdle: () {
                  LocalNotificationService().showNotification(
                    title: "Diqqat!!!",
                    body: "Foydalanuvchining joriy koordinatasi: (${latLng?.latitude}, ${latLng?.longitude}) ga o'zgardi!!!",
                    id: DateTime.now().millisecond.toInt(),
                  );

                  if (cameraPosition != null) {
                    context
                        .read<MapsViewModel>()
                        .changeCurrentLocation(cameraPosition!);
                     context.read<MapsViewModel>().addNewMarker();
                  }
                  // ScaffoldMessenger.of(context)
                  //     .showSnackBar(const SnackBar(content: Text("IDLE")));
                },
                onCameraMove: (CameraPosition currentCameraPosition) {
                  cameraPosition = currentCameraPosition;
                  debugPrint(
                      "CURRENT POSITION:${currentCameraPosition.target.longitude}");
                },
                mapType: viewModel.mapType,
                initialCameraPosition: viewModel.initialCameraPosition!,
                onMapCreated: (GoogleMapController createdController) {
                  viewModel.controller.complete(createdController);
                },
              ),
              Align(
                child: Image.asset(
                  AppImages.location,
                  width: 50,
                  height: 50,
                ),
              )
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<MapsViewModel>().moveToInitialPosition();
            },
            child: const Icon(Icons.gps_fixed),
          ),
          const SizedBox(width: 20),
          const MapTypeItem(),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () {
              context.read<MapsViewModel>().moveToInitialPosition();
            },
            child: const Icon(Icons.add_location_alt),
          ),
        ],
      ),
    );
  }

  _showMapTypePopup() {
    // show
  }
}
