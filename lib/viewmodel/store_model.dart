import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/repository/location_repository.dart';
import 'package:flutter_mask/repository/store_repository.dart';
import 'package:geolocator/geolocator.dart';

class StoreModel with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = <Store>[];
  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners(); // 바뀌고 통지 시작

    Position postion = await _locationRepository.getCurrentLocation();
    stores = await _storeRepository.fetch(postion.latitude, postion.longitude);
    isLoading = false;
    notifyListeners(); // 바뀌고 통지 시작
  }
}
