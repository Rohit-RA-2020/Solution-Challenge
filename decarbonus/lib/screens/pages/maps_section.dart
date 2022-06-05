import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({
    Key? key,
  }) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  final Set<Marker> _markers = {};

  void addMarkers() {
    _markers.add(Marker(
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(110),
        flat: true,
        markerId: const MarkerId('Venue'),
        infoWindow: const InfoWindow(
            title: 'Seminar', snippet: "Global Warming Discussion"),
        position: const LatLng(21.1616, 79.0150)));
    _markers.add(Marker(
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(140),
        flat: true,
        infoWindow: const InfoWindow(
            title: 'Lake Cleaning', snippet: "Gorewada Lake Cleaning"),
        markerId: const MarkerId('Venue1'),
        position: const LatLng(21.2, 79.0150)));

    _markers.add(Marker(
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(150),
        flat: true,
        infoWindow:
            const InfoWindow(title: 'Tree Plantation', snippet: "Nagpur City"),
        markerId: const MarkerId('Venue2'),
        position: const LatLng(21.161, 79.1050)));
  }

  void getLocation() async {
    //var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      setState(() {
        _markers.add(Marker(
            draggable: true,
            flat: true,
            infoWindow: const InfoWindow(title: 'Your Current Location'),
            markerId: const MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    setState(() {
      addMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: true,
        initialCameraPosition: const CameraPosition(
          target: LatLng(20.5937, 78.9629),
          zoom: 12.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _markers,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.location_searching,
          color: Colors.white,
        ),
        onPressed: () {
          getLocation();
        },
      ),
    );
  }
}
