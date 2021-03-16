// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabs_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TabsController on _TabsControllerBase, Store {
  final _$currentTabIndexAtom =
      Atom(name: '_TabsControllerBase.currentTabIndex');

  @override
  int get currentTabIndex {
    _$currentTabIndexAtom.reportRead();
    return super.currentTabIndex;
  }

  @override
  set currentTabIndex(int value) {
    _$currentTabIndexAtom.reportWrite(value, super.currentTabIndex, () {
      super.currentTabIndex = value;
    });
  }

  final _$_TabsControllerBaseActionController =
      ActionController(name: '_TabsControllerBase');

  @override
  void setCurrentTabIndex(int index) {
    final _$actionInfo = _$_TabsControllerBaseActionController.startAction(
        name: '_TabsControllerBase.setCurrentTabIndex');
    try {
      return super.setCurrentTabIndex(index);
    } finally {
      _$_TabsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentTabIndex: ${currentTabIndex}
    ''';
  }
}
