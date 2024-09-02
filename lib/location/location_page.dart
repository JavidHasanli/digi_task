import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'location_service.dart';  // LocationService faylını import edin

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locationService = Provider.of<LocationService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LAT: ${locationService.currentPosition?.latitude ?? ""}'),
              Text('LNG: ${locationService.currentPosition?.longitude ?? ""}'),
              Text('ADDRESS: ${locationService.currentAddress ?? ""}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // İstifadəçi düyməyə basdığında yer məlumatlarını yenidən almaq üçün
                  locationService.startGettingLocation();
                },
                child: const Text("Get Current Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
