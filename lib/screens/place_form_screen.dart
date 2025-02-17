import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_places/models/place.dart';
import 'package:my_places/providers/greate_place.dart';
import 'package:my_places/widgets/image_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  _submitForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatePlace>(context, listen: false).addPlace(
      _titleController.text,
      // {} as PlaceLocation,
      _pickedImage!,
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
                    ),
                    ImageInput(onImageSelected: _selectImage)
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
                onPressed: _submitForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
