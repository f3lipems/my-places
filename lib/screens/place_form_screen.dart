import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_places/models/place.dart';
import 'package:my_places/providers/greate_places.dart';
import 'package:my_places/widgets/image_input.dart';
import 'package:my_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  bool activeSubmit = false;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  bool isValidForm() {
    print('Title: ' + _titleController.text.isNotEmpty.toString());
    print('Image: ' + (_pickedImage != null).toString());
    print('Position: ' + (_pickedPosition != null).toString());
    return _titleController.text.isNotEmpty && _pickedImage != null && _pickedPosition != null;
  }

  _submitForm() {
    if (!isValidForm()) return;

    Provider.of<GreatePlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: <Widget>[
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    ImageInput(onImageSelected: _selectImage),
                    LocationInput(onSelectPlace: _selectLocation),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Adicionar'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                onPressed: isValidForm() ? _submitForm : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
