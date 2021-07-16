import 'dart:convert';

import 'package:covidbed/model/rs_bed.dart';
import 'package:covidbed/service/service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListPage extends StatefulWidget {
  final Object? arguments;

  ListPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<RSbed> _beds = [];

  Future<void> _loadBedList(key) async {
    List<RSbed> beds = await BedService.getBedList(key);

    setState(() => {_beds = beds});
  }

  @override
  void initState() {
    super.initState();

    String arguments = jsonEncode(widget.arguments);
    Map<String, dynamic> data = jsonDecode(arguments);

    String key = data['search'].toLowerCase().replaceFirst(' ', '_');

    _loadBedList(key);
  }

  @override
  Widget build(BuildContext context) {
    String arguments = jsonEncode(widget.arguments);
    Map<String, dynamic> data = jsonDecode(arguments);

    String key = data['search'].toLowerCase().replaceFirst(' ', '_');

    return Scaffold(
      appBar: AppBar(
        title: Text("${data['search']}"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/info');
            },
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _loadBedList(key),
              child: (() {
                if (_beds.length == 0) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: _beds.length,
                  itemBuilder: (BuildContext context, int index) {
                    RSbed bed = _beds[index];

                    return Column(children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 20,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            border: Border.all(
                              color: Colors.blue.shade700,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Diperbaharui ${durationToString(bed.updatedMinutes)} yang lalu',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        child: Container(
                          // height: 180,
                          child: Card(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 20),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          launch('${bed.bedDetailLink}');
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10),
                                            Container(
                                              height: 50,
                                              child: Text(
                                                bed.availableBed > 0
                                                    ? '${bed.availableBed}'
                                                    : 'Penuh',
                                                style: TextStyle(
                                                    fontSize:
                                                        bed.availableBed > 0
                                                            ? 40
                                                            : 20,
                                                    color: bed.availableBed > 0
                                                        ? Colors.blue
                                                        : Colors.red),
                                              ),
                                            ),
                                            SizedBox(
                                                height: bed.availableBed > 0
                                                    ? 10
                                                    : 0),
                                            Text((() {
                                              if (bed.availableBed > 0) {
                                                return "Tersedia";
                                              }
                                              return "";
                                            })()),
                                            SizedBox(height: 5),
                                            Text(
                                              (() {
                                                if (bed.bedQueue > 0) {
                                                  return "Dengan ${bed.bedQueue} antrian";
                                                }
                                                return "Tanpa antrian";
                                              })(),
                                              style: TextStyle(
                                                  color: bed.bedQueue > 0
                                                      ? Colors.red
                                                      : Colors.blue),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${bed.name}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                '${bed.address}',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              SizedBox(height: 8),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Divider(),
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            launch('tel://${bed.hotline}');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0,
                                                bottom: 3.0,
                                                left: 3.0,
                                                right: 3.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  '${bed.hotline}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                          ),
                                          onPressed: () {
                                            launch(
                                                'https://www.google.com/maps/search/${bed.name}');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0,
                                                bottom: 3.0,
                                                left: 5.0,
                                                right: 5.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_sharp,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  'Buka peta',
                                                  style: TextStyle(
                                                      color: Colors.black87),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]);
                  },
                );
              })(),
            ),
          ),
        ],
      ),
    );
  }

  String durationToString(int value) {
    final int hour = value ~/ 60;

    if (value < 60) {
      return '$value menit';
    } else {
      return '${hour.toString()} Jam';
    }
  }
}
