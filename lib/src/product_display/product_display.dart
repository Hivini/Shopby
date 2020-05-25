import 'dart:async';

import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/database_handler/product.dart';
import 'package:Shopby/src/rating_handler/rating_handler.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:pq_toast/pq_toast.dart';

@Component(
  selector: 'product-display',
  templateUrl: 'product_display.html',
  providers: [overlayBindings],
  directives: [
    AutoDismissDirective,
    AutoFocusDirective,
    coreDirectives,
    DeferredContentDirective,
    MaterialButtonComponent,
    MaterialIconComponent,
    MaterialPersistentDrawerDirective,
    MaterialToggleComponent,
    MaterialListComponent,
    MaterialListItemComponent,
    MaterialDialogComponent,
    MaterialInputComponent,
    ModalComponent,
    RatingHandler,
  ],
  styleUrls: [
    '../../app_component.css',
    'package:angular_components/app_layout/layout.scss.css',
  ],
)
class ProductDisplay {
  final DatabaseHandlerService _dbService;
  final _deleteRequest = StreamController<String>();

  @Input()
  Product product;

  @Input()
  bool showRemoveButton = false;

  @Output()
  Stream<String> get reload => _deleteRequest.stream;

  bool showProductDialog = false;

  bool showRatingsHandler = false;

  ProductDisplay(this._dbService);

  void removeProduct() async {
    var response = await _dbService.deleteProduct(product.getProductId());
    if (response) {
      Toast.showInfoToast('Deleted product');
      _deleteRequest.add('reload');
    } else {
      Toast.showErrorToast('An error encountered when deleting the product');
    }
  }

  void buyProduct() async {
    var response = await _dbService.addToUserHistory(_dbService.currentUser.getEmail(), product);
    showProductDialog = false;
    showRatingsHandler = true;
    if (response) {
      Toast.showSuccessToast('Product has been bought');
    } else {
      Toast.showErrorToast('There was a problem when buying the product');
    }
  }
}
