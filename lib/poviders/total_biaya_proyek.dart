import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:permata_architect_mobile_apps/api/api_total_biaya_proyek.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/total_biaya_proyek.dart';

enum ResultBiaya { loading, noData, hasData, error, first }

class TotalBiayaProyekProvider extends ChangeNotifier {
  final TotalBiayaProyekService totalBiayaProyekService;
  String? _lastRequestedId;
  StreamSubscription? _connectivitySubscription;

  TotalBiayaProyekProvider({required this.totalBiayaProyekService}) {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  ResultBiaya _state = ResultBiaya.first;
  late TotalBiayaProyek _biayaProyek;
  late String _message = '';

  String get message => _message;
  TotalBiayaProyek get biayaProyek => _biayaProyek;
  ResultBiaya get state => _state;

  Future<dynamic> fetchBiayaProyek({String? idProyek}) async {
    _lastRequestedId = idProyek;
    try {
      _state = ResultBiaya.loading;

      final biayaProyeks =
          await totalBiayaProyekService.getTotalProyek(idProyek: idProyek);
      notifyListeners();
      if (biayaProyeks.totalKasbons!.isEmpty) {
        _state = ResultBiaya.noData;
        notifyListeners();
        return _message = 'Empthy Data';
      } else {
        _state = ResultBiaya.hasData;
        notifyListeners();
        return _biayaProyek = biayaProyeks;
      }
    } on SocketException {
      _state = ResultBiaya.error;
      notifyListeners();
      _message = '404';
    } catch (e) {
      _state = ResultBiaya.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      await fetchBiayaProyek(idProyek: _lastRequestedId);
    }
  }
}
