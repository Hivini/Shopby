// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_po.dart';

// **************************************************************************
// PageObjectGenerator
// **************************************************************************

// ignore_for_file: private_collision_in_mixin_application
class $HomePO extends HomePO with $$HomePO {
  PageLoaderElement $__root__;
  $HomePO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $HomePO.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "HomePO is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "HomePO". Requires @CheckTag annotation in order for "tagName" to be generated.';
  String get productInfoTitle {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('HomePO', 'productInfoTitle');
    }
    final returnMe = super.productInfoTitle;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('HomePO', 'productInfoTitle');
    }
    return returnMe;
  }

  Future<void> clickSearch() {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('HomePO', 'clickSearch');
    }
    final returnMe = super.clickSearch();
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('HomePO', 'clickSearch');
    }
    return returnMe;
  }

  Future<void> typeSearch(String s) {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('HomePO', 'typeSearch');
    }
    final returnMe = super.typeSearch(s);
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('HomePO', 'typeSearch');
    }
    return returnMe;
  }

  String toStringDeep() => 'HomePO\n\n${$__root__.toStringDeep()}';
}

class $$HomePO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__;
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get _productInfoTitle {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('HomePO', '_productInfoTitle');
    }
    final element =
        $__root__.createElement(First(ByCss('.productInfoTitle')), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('HomePO', '_productInfoTitle');
    }
    return returnMe;
  }

  PageLoaderElement get _searchInput {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('HomePO', '_searchInput');
    }
    final element = $__root__.createElement(ById('search'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('HomePO', '_searchInput');
    }
    return returnMe;
  }

  PageLoaderElement get _searchButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('HomePO', '_searchButton');
    }
    final element = $__root__.createElement(ById('searchButton'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('HomePO', '_searchButton');
    }
    return returnMe;
  }
}
