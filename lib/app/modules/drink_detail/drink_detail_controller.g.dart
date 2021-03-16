// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DrinkDetailController on _DrinkDetailControllerBase, Store {
  final _$langCodeAtom = Atom(name: '_DrinkDetailControllerBase.langCode');

  @override
  String get langCode {
    _$langCodeAtom.reportRead();
    return super.langCode;
  }

  @override
  set langCode(String value) {
    _$langCodeAtom.reportWrite(value, super.langCode, () {
      super.langCode = value;
    });
  }

  final _$isPanelOpenAtom =
      Atom(name: '_DrinkDetailControllerBase.isPanelOpen');

  @override
  bool get isPanelOpen {
    _$isPanelOpenAtom.reportRead();
    return super.isPanelOpen;
  }

  @override
  set isPanelOpen(bool value) {
    _$isPanelOpenAtom.reportWrite(value, super.isPanelOpen, () {
      super.isPanelOpen = value;
    });
  }

  final _$_DrinkDetailControllerBaseActionController =
      ActionController(name: '_DrinkDetailControllerBase');

  @override
  void setIsPanelOpen(bool status) {
    final _$actionInfo = _$_DrinkDetailControllerBaseActionController
        .startAction(name: '_DrinkDetailControllerBase.setIsPanelOpen');
    try {
      return super.setIsPanelOpen(status);
    } finally {
      _$_DrinkDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLangCode(String code) {
    final _$actionInfo = _$_DrinkDetailControllerBaseActionController
        .startAction(name: '_DrinkDetailControllerBase.setLangCode');
    try {
      return super.setLangCode(code);
    } finally {
      _$_DrinkDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
langCode: ${langCode},
isPanelOpen: ${isPanelOpen}
    ''';
  }
}
