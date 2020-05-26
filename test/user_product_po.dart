import 'package:pageloader/pageloader.dart';

part 'user_product_po.g.dart';

@PageObject()
abstract class UserProductPO {

  UserProductPO();
  factory UserProductPO.create(PageLoaderElement context) = $UserProductPO.create;

  @First(ByCss('.productInfoTitle'))
  PageLoaderElement get _productInfoTitle;

  @First(ByCss('.blue'))
  PageLoaderElement get _addProductButton;

  @ById('title')
  PageLoaderElement get _titleProductInput;

  String get productInfoTitle => _productInfoTitle.visibleText;

  Future<void> clickAddButton() => _addProductButton.click();

  String get titleInput => _titleProductInput.visibleText;
}