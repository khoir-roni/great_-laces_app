import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  LocationInput({Key key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl; // store url link for pointing the view of map
  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  } //method for get location coordinate

  Future<void> _selectOnMap() async {
    final selectedSelection = await Navigator.of(context).push<LatLng>(
      // when the page popped wil give back LatLng object
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedSelection == null) {
      return;
    }
    print("latitude : ${selectedSelection.latitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
            width: 1,
          )),
          child: _previewImageUrl == null
              ? const Text(
                  'No location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        )
      ],
    );
  }
}
