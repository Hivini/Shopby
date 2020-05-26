// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_product_po.dart';

// **************************************************************************
// PageObjectGenerator
// **************************************************************************

// ignore_for_file: private_collision_in_mixin_application
class $UserProductPO extends UserProductPO with $$UserProductPO {
  PageLoaderElement $__root__;
  $UserProductPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $UserProductPO.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "UserProductPO is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "UserProductPO". Requires @CheckTag annotation in order for "tagName" to be generated.';
  String get productInfoTitle {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('UserProductPO', 'productInfoTitle');
    }
    final returnMe = super.productInfoTitle;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('UserProductPO', 'productInfoTitle');
    }
    return returnMe;
  }

  String get titleInput {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('UserProductPO', 'titleInput');
    }
    final returnMe = super.titleInput;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('UserProductPO', 'titleInput');
    }
    return returnMe;
  }

  Future<void> clickAddButton() {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('UserProductPO', 'clickAddButton');
    }
    final returnMe = super.clickAddButton();
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('UserProductPO', 'clickAddButton');
    }
    return returnMe;
  }

  String toStringDeep() => 'UserProductPO\n\n${$__root__.toStringDeep()}';
}

class $$UserProductPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__;
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get _productInfoTitle {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('UserProductPO', '_productInfoTitle');
    }
    final element =
        $__root__.createElement(First(ByCss('.productInfoTitle')), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('UserProductPO', '_productInfoTitle');
    }
    return returnMe;
  }

  PageLoaderElement get _addProductButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('UserProductPO', '_addProductButton');
    }
    final element = $__root__.createElement(First(ByCss('.blue')), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('UserProductPO', '_addProductButton');
    }
    return returnMe;
  }

  PageLoaderElement get _titleProductInput {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('UserProductPO', '_titleProductInput');
    }
    final element = $__root__.createElement(ById('title'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('UserProductPO', '_titleProductInput');
    }
    return returnMe;
  }
}
