import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:permission_handler/permission_handler.dart';

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

  var pozicija = [45.815010, 15.981919];

  void postaviPoziciju() async {
    if(await Geolocator.isLocationServiceEnabled()){
      var p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        pozicija[0] = p.latitude;
        pozicija[1] = p.longitude;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  	PermissionWithService lokacija = Permission.locationWhenInUse;

    lokacija.request().then((status) => {
      if (status == PermissionStatus.granted) {
        postaviPoziciju()
      }
      else {
        print("odbijeno")
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    postaviPoziciju();
    return OpenStreetMapSearchAndPick(
      center: LatLong(pozicija[0], pozicija[1]),
      buttonColor: Colors.blue,
      buttonText: 'Set Current Location',
      onPicked: callbackFunkcija
    );
  }
}

void callbackFunkcija(PickedData data) {
  print(data.address);
}