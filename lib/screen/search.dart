import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:covidbed/service/service.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  late String _selectedProvince;

  _cariButtonPressed() {
    String search = _searchController.text;
    if (search.isNotEmpty) {
      if (ProvinceService.searchProvince(search)) {
        Navigator.pushNamed(context, '/list', arguments: {'search': search});
      }
    }
  }

  _useLocationButtonPressed() async {
    String search = '';

    if (await Permission.location.request().isGranted) {
      LocationData myLocation;
      Location location = new Location();

      myLocation = await location.getLocation();

      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
              myLocation.latitude ?? 0.0, myLocation.longitude ?? 0.0);

      var address = placemarks.first;
      search = address.administrativeArea ?? "";
    }

    Navigator.pushNamed(context, '/list', arguments: {'search': search});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Ketersediaan Tempat\n Rumah Sakit",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 58),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * 0.6,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(28))),
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: this._searchController,
                    decoration: InputDecoration(
                      hintText: 'Pilih provinsi',
                      border: InputBorder.none,
                    )),
                suggestionsCallback: (pattern) {
                  return ProvinceService.getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text('$suggestion'),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  this._searchController.text = '$suggestion';
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: _cariButtonPressed,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 20.0, top: 10, bottom: 10),
                  child: Text("Cari"),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade400),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue))))),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * 0.5,
              child: Row(children: <Widget>[
                Expanded(child: Divider()),
                SizedBox(
                  width: 20,
                ),
                Text("atau"),
                SizedBox(
                  width: 20,
                ),
                Expanded(child: Divider()),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () => _useLocationButtonPressed(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 20.0, top: 10, bottom: 10),
                  child: Text("Gunakan lokasi saat ini"),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade400),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue))))),
          ],
        ),
      ),
    );
  }
}
