import 'package:flutter/material.dart';
import '../screens/add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(), //load the data here

        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: Center(child: CircularProgressIndicator()),
              ) //if still waiting load circular indicator
            : Consumer<GreatPlaces>(
                builder: (context, greatPlaces, ch) => greatPlaces.items.isEmpty
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.items[i].image),
                          ),
                          title: Text(greatPlaces.items[i].title),
                          subtitle: Text(greatPlaces.items[i].location.address),
                          onTap: () {
                            //go to detail page...
                          },
                        ),
                      ),
                child: const Center(
                  child: Text('Got no places yet, Start adding some!'),
                ),
              ),
      ),
    );
  }
}
