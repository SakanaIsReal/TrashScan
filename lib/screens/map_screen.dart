import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/trash_information_model.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng _sourceLocation = const LatLng(37.7749, -122.4194);
  Set<Marker> _markers = {};
  Map<String, BitmapDescriptor> _markerIcons = {}; // Stores loaded icons by category

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadMarkerIcons(); // Load all custom marker icons
  }

  Future<void> _loadMarkerIcons() async {
    final trashCategories = TrashInformationModel.getCategories();
    
    for (var category in trashCategories) {
      try {
        final icon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(100, 130)),
          category.markerPath,
        );
        _markerIcons[category.name] = icon;
      } catch (e) {
        print("Failed to load marker icon for ${category.name}: $e");
        // Fallback to default icon
        _markerIcons[category.name] = BitmapDescriptor.defaultMarker;
      }
    }

    // print(_markerIcons);
    
    // Ensure markers are updated after icons load
    if (_sourceLocation != const LatLng(37.7749, -122.4194)) {
      _updateMarkers();
    }
  }

  Future<void> _getCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _sourceLocation = LatLng(position.latitude, position.longitude);
        _updateMarkers();
      });

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_sourceLocation, 19.0),
        );
      }
    } else {
      print("Location permission denied");
    }
  }

  void _updateMarkers() {
    final trashCategories = TrashInformationModel.getCategories();
    Set<Marker> newMarkers = {};

    // Add current location marker
    newMarkers.add(
      Marker(
        markerId: MarkerId("current_location"),
        position: _sourceLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: "Your Location"),
      ),
    );

    // Add trash location markers with custom icons
    for (var category in trashCategories) {
      if (category.trashLoc != null && category.trashLoc!.isNotEmpty) {
        for (int i = 0; i < category.trashLoc!.length; i++) {
          final location = category.trashLoc![i];
          newMarkers.add(
            Marker(
              markerId: MarkerId("${category.id}_$i"),
              position: location,
              icon: _markerIcons[category.name] ?? BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: category.name,
                snippet: "${category.tags.join(', ')}",
              ),
              onTap: () {
                _showTrashInfoDialog(category);
              },
            ),
          );
        }
      }
    }

    setState(() {
      _markers = newMarkers;
    });
  }

  void _showTrashInfoDialog(TrashInformationModel category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(category.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (category.imagePath.isNotEmpty)
                Image.asset(category.imagePath, height: 100),
              SizedBox(height: 10),
              Text("Total: ${category.total}"),
              SizedBox(height: 10),
              category.description,
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: category.tags
                    .map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: category.color.withOpacity(0.2),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // You could add navigation functionality here
            },
            child: Text("Directions"),
          ),
        ],
      ),
    );
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
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _updateMarkers();
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 3),
    );
  }
}
