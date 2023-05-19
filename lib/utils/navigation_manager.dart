import 'package:flutter/material.dart';

class NavigationManager {
  final List<Widget> pages = [
    Text('1111111111'),
    Text('2222222222222'),
    Text('333333333'),
  ];

  int currentIndex = 0;
  List<int> navigationStack = [0];

  void navigateTo(int index) {
    if (index != currentIndex) {
      currentIndex = index;
      navigationStack.add(index);
    }
  }

  bool goBack() {
    if (navigationStack.length > 1) {
      navigationStack.removeLast();
      currentIndex = navigationStack.last;
      return true;
    }
    return false;
  }

  Widget getCurrentPage() {
    return pages[currentIndex];
  }
}
