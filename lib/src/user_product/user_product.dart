import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/database_handler/product.dart';
import 'package:Shopby/src/product_display/product_display.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'user-product',
  templateUrl: 'user_product.html',
  directives: [
    coreDirectives,
    ProductDisplay
  ],
)
class UserProduct implements OnInit {
  final DatabaseHandlerService _dbService;
  final Router _router;
  List<Product> userProducts;

  UserProduct(this._dbService, this._router) {
    userProducts = [];
  }

  @override
  void ngOnInit() async {
    if (_dbService.currentUser == null) {
      await _router.navigate('/home');
    } else {
      userProducts = await _dbService.getProductsByUser(_dbService.currentUser.getEmail());
    }
  }
}
