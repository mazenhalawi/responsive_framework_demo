import 'package:flutter/material.dart';
import '../data/places.dart';
import '../model/place.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/place_details_widget.dart';
import '../widgets/place_gallery_widget.dart';
import '../widgets/responsive_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Place selectedPlace = allPlaces[0];
  void changePlace(Place place) => setState(() => selectedPlace = place);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveWidget.isMobile(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Tour App - Responsive')),
      drawer: isMobile ? const Drawer(child: DrawerWidget()) : null,
      body: ResponsiveWidget(
        mobile: buildMobile(),
        tablet: buildTablet(),
        desktop: buildDesktop(),
      ),
    );
  }

  Widget buildMobile() => PlaceGalleryWidget(onPlaceChanged: changePlace);

  Widget buildTablet() => Row(
        children: [
          const Expanded(flex: 2, child: DrawerWidget()),
          Expanded(
            flex: 5,
            child: PlaceGalleryWidget(onPlaceChanged: changePlace),
          ),
        ],
      );

  Widget buildDesktop() => Row(
        children: [
          const Expanded(child: DrawerWidget()),
          Expanded(flex: 3, child: buildBody()),
        ],
      );

  Widget buildBody() => Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PlaceGalleryWidget(
                onPlaceChanged: changePlace,
                isHorizontal: true,
              ),
            ),
            Expanded(
              flex: 2,
              child: PlaceDetailsWidget(place: selectedPlace),
            )
          ],
        ),
      );
}
