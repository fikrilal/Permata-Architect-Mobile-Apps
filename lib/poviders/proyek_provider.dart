import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permata_architect_mobile_apps/api/list_cost_proyek_api.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_cost_proyek_model.dart';

enum ResulState { loading, noData, hasData, error, first }

class ListCostProyekProvider extends ChangeNotifier {
  final GetListCostProyekService getListCostProyekService;

  ListCostProyekProvider({required this.getListCostProyekService}) {
    fetchTotalProyek();
    notifyListeners();
  }
  late ResulState _state;
  late List<ListCostProyek> _listCostProyek;
  late String _message = '';

  String get message => _message;
  List<ListCostProyek> get listCostProyek => _listCostProyek;
  ResulState get state => _state;

  Future<dynamic> fetchTotalProyek() async {
    try {
      _state = ResulState.loading;
      notifyListeners();
      final listcostproyek = await getListCostProyekService.listproyekCost();
      if (listcostproyek.isEmpty) {
        _state = ResulState.noData;
        notifyListeners();
        return _message = 'Empthy Data';
      } else {
        _state = ResulState.hasData;
        notifyListeners();
        return _listCostProyek = listcostproyek;
      }
    } on SocketException {
      _state = ResulState.error;
      notifyListeners();
      _message = '404';
    } catch (e) {
      _state = ResulState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
