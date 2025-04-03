import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/trash_information_model.dart';
import '../widgets/info_sheet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng _sourceLocation = const LatLng(37.7749, -122.4194);
  Set<Marker> _markers = {};
  Map<String, BitmapDescriptor> _markerIcons = {};
  Set<Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  String googleApiKey =
      'AIzaSyDjVU2xefEGyRXpfjNiDBZlU6YosNzYfyQ'; // Replace with your API key
  bool _showLegend = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadMarkerIcons();
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
        _markerIcons[category.name] = BitmapDescriptor.defaultMarker;
      }
    }

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
    // newMarkers.add(
    //   Marker(
    //     markerId: MarkerId("current_location"),
    //     position: _sourceLocation,
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    //     infoWindow: InfoWindow(title: "Your Location"),
    //   ),
    // );

    // Add trash location markers with custom icons
    for (var category in trashCategories) {
      if (category.trashLoc != null && category.trashLoc!.isNotEmpty) {
        for (int i = 0; i < category.trashLoc!.length; i++) {
          final location = category.trashLoc![i];
          newMarkers.add(
            Marker(
              markerId: MarkerId("${category.id}_$i"),
              position: location,
              icon:
                  _markerIcons[category.name] ?? BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: category.name,
                snippet: "${category.tags.join(', ')}",
              ),
              onTap: () {
                _showTrashInfoDialog(category, location);
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

  void _showTrashInfoDialog(
      TrashInformationModel category, LatLng markerPosition) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(category.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 300, child: buildTags(category.tags, category.color)),
              SizedBox(height: 10),
              if (category.imagePath.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset(
                      category.imagePath,
                      height: 100,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: 10),
              Text("Total: ${category.total}"),
              SizedBox(height: 10),
              category.description,
              SizedBox(height: 10),
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
              _getPolyline(markerPosition);
            },
            child: Text("Directions"),
          ),
        ],
      ),
    );
  }

  Future<void> _getPolyline(LatLng destination) async {
    // Clear previous polylines
    _polylines.clear();

    try {
      // Make the request
      final result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleApiKey, // Your API key
        request: PolylineRequest(
          origin:
              PointLatLng(_sourceLocation.latitude, _sourceLocation.longitude),
          destination: PointLatLng(destination.latitude, destination.longitude),
          mode: TravelMode.walking, // or .walking, .bicycling
          // wayPoints: [] // Optional waypoints if needed
        ),
      );

      // Debug print to check response
      print('API Response: ${result.points.length} points received');

      if (result.points.isNotEmpty) {
        // Convert points to LatLng list
        final polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        // Update the map
        setState(() {
          _polylines.add(
            Polyline(
              polylineId: PolylineId(
                  'route_to_${destination.latitude}_${destination.longitude}'),
              color: Colors.blue,
              points: polylineCoordinates,
              width: 5,
            ),
          );
        });

        // Zoom to show the whole route
        _mapController?.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                min(_sourceLocation.latitude, destination.latitude),
                min(_sourceLocation.longitude, destination.longitude),
              ),
              northeast: LatLng(
                max(_sourceLocation.latitude, destination.latitude),
                max(_sourceLocation.longitude, destination.longitude),
              ),
            ),
            50, // Padding
          ),
        );
      } else {
        print('No points received. Error: ${result.errorMessage}');
      }
    } catch (e) {
      print('Error getting directions: $e');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(),
    body: Stack(
      children: [
        // Google Map should be first in the stack
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _sourceLocation,
            zoom: 19.0,
          ),
          markers: _markers,
          polylines: _polylines,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
            _updateMarkers();
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
        ),
        // Position the legend button above the map
        Positioned(
          right: 4,
          top: 64,
          child: Column(
            children: [
              _buildLegendButton(),
            ],
          ),
        ),
      ],
    ),
    bottomNavigationBar: BottomNavBar(selectedIndex: 3),
  );
}
Widget _buildLegendButton() {
  final categories = TrashInformationModel.getCategories();
  
  return PopupMenuButton<int>(
    color: Colors.white,
    icon: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(Icons.help_outline, color: Colors.blue, size: 24),
    ),
    itemBuilder: (context) {
      final menuItems = <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: -1,
          enabled: false,
          child: Text('Trash Categories', 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black
            ),
          ),
        ),
      ];
      
      for (var i = 0; i < categories.length; i++) {
        final category = categories[i];
        menuItems.add(
          PopupMenuItem<int>(
            value: i,
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: category.color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4),
                Icon(categories[i].icon, color: categories[i].color),
                SizedBox(width: 4),
                Text(category.name),
              ],
            ),
          ),
        );
        
        if (i != categories.length - 1) {
          menuItems.add(
            PopupMenuDivider(height: 8),
          );
        }
      }
      
      return menuItems;
    },
    offset: Offset(0, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 4,
  );
}
}
