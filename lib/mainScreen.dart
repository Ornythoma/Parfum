import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'main.dart';
import 'consentScreen.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double _lat1 = 46.2;
  double _lon1 = 6.135;

  String url =
      'https://qgis.logair.eu/cgi-bin/qgis_mapserv.fcgi?MAP=/home/qgis/projects/world.qgs&SERVICE=WMS&VERSION=1.3.0&REQUEST=GetMap&BBOX=45.855,5.618,47.215,7.687&SRS=EPSG:4326&WIDTH=655&HEIGHT=430&LAYERS=osm,smell&STYLES=pub,pub&OPACITIES=180,255&FORMAT=image/jpeg';
//'https://qgis.logair.eu/cgi-bin/qgis_mapserv.fcgi?MAP=/home/qgis/projects/world.qgs&SERVICE=WMS&VERSION=1.3.0&REQUEST=GetMap&BBOX=45.855,5.618,47.215,7.687&SRS=EPSG:4326&WIDTH=655&HEIGHT=430&LAYERS=osm,smell&OPACITIES=180,255&FORMAT=image/jpeg';
  Position? _currentPosition;

  Future<Position> _positionFuture = Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best,
  );

//  Timer timer;

  @override
  void initState() {
    super.initState();
    _getLocation();
//    new Timer.periodic(Duration(seconds: 30), (Timer t) => _getLocation());
  }

  _getLocation() {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).then((Position pos) {
      setState(() {
        _currentPosition = pos;
      });
    });
  }

  String _buildQGISURL() {

    double lat = (_currentPosition?.latitude ?? _lat1);
    double lon = (_currentPosition?.longitude ?? _lon1);

    double _deltaLat = 0.03;
    double _deltaLon = 0.02;

    // int width = (MediaQuery.of(context).size.width * 0.95).toInt();
    // int height = (width ~/ 1.5).toInt();

    int width = (MediaQuery.of(context).size.width * 0.95).toInt();
    int height = (width*1.5).toInt();

    double lat_1 = lat - _deltaLat;
    double lat_2 = lat + _deltaLat;
    double lon_1 = lon - _deltaLon;
    double lon_2 = lon + _deltaLon;

    url = 'https://qgis.logair.eu/cgi-bin/qgis_mapserv.fcgi?';
    url = url + 'MAP=/home/qgis/projects/world.qgs&';
    url = url + 'SERVICE=WMS&VERSION=1.3.0&REQUEST=GetMap';
    url = url + '&BBOX=$lat_1,$lon_1,$lat_2,$lon_2';
    // url = url + '&BBOX=$lat_2,$lon_1,$lat_1,$lon_2';
    url = url + '&SRS=EPSG:4326';
    url = url + '&WIDTH=$width&HEIGHT=$height';
    url = url + '&LAYERS=osm,smell';
    url = url + '&STYLES=pub,pub';
    url = url + '&OPACITIES=180,255';
    url = url + '&FORMAT=image/jpeg';
    // url = url + '&DPI=200';
    // url = url + '&TILED=TRUE';

    // print(url);
    // url =
    //     'https://qgis.logair.eu/cgi-bin/qgis_mapserv.fcgi?MAP=/home/qgis/projects/world.qgs&SERVICE=WMS&VERSION=1.3.0&REQUEST=GetMap&BBOX=$lat_min,$lon_min,$lat_max,$lon_max&SRS=EPSG:4326&WIDTH=$width&HEIGHT=$height&LAYERS=osm,smell&STYLES=pub,pub&OPACITIES=180,255&FORMAT=image/jpeg';
    print(url);
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SmellLogger: Votre nez, votre futur!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding:
          //       const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          //   child: Text(
          //       "Vous sentez quelque chose? Appuyez sur le bouton ci-dessous."),
          // ),
          Expanded(
            child:Container(
              height: 200,
            padding: const EdgeInsets.all(16),
            child: Text('La carte ci-dessous montre les signalements des dernières 24 heures. Les couleurs montrent si l\'odeur est agréable ou non.'),
          ),),
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom:10),
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: _buildQGISURL()
              ),
              ),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.grey.shade600)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/report');
                  },
                  child: Text(
                    'Report',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
