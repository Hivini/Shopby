import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/database_handler/product.dart';
import 'package:Shopby/src/product_display/product_display.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:pq_toast/pq_toast.dart';

@Component(
  selector: 'home',
  templateUrl: 'home.html',
  directives: [
    coreDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialInputComponent,
    MaterialButtonComponent,
    ProductDisplay,
  ],
)
class HomeComponent {
  final DatabaseHandlerService dbService;
  final Router _router;

  String previousSearch = '';
  String searchQuery = '';
  List<Product> searchedProducts = [];

  HomeComponent(this.dbService, this._router);

  void searchProducts() async {
    var query = searchQuery;
    if (searchedProducts != null && previousSearch != '') {
      query = previousSearch;
    }
    var prods = await dbService.searchProducts(query);
    searchedProducts = [];
    previousSearch = '';
    searchQuery = '';
    if (prods.isNotEmpty) {
      searchedProducts.addAll(prods);
    } else {
      Toast.showInfoToast('No products where found with your query');
    }
  }
}
