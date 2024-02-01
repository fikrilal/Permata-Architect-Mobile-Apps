import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:permata_architect_mobile_apps/api/api_list_progress.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_progress_model.dart';

enum ResultProgressId { loading, noData, hasData, error, first }

class ListProgressByIdProvider extends ChangeNotifier {
  final GetListProgressService getListProgressService;
  String? _lasrequestId;
  StreamSubscription? _connectivitySubscription;

  ListProgressByIdProvider({required this.getListProgressService}) {
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

  late ResultProgressId _state;
  late List<ListProgress> _listprogress;
  late String _message = '';

  String get message => _message;
  List<ListProgress> get listprogress => _listprogress;
  ResultProgressId get state => _state;

  Future<dynamic> fetchGetById({String? idProyek}) async {
    _lasrequestId = idProyek;
    try {
      _state = ResultProgressId.loading;

      final getlistproyek =
          await getListProgressService.listprogressById(idProyek: idProyek);
      notifyListeners();
      if (getlistproyek.isEmpty) {
        _state = ResultProgressId.noData;
        notifyListeners();
        return _message = 'Belum ada Progress pada Proyek ini';
      } else {
        _state = ResultProgressId.hasData;
        notifyListeners();
        return _listprogress = getlistproyek;
      }
    } on SocketException {
      _state = ResultProgressId.error;
      notifyListeners();
      _message = '404';
    } catch (e) {
      _state = ResultProgressId.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      await fetchGetById(idProyek: _lasrequestId);
    }
  }
}
