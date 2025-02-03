import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapButton extends StatelessWidget {
  MapButton({super.key});
  LatLng myCurrentloc = LatLng(27.7172, 85.3240);
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingActionButton.extended(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          showModalBottomSheet(
              clipBehavior: Clip.none,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: size.height * .77,
                  width: size.width,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: size.height * .77,
                        child: GoogleMap(
                          initialCameraPosition:
                              CameraPosition(target: myCurrentloc),
                          onMapCreated: (GoogleMapController controller) {},
                          onTap: (argument) {},
                          onCameraMove: (position) {},
                          markers: markers.toSet(),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        label: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                "Map",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.map_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
        ));
  }
}
