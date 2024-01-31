import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:permata_architect_mobile_apps/api/api_list_progress.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_progress_model.dart';

enum ResultListProgress { loading, noData, hasData, error, first }

class ListProgressAllProvider extends ChangeNotifier {
  final GetListProgressService getListProgressService;
  StreamSubscription? _connectivitySubscription;

  ListProgressAllProvider({required this.getListProgressService}) {
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

  late ResultListProgress _state;
  late List<ListProgress> _listprogress;
  late String _message = '';

  String get message => _message;
  List<ListProgress> get listprogress => _listprogress;
  ResultListProgress get state => _state;

  Future<dynamic> _fetchGetList() async {
    try {
      _state = ResultListProgress.loading;
      notifyListeners();
      final getlistproyek = await getListProgressService.listprogressAll();
      if (getlistproyek.isEmpty) {
        _state = ResultListProgress.noData;
        notifyListeners();
        return _message = 'Empthy Data';
      } else {
        _state = ResultListProgress.hasData;
        notifyListeners();
        return _listprogress = getlistproyek;
      }
    } on SocketException {
      _state = ResultListProgress.error;
      notifyListeners();
      _message = '404';
    } catch (e) {
      _state = ResultListProgress.error;
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
