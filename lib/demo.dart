import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';


class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('markers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                AnimSearchBar(
                  width: 400,
                  textController: textController,
                  onSuffixTap: () {
                    setState(() {
                      textController.clear();
                    });
                  },
                ),
                Container(
                  height: 370,
                  width: 500,
                  child: ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((document) {
                      return Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text("Latitude :" +
                                    document['Latitude'].toString()),
                                Text("Longitude :" +
                                    document['longitude'].toString()),
                                // getUserLocation(
                                //     document["Latitude"], document["longitude"])
                               
                               
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

getUserLocation() async {
  List<Placemark> placemarks = await placemarkFromCoordinates(24.88462107346647, 67.17103742733244);
  Placemark place = placemarks[0];
  
  var first = placemarks.first;
  print("${first.name} : ${first..administrativeArea}");
}



