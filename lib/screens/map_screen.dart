import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController; // Change late to nullable
  LatLng _sourceLocation = const LatLng(37.7749, -122.4194); // Default (San Francisco)
  LatLng _destination = const LatLng(13.792020, 100.319452);



  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _sourceLocation = LatLng(position.latitude, position.longitude);
      });

      // Ensure _mapController is initialized before using it
      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLng(_sourceLocation));
      }
    } else {
      print("Location permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _sourceLocation,
          zoom: 19.0,
        ),
        markers: {
          Marker(markerId: MarkerId("source"),
          position: _sourceLocation),
          Marker(markerId: MarkerId("destinaion"),
          position: _destination)
        },
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller; // Initialize _mapController here
        },
        myLocationEnabled: true, // Show blue dot for user's location
        myLocationButtonEnabled: true,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 3,
      ),
    );
  }
}
