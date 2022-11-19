import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mapa Primjer 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Navigacijska traka")
        ),
        body: const Mapa(),
      ),
    );
  }
}

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  @override
  Widget build(BuildContext context) {
    return OpenStreetMapSearchAndPick(
      center: LatLong(23, 89),
      buttonColor: Colors.blue,
      buttonText: 'Set Current Location',
      onPicked: (pickedData) {
        print(pickedData.latLong.latitude);
        print(pickedData.latLong.longitude);
        print(pickedData.address);
      }
    );
  }
}