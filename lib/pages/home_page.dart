import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_ui_9/data/places.dart';
import 'package:responsive_ui_9/model/place.dart';
import 'package:responsive_ui_9/pages/details_page.dart';

class HomePage extends StatefulWidget {
  final List<Place> places;
  const HomePage({required this.places, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Place? _selectedPlace;

  @override
  void initState() {
    super.initState();
    _selectedPlace = widget.places.isNotEmpty ? widget.places.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Row(
        children: [
          // Side bar for larger screens
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: MOBILE)],
            child: Expanded(flex: 3, child: _getDrawer()),
          ),
          Expanded(
              flex: 5,
              child: GridView.builder(
                  itemCount: allPlaces.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveValue(context,
                        defaultValue: 2,
                        conditionalValues: [
                          const Condition.equals(name: MOBILE, value: 2),
                          const Condition.largerThan(name: MOBILE, value: 1)
                        ]).value,
                  ),
                  itemBuilder: (context, index) {
                    final place = allPlaces[index];
                    return GestureDetector(
                      onTap: () => setState(() {
                        _selectedPlace = place;
                        if (!ResponsiveBreakpoints.of(context).isDesktop) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => DetailsPage(place: place)));
                        }
                      }),
                      child: Card(
                          child: Container(
                        decoration: BoxDecoration(
                            border: _selectedPlace == place
                                ? Border.all(color: Colors.orange, width: 5.0)
                                : null),
                        width: double.infinity,
                        height: ResponsiveValue(context, conditionalValues: [
                          const Condition.equals(name: MOBILE, value: 80.0),
                          const Condition.largerThan(name: MOBILE, value: null),
                        ]).value,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: Image.asset(place.image,
                                    fit: BoxFit.cover)),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.black.withAlpha(100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(place.title,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(place.subtitle,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                    );
                  })),
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.equals(name: DESKTOP)],
            child: _selectedPlace != null
                ? Expanded(flex: 3, child: _getDescriptionView(_selectedPlace!))
                : Container(),
          )
        ],
      ),
      drawer: ResponsiveValue(context, conditionalValues: [
        Condition.equals(name: MOBILE, value: _getDrawer()),
        const Condition.largerThan(name: MOBILE, value: null)
      ]).value,
    );
  }

  Widget _getDescriptionView(Place place) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(place.title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(place.subtitle,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          const Text('Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(place.description)
        ],
      ),
    );
  }

  Drawer _getDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/neelumvalley.jpg'),
                    fit: BoxFit.cover)),
            child: Container(
                alignment: Alignment.bottomLeft,
                child: const Text("Pakistan",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
          ),
          ...allPlaces.map((place) => ListTile(
                leading: const Icon(Icons.location_city),
                title: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      place.title,
                      textAlign: TextAlign.start,
                    )),
              ))
        ],
      ),
    );
  }
}
