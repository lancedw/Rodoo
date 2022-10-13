import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodo/models/directions.dart';
import 'package:rodo/services/directions_repository.dart';
import 'package:rodo/utilities/constants.dart';

class Google_maps extends StatefulWidget {
  static const String route = '/goolgemaps';

  @override
  _Google_mapsState createState() => _Google_mapsState();
}

class _Google_mapsState extends State<Google_maps> {
  late GoogleMapController googleMapController;

  // TODO: Set originMarker to phone location
  // TODO: Set destination marker to resto location
  final Marker originMarker = Marker(
    markerId: const MarkerId("origin"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    infoWindow: const InfoWindow(title: "Your Location"),
    position: LatLng(51.07, 3.72),
  );
  final Marker destinationMarker = Marker(
    markerId: const MarkerId("destination"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    infoWindow: const InfoWindow(title: "Restaurant"),
    position: LatLng(51.05, 3.71),
  );

  Directions? directions = null;

  void moveCameraToLocation(Marker marker) {
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: marker.position,
          zoom: 16,
        ),
      ),
    );
  }

  LatLng calculateMiddle(Marker origin, Marker dest) {
    double latDelta = origin.position.latitude + dest.position.latitude;
    double longDelta = origin.position.longitude + dest.position.longitude;
    latDelta /= 2;
    longDelta /= 2;
    return LatLng(latDelta, longDelta);
  }

  getDirections() async {
    final info = await DirectionsRepository().getDirections(
      origin: originMarker.position,
      destination: destinationMarker.position,
    );
    setState(() {
      directions = info;
    });
  }

  @override
  void initState() {
    getDirections();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition middleCameraPosition = CameraPosition(
      target: calculateMiddle(originMarker, destinationMarker),
      zoom: 14.5, // zoom between ~[0,20]
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: false,
        primary: false,
        automaticallyImplyLeading: false,
        title: TextButton(
          onPressed: () {
            googleMapController.animateCamera(
              CameraUpdate.newLatLngBounds(
                directions!.bounds,
                40,
              ),
            );
          },
          child: Text(
            "route",
            style: appBarTextStyle.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => moveCameraToLocation(originMarker),
            child: Text(
              "origin",
              style: generalTextStyle.copyWith(
                color: CupertinoColors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () => moveCameraToLocation(destinationMarker),
            child: Text(
              "destination",
              style: generalTextStyle.copyWith(
                color: CupertinoColors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: middleCameraPosition,
          onMapCreated: (controller) {
            googleMapController = controller;
            if(directions != null) {
              googleMapController.animateCamera(
                CameraUpdate.newLatLngBounds(
                  directions!.bounds,
                  40,
                ),
              );
            }
          },
          markers: {originMarker, destinationMarker},
          polylines: {
            if (directions != null)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Colors.blue,
                width: 5,
                points: directions!.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ),
          },
        ),
      ),
    );
  }
}
