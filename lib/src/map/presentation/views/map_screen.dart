import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_it_app/core/env/env.dart';
import 'package:run_it_app/core/resources/media.dart';
import 'package:run_it_app/core/utils/constants.dart';
import 'package:run_it_app/src/map/presentation/widgets/logo_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  static const path = '/map';
  static const name = 'map';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = MapController();
  double _zoom = kInitialZoom;
  LatLng _center = const LatLng(-7.2754417, 112.6302828);

  void _onSliderChanged(double value) {
    setState(() => _zoom = value);
    _mapController.move(_center, _zoom);
  }

  void _onMapPositionChanged(MapCamera camera, bool hasGesture) {
    setState(() => _center = camera.center);
    _mapController.move(_center, _zoom);
  }

  void _onZoomIn() {
    if (_zoom == kMaxZoom) {
      return;
    } else if (_zoom + 1 >= kMaxZoom) {
      setState(() => _zoom = kMaxZoom);
    } else {
      setState(() => _zoom += 1);
    }

    _mapController.move(_center, _zoom);
  }

  void _onZoomOut() {
    if (_zoom == kMinZoom) {
      return;
    } else if (_zoom - 1 <= kMinZoom) {
      setState(() => _zoom = kMinZoom);
    } else {
      setState(() => _zoom -= 1);
    }

    _mapController.move(_center, _zoom);
  }

  void _onErrorTile(
    TileImage tileImage,
    Object error,
    StackTrace? stackTrace,
  ) {
    _mapController.move(_center, _zoom);
  }

  final actions = [
    LogoIconButton(
      onPressed: () {},
      logo: Media.flutterLogo,
    ),
    LogoIconButton(
      onPressed: () {},
      logo: Media.dartLogo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Home'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: actions,
          ),
        ),
        child: _buildBody(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: actions,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: _zoom,
              minZoom: kMinZoom,
              maxZoom: kMaxZoom,
              onPositionChanged: _onMapPositionChanged,
            ),
            children: [
              TileLayer(
                urlTemplate: '${Env.baseOsmTileUrl}/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.ahmadfaisal.runit',
                errorTileCallback: _onErrorTile,
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(
                      Uri.parse('${Env.baseOsmUrl}/copyright'),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 16,
                top: 16,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RotatedBox(
                        quarterTurns: 1,
                        child: GestureDetector(
                          onTap: _onZoomOut,
                          child: const Icon(
                            CupertinoIcons.zoom_out,
                          ),
                        ),
                      ),
                      if (Platform.isIOS)
                        CupertinoSlider(
                          min: kMinZoom,
                          max: kMaxZoom,
                          value: _zoom,
                          onChanged: _onSliderChanged,
                        ),
                      if (Platform.isAndroid)
                        Slider(
                          min: kMinZoom,
                          max: kMaxZoom,
                          value: _zoom,
                          onChanged: _onSliderChanged,
                        ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: GestureDetector(
                          onTap: _onZoomIn,
                          child: const Icon(
                            CupertinoIcons.zoom_in,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
