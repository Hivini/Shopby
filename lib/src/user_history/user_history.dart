import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/database_handler/history.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'user-history',
  templateUrl: 'user_history.html',
  providers: [overlayBindings],
  directives: [
    coreDirectives,
  ],
  styleUrls: [
    '../../app_component.css',
    'package:angular_components/app_layout/layout.scss.css',
  ],
)
class UserHistory implements  OnInit {
  final DatabaseHandlerService _dbService;

  List<History> historyItems;

  bool showProductDialog = false;

  UserHistory(this._dbService);

  @override
  void ngOnInit() {
    // TODO: implement ngOnInit
  }
}
