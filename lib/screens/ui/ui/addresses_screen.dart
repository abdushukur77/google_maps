import 'package:flutter/material.dart';
import 'package:google_maps/screens/ui/ui/ui.dart';
import 'package:google_maps/screens/ui/ui/uptade_map.dart';
import 'package:google_maps/utils/tools/file_importer.dart';
import 'package:lottie/lottie.dart';

import '../../../data/model/place_category.dart';
import '../../../data/model/place_model.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../../view_models/adressesViewModel.dart';
import '../../../view_models/location_view_model.dart';


class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mening adreslarim"),
        actions: [
          TextButton(
            onPressed: () {
              context.read<AddressesViewModel2>().deleteAllPlaces();
            },
            child: const Text("Hammasini \n o'chirish"),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<PlaceModel>>(
              stream: context.read<AddressesViewModel2>().listenProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Center(
                      child: Lottie.asset('assets/lottie/my_lottiee.json'),
                    ),
                  );
                } else {
                  List<PlaceModel> myAddresses = snapshot.data!;
                  return ListView.builder(
                    itemCount: myAddresses.length,
                    itemBuilder: (context, index) {
                      var myAddress = myAddresses[index];
                      IconData icon = getIcon(myAddress.placeCategory);
                      List<String> splitPlaceName =
                      myAddress.placeName.split(' ');
                      String placeName = '';
                      splitPlaceName.removeRange(0, 1);
                      splitPlaceName.forEach((element) {
                        placeName += element;
                        placeName += " ";
                      });

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UpdateAddressScreen(
                                  placeModel: myAddress,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          margin: const EdgeInsets.all(12),
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(3, 3),
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    icon,
                                    size: 36,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      "${myAddress.placeCategory}\n$placeName",
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.recolateMedium.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    context.read<AddressesViewModel2>().deletePlace(myAddress.docId!);
                                  }, icon: Icon(Icons.delete))
                                ],
                              ),

                            ],
                          ),

                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<LocationViewModel>().getUserLocation();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GoogleMapsScreen(),
                ),
              );
            },
            child: Container(
              height: 56.h,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 3),
                    color: Colors.black,
                    blurRadius: 12,
                  )
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Yangi adress qo'shish",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}