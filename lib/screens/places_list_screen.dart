import 'package:flutter/material.dart';
import 'package:great_places_app/providers/places.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchPlaces(),
        builder: (contextFuture, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<Places>(
            builder: (ctx, places, ch) {
              return places.items.length == 0
                  ? ch!
                  : ListView.builder(
                      itemCount: places.items.length,
                      itemBuilder: (ctx2, i) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(places.items[i].image),
                          ),
                          title: Text(places.items[i].title),
                        );
                      },
                    );
            },
            child: Center(
              child: const Text('There aren\'t added places'),
            ),
          );
        },
      ),
    );
  }
}
