import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_places/models/place.dart';

class MapScreen extends StatefulWidget {

  final PlaceLocation? initialLocation;
  final bool isReadOnly;
  
  const MapScreen({
    super.key,
    this.initialLocation = const PlaceLocation(latitude: 37.419857, longitude: -122.078827, address: ''),
    this.isReadOnly = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng? _pickedPosition;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });

    // Navigator.of(context).pop(PlaceLocation(
    //   latitude: position.latitude,
    //   longitude: position.longitude,
    //   address: '',
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione...'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation!.latitude, widget.initialLocation!.longitude),
          zoom: 13,
        ),
        onTap: widget.isReadOnly ? null : _selectLocation,
        markers: {
          Marker(
            markerId: const MarkerId('p1'),
            position: _pickedPosition ?? LatLng(widget.initialLocation!.latitude, widget.initialLocation!.longitude),
          ),
        },
      ),
    );
  }
}
