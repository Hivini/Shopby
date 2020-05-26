// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_component_po.dart';

// **************************************************************************
// PageObjectGenerator
// **************************************************************************

// ignore_for_file: private_collision_in_mixin_application
class $AppComponentPO extends AppComponentPO with $$AppComponentPO {
  PageLoaderElement $__root__;
  $AppComponentPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $AppComponentPO.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "AppComponentPO is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "AppComponentPO". Requires @CheckTag annotation in order for "tagName" to be generated.';
  String get loginButtonText {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('AppComponentPO', 'loginButtonText');
    }
    final returnMe = super.loginButtonText;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('AppComponentPO', 'loginButtonText');
    }
    return returnMe;
  }

  String get registerButtonText {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('AppComponentPO', 'registerButtonText');
    }
    final returnMe = super.registerButtonText;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('AppComponentPO', 'registerButtonText');
    }
    return returnMe;
  }

  String get loginTitle {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('AppComponentPO', 'loginTitle');
    }
    final returnMe = super.loginTitle;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('AppComponentPO', 'loginTitle');
    }
    return returnMe;
  }

  String get productsButtonText {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('AppComponentPO', 'productsButtonText');
    }
    final returnMe = super.productsButtonText;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('AppComponentPO', 'productsButtonText');
    }
    return returnMe;
  }

  String toStringDeep() => 'AppComponentPO\n\n${$__root__.toStringDeep()}';
}

class $$AppComponentPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__;
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get _loginButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('AppComponentPO', '_loginButton');
    }
    final element = $__root__.createElement(ById('loginButton'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('AppComponentPO', '_loginButton');
    }
    return returnMe;
  }

  PageLoaderElement get _registerButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('AppComponentPO', '_registerButton');
    }
    final element = $__root__.createElement(ById('registerButton'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('AppComponentPO', '_registerButton');
    }
    return returnMe;
  }

  PageLoaderElement get _loginTitle {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('AppComponentPO', '_loginTitle');
    }
    final element = $__root__.createElement(ById('loginTitle'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('AppComponentPO', '_loginTitle');
    }
    return returnMe;
  }

  PageLoaderElement get _productsButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('AppComponentPO', '_productsButton');
    }
    final element = $__root__.createElement(ById('productsButton'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('AppComponentPO', '_productsButton');
    }
    return returnMe;
  }
}
