import 'package:pageloader/pageloader.dart';

part 'app_component_po.g.dart';

@PageObject()
abstract class AppComponentPO {

  AppComponentPO();
  factory AppComponentPO.create(PageLoaderElement context) = $AppComponentPO.create;

  @ById('loginButton')
  PageLoaderElement get _loginButton;

  @ById('registerButton')
  PageLoaderElement get _registerButton;

  @ById('loginTitle')
  PageLoaderElement get _loginTitle;

  @ById('productsButton')
  PageLoaderElement get _productsButton;

  String get loginButtonText => _loginButton.visibleText;

  String get registerButtonText => _registerButton.visibleText;

  String get loginTitle => _loginTitle.visibleText;

  String get productsButtonText => _productsButton.visibleText;
}