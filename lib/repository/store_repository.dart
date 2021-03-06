import 'dart:convert';

import 'package:flutter_mask/model/store.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';



class StoreRepository {
  final _distance = Distance();
  Future<List<Store>> fetch(double lat, double lng) async {
    final stores = <Store>[];

    // setState(() {
    //   isLoading = true;
    // });

    // 37.266389, 126.999333
    var url = Uri.parse(
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json?lat=$lat&lng=$lng&m=5000');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
        final jsonStores = jsonResult['stores'];

        // setState(() {
        //   stores.clear();
        jsonStores.forEach((e) {
          //e : element
          final store = Store.fromJson(e);
          final num km = _distance.as(
              LengthUnit.Kilometer, LatLng(store.lat ?? 0, store.lng ?? 0),
              LatLng(lat, lng));
          store.km = km;
          stores.add(store);
          // isLoading = false;
        });
        // });
        print('fetch 완료');

        return stores.where((e) {
          return e.remainStat == 'plenty' ||
              e.remainStat == 'some' ||
              e.remainStat == 'few';
        }).toList()
          ..sort((a, b) => a.km!.compareTo(b.km!));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}