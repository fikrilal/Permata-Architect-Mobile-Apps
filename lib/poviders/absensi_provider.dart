import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:permata_architect_mobile_apps/api/api_get_absensis.dart';
import 'package:permata_architect_mobile_apps/models/auth_model/user_model.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/absensi_model.dart';

enum ResultAbsensi { loading, noData, hasData, error, first }

class AbsensiProvider extends ChangeNotifier {
  final GetAbsensiService getAbsensiService;
  StreamSubscription? _connectivitySubscription;
  String? _lastRequestedId;

  AbsensiProvider({required this.getAbsensiService}) {
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

  late ResultAbsensi _state;
  late List<AbsensiModel> _absensilist;
  late UserInfo _absensi;
  late String _message = '';

  String get message => _message;
  List<AbsensiModel> get absensilist => _absensilist;
  UserInfo get absensi => _absensi;
  ResultAbsensi get state => _state;

  Future<dynamic> fetchGetListAbsensi({String? idProyek}) async {
    _lastRequestedId = idProyek;
    try {
      _state = ResultAbsensi.loading;

      final getabsensilist =
          await getAbsensiService.getabsensi(idProyek: idProyek);
      notifyListeners();
      if (getabsensilist.isEmpty) {
        _state = ResultAbsensi.noData;
        notifyListeners();
        return _message = 'Empthy Data';
      } else {
        _state = ResultAbsensi.hasData;
        notifyListeners();
        return _absensilist = getabsensilist;
      }
    } on SocketException {
      _state = ResultAbsensi.error;
      notifyListeners();
      _message = '404';
    } catch (e) {
      _state = ResultAbsensi.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<bool> addAbsensi(
      {String? idProyek, String? idPekerja, String? statusAbsensi}) async {
    try {
      UserInfo absensi = await GetAbsensiService().addAbsensi(
          idProyek: idProyek,
          idPekerja: idPekerja,
          statusAbsensi: statusAbsensi);
      _absensi = absensi;
      return true;
    } on SocketException {
      _message = 'no internet';
      return false;
    } on Exception catch (e) {
      String error = e.toString();
      String newError = error.replaceAll('Exception: ', "");
      _message = newError;
      return false;
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      await fetchGetListAbsensi(idProyek: _lastRequestedId);
    }
  }
}
