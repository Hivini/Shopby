import 'package:pageloader/pageloader.dart';

part 'home_po.g.dart';

@PageObject()
abstract class HomePO {

  HomePO();
  factory HomePO.create(PageLoaderElement context) = $HomePO.create;

  @First(ByCss('.productInfoTitle'))
  PageLoaderElement get _productInfoTitle;

  @ById('search')
  PageLoaderElement get _searchInput;

  @ById('searchButton')
  PageLoaderElement get _searchButton;

  String get productInfoTitle => _productInfoTitle.visibleText;

  Future<void> clickSearch() => _searchButton.click();

  Future<void> typeSearch(String s) => _searchInput.type(s);
}