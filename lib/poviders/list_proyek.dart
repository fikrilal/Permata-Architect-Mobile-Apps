import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:permata_architect_mobile_apps/api/list_proyek_api.dart';

import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';

enum ResultListProyek { loading, noData, hasData, error, first }

class ListProyekProvider extends ChangeNotifier {
  final GetListProyekService getListProyekService;
  StreamSubscription? _connectivitySubscription;

  ListProyekProvider({required this.getListProyekService}) {
    _fetchGetList();
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

  late ResultListProyek _state;
  late List<ListProyek> _listProyek;
  late String _message = '';

  String get message => _message;
  List<ListProyek> get listProyek => _listProyek;
  ResultListProyek get state => _state;

  Future<dynamic> _fetchGetList() async {
    try {
      _state = ResultListProyek.loading;
      notifyListeners();
      final getlistproyek = await getListProyekService.listproyek();
      if (getlistproyek.isEmpty) {
        _state = ResultListProyek.noData;
        notifyListeners();
        return _message = 'Empthy Data';
      } else {
        _state = ResultListProyek.hasData;
        notifyListeners();
        return _listProyek = getlistproyek;
      }
    } on SocketException {
      _state = ResultListProyek.error;
      notifyListeners();
      _message = '404';
    } catch (e) {
      _state = ResultListProyek.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      await _fetchGetList();
    }
  }
}
