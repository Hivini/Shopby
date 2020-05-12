import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:angular/angular.dart';

import 'src/todo_list/todo_list_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [TodoListComponent],
)
class AppComponent implements OnInit {
  final DatabaseHandlerService _dbService;

  AppComponent(this._dbService);

  @override
  void ngOnInit() => _startFunc();

  void _startFunc() {
    try {
      _dbService.getUser('test1@gmail.com');
    } catch (e) {
      print(e);
    }
  }

}
