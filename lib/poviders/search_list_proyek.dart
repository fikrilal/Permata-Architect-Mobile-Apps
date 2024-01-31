import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permata_architect_mobile_apps/api/list_proyek_api.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';

enum ResultsCari { loading, noData, hasData, error, first }

class SearchListProyek extends ChangeNotifier {
  final GetListProyekService getListProyekService;
  String? _lastRequestedId;
  StreamSubscription? _connectivitySubscription;

  SearchListProyek({required this.getListProyekService}) {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  List<ListProyek>? _searchResults;
  ResultsCari _state = ResultsCari.first;
  String _message = '';

  List<ListProyek>? get searchResults => _searchResults;
  ResultsCari get state => _state;
  String get message => _message;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != ConnectivityResult.none && _lastRequestedId != null) {
      await searchlist(_lastRequestedId!);
    }
  }

  Future<void> searchlist(String query) async {
    _lastRequestedId = query;
    try {
      _state = ResultsCari.loading;
      notifyListeners();
      final results = await getListProyekService.carilistproyek(query: query);
      notifyListeners();
      if (results.isEmpty) {
        _state = ResultsCari.noData;
        _message = 'No results found.';
      } else {
        _state = ResultsCari.hasData;
        _searchResults = results;
      }
    } on SocketException {
      _state = ResultsCari.error;
      notifyListeners();
      _message = '404';
    } catch (e) {
      _state = ResultsCari.error;
      _message = 'Error --> $e';
    }
    notifyListeners();
  }
}
