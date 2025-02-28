import 'package:flutter/material.dart';
import 'package:my_places/providers/greate_places.dart';
import 'package:my_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatePlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatePlaces>(
                child: Center(
                  child: const Text('Nenhum local cadastrado!'),
                ),
                builder: (ctx, greatPlaces, child) => greatPlaces.itemsCount == 0
                    ? child!
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(greatPlaces.itemByIndex(i).image),
                          ),
                          title: Text(greatPlaces.itemByIndex(i).title),
                          subtitle: Text(greatPlaces.itemByIndex(i).location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.placeDetail,
                              arguments: greatPlaces.itemByIndex(i),
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
