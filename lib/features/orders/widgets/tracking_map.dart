import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_map.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/order_model.dart';

/// OpenStreetMap with the route: store → rider (solid green) → home
/// (dashed green), and white round markers.
class TrackingMap extends StatefulWidget {
  const TrackingMap({super.key, required this.home, this.tileProvider});

  final LatLng home;

  /// Overridable for tests (no network there).
  final TileProvider? tileProvider;

  @override
  State<TrackingMap> createState() => _TrackingMapState();
}

class _TrackingMapState extends State<TrackingMap> {
  final _controller = MapController();

  List<LatLng> get _remaining =>
      [TrackingModel.rider, ...TrackingModel.remainingVia, widget.home];

  /// Fit the whole route into the part of the map above the sheet. Done in
  /// onMapReady (not initialCameraFit) so the first tiles load straight away.
  void _fitRoute() => _controller.fitCamera(
        CameraFit.coordinates(
          coordinates: [...TrackingModel.travelled, ..._remaining],
          padding: EdgeInsets.fromLTRB(60.w, 140.h, 60.w, 360.h),
          maxZoom: AppMap.trackingZoom + 1,
        ),
      );

  @override
  void didUpdateWidget(TrackingMap old) {
    super.didUpdateWidget(old);
    if (old.home != widget.home) _fitRoute();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Marker _marker(LatLng point, IconData icon) => Marker(
        point: point,
        width: 52.r,
        height: 52.r,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.mapMarkerShadow, blurRadius: 12.r, offset: Offset(0, 4.h))],
          ),
          child: Icon(icon, color: AppColors.primary, size: 26.r),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final remaining = _remaining;
    return FlutterMap(
      mapController: _controller,
      options: MapOptions(
        initialCenter: TrackingModel.rider,
        initialZoom: AppMap.trackingZoom,
        maxZoom: AppMap.maxZoom,
        onMapReady: _fitRoute,
      ),
      children: [
        TileLayer(
          urlTemplate: AppMap.tileUrl,
          userAgentPackageName: AppMap.userAgentPackageName,
          tileProvider: widget.tileProvider,
        ),
        PolylineLayer(
          polylines: [
            Polyline(points: TrackingModel.travelled, color: AppColors.primary, strokeWidth: 5),
            Polyline(
              points: remaining,
              color: AppColors.primary,
              strokeWidth: 5,
              pattern: StrokePattern.dashed(segments: const [12, 10]),
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            _marker(TrackingModel.store, Icons.storefront),
            _marker(TrackingModel.rider, Icons.delivery_dining),
            _marker(widget.home, Icons.home_rounded),
          ],
        ),
        // Required by the OSM tile policy; collapses to an (i) button.
        const RichAttributionWidget(
          attributions: [TextSourceAttribution(AppTexts.osmAttribution)],
        ),
      ],
    );
  }
}
