import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:health_app/services/overlay_services.dart';

class BottomNavigationProvider extends ChangeNotifier {
  final PageController _controller = PageController();

  PageController get controller => _controller;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  changeIndex(BuildContext context, int newIndex) {
    if (newIndex == 2) {
      OverlayServices.showEmergencyModal(context);
    } else {
      _currentIndex = newIndex;
      controller.jumpToPage(newIndex);
      notifyListeners();
    }
  }

  dispose() {
    controller.dispose();
  }
}
