// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchController on _SearchControllerBase, Store {
  final _$filterEnumAtom = Atom(name: '_SearchControllerBase.filterEnum');

  @override
  FilterEnum get filterEnum {
    _$filterEnumAtom.reportRead();
    return super.filterEnum;
  }

  @override
  set filterEnum(FilterEnum value) {
    _$filterEnumAtom.reportWrite(value, super.filterEnum, () {
      super.filterEnum = value;
    });
  }

  final _$_SearchControllerBaseActionController =
      ActionController(name: '_SearchControllerBase');

  @override
  void setFilterEnum(FilterEnum filter) {
    final _$actionInfo = _$_SearchControllerBaseActionController.startAction(
        name: '_SearchControllerBase.setFilterEnum');
    try {
      return super.setFilterEnum(filter);
    } finally {
      _$_SearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filterEnum: ${filterEnum}
    ''';
  }
}
