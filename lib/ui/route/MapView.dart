import 'package:alto_minho_mobilidade/utils/Networking/GetRoutes.dart';
import 'package:alto_minho_mobilidade/ui/radio_selector/radio_button_builder.dart';
import 'package:alto_minho_mobilidade/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';

import 'package:alto_minho_mobilidade/ui/radio_selector/radio_selector.dart';
import 'package:alto_minho_mobilidade/utils/Networking/ApiModels/Leg.dart';

class MapView extends StatefulWidget {
  final GetRoutes getRoutes;

  const MapView(this.getRoutes);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController _mapController;

  bool hasLocationPermission = false;
  MapType _currentMapType = MapType.normal;
  final _mapTypes = [
    MapType.normal,
    MapType.satellite,
    MapType.terrain,
    MapType.hybrid
  ];
  bool _isLayerExpanded = false;

  Set<Polyline> polyLines;
  Set<Marker> markers;

  BitmapDescriptor carIcon;
  BitmapDescriptor walkIcon;
  BitmapDescriptor busIcon;
  BitmapDescriptor originIcon;
  BitmapDescriptor tweenNodeIcon;
  BitmapDescriptor destinationIcon;

  _createMarkerIcons() async {
    final imageConfig = ImageConfiguration(size: Size(100, 100));
    carIcon =
    await BitmapDescriptor.fromAssetImage(imageConfig, 'assets/car.png');
    walkIcon =
    await BitmapDescriptor.fromAssetImage(imageConfig, 'assets/walk.png');
    busIcon =
    await BitmapDescriptor.fromAssetImage(imageConfig, 'assets/bus.png');
    originIcon =
    await BitmapDescriptor.fromAssetImage(imageConfig, 'assets/start.png');
    tweenNodeIcon = await BitmapDescriptor.fromAssetImage(
        imageConfig, 'assets/intermediate.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        imageConfig, 'assets/destination.png');
  }

  _addMarkers() {
    final legs = widget.getRoutes.plan.itineraries[0].legs;
    legs.forEach((e) {
      markers.add(Marker(
          markerId: MarkerId(e.legGeometry.points),
          icon: _getDescriptor(e),
          position: LatLng(e.from.lat, e.from.lon)));
    });
    //add extra marker for endpoint
    markers.add(Marker(
        markerId: MarkerId(legs.last.legGeometry.points + '2'),
        icon: _getDescriptor(legs.last),
        position: LatLng(legs.last.to.lat, legs.last.to.lon)));
  }

  BitmapDescriptor _getDescriptor(Leg leg) {
    print(leg.mode);
    if (leg.mode == ModeConstants.CAR)
      return carIcon;
    else if (leg.mode == ModeConstants.WALK)
      return walkIcon;
    else if (leg.mode == ModeConstants.BUS)
      return busIcon;
    else if (leg.mode == ModeConstants.TRANSIT_WALK)
      return BitmapDescriptor.defaultMarker;
    else
      return BitmapDescriptor.defaultMarker;
  }

  static const _refWidth = 100.0;

  Cap _getStartCapDescriptor(List list, item) {
    if (list.first == item)
      return Cap.customCapFromBitmap(originIcon, refWidth: _refWidth);
    else
      return Cap.customCapFromBitmap(tweenNodeIcon, refWidth: _refWidth);
  }

  Cap _getEndCapDescriptor(List list, item) {
    if (list.last == item)
      return Cap.customCapFromBitmap(destinationIcon, refWidth: _refWidth);
    else
      return Cap.customCapFromBitmap(tweenNodeIcon, refWidth: _refWidth);
  }

  @override
  void initState() {
    super.initState();
    _createMarkerIcons();
  }

  @override
  Widget build(BuildContext context) {
    _getLocationPermission();

    final route = widget.getRoutes;
    final split = route.requestParameters.fromPlace.split(',');
    final lat = double.tryParse(split[0].trim());
    final lng = double.tryParse(split[1].trim());
    final layerIconFromRight = 52.0;
    final layerIconFromTop = 12.0;
    return Container(
        child: Stack(
          children: [
            GoogleMap(
              markers: markers,
              polylines: polyLines,
              onMapCreated: _onMapCreated,
              myLocationEnabled: hasLocationPermission,
              initialCameraPosition:
              CameraPosition(target: LatLng(lat, lng), zoom: 13.0),
              mapType: _currentMapType,
            ),
            Positioned(
              top: layerIconFromTop,
              right: layerIconFromRight,
              child: _mapController != null && !_isLayerExpanded
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isLayerExpanded = !_isLayerExpanded;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 6.0)
                      ],
                      color: Color(0xFFffffff).withOpacity(0.7)),
                  child: Icon(
                    Icons.layers,
                    color: Color(0xFF656665),
                  ),
                ),
              )
                  : _isLayerExpanded
                  ? Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6.0)
                    ]),
                child: RadioGroup<MapType>.builder(
                  direction: Axis.vertical,
                  groupValue: _currentMapType,
                  onChanged: (value) =>
                      setState(() {
                        _currentMapType = value;
                        _isLayerExpanded = !_isLayerExpanded;
                      }),
                  items: _mapTypes,
                  itemBuilder: (item) {
                    String radioText = item.toString().split('.')[1];
                    radioText = radioText.substring(0,1).toUpperCase() + radioText.substring(1, radioText.length);
                    return RadioButtonBuilder(
                      radioText
                    );
                  },
                ),
              )
                  : SizedBox.shrink(),
            )
          ],
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      markers = Set.from([]);
      _addMarkers();
      _setPolyLinse();
    });
  }

  Future<void> _getLocationPermission() async {
    final permissions =
    await Permission.getPermissionsStatus([PermissionName.Location]);
    if (permissions[0].permissionStatus == PermissionStatus.allow) {
      setState(() {
        hasLocationPermission = true;
      });
    } else {
      await Permission.requestPermissions([PermissionName.Location]);
      return _getLocationPermission();
    }
  }

  void _setPolyLinse() {
    final legs = widget.getRoutes.plan.itineraries[0].legs;
    polyLines = legs
        .map((e) =>
        Polyline(
            points: PolylinePoints()
                .decodePolyline(e.legGeometry.points)
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
            polylineId: PolylineId(e.legGeometry.points),
            color: Colors.blue,
            startCap: _getStartCapDescriptor(legs, e),
            endCap: _getEndCapDescriptor(legs, e),
            width: 4))
        .toSet();
  }
}
