import 'package:pageloader/pageloader.dart';

part 'user_product_po.g.dart';

@PageObject()
abstract class UserProductPO {

  UserProductPO();
  factory UserProductPO.create(PageLoaderElement context) = $UserProductPO.create;

  @First(ByCss('.productInfoTitle'))
  PageLoaderElement get _productInfoTitle;

  String get productInfoTitle => _productInfoTitle.visibleText;
}