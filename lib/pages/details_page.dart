import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_ui_9/model/place.dart';

class DetailsPage extends StatelessWidget {
  final Place place;

  const DetailsPage({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: SingleChildScrollView(
        child: ResponsiveRowColumn(
          rowCrossAxisAlignment: CrossAxisAlignment.start,
          layout: ResponsiveBreakpoints.of(context).isMobile
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          children: [
            ResponsiveRowColumnItem(
                rowFlex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _getImage(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _getTitle(),
                    ),
                  ],
                )),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getActionBar(),
                    const SizedBox(height: 10),
                    _getDescription()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _getTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(place.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            Text(place.subtitle,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Image _getImage() {
    return Image.asset(
      place.image,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 300,
    );
  }

  Widget _getDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Description:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Text(place.description),
      ],
    );
  }

  Widget _getActionBar() {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 150) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(value: "call", child: Text("Call")),
                    const PopupMenuItem(value: "route", child: Text("Route")),
                    const PopupMenuItem(value: "share", child: Text("Share")),
                  ];
                }),
          ],
        );
      }
      return SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () => null,
                icon: const Column(
                  children: [Icon(Icons.call), Text("Call")],
                )),
            IconButton(
                onPressed: () => null,
                icon: const Column(
                  children: [Icon(Icons.place), Text("Route")],
                )),
            IconButton(
                onPressed: () => null,
                icon: const Column(
                  children: [Icon(Icons.share), Text("Share")],
                )),
          ],
        ),
      );
    });
  }
}
