import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/database_handler/history.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:intl/intl.dart';

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

  List<History> historyItems = <History>[];

  bool showProductDialog = false;

  UserHistory(this._dbService);

  @override
  void ngOnInit() async {
    historyItems = <History>[];
    var resp = await _dbService.getUserHistory(_dbService.currentUser.getEmail());
    if (resp != null) {
      historyItems.addAll(resp);
    }
  }

  String formatDate(num stamp) {
    var formatter = DateFormat('yyyy-MM-dd');
    var formatted = formatter.format(DateTime.fromMillisecondsSinceEpoch(stamp));
    return formatted;
  }
}
