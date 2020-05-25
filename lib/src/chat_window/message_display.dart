import 'dart:async';

import 'package:Shopby/src/database_handler/message.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'message-display',
  templateUrl: 'message_display.html',
  styleUrls: [
      'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
  ],
)
class MessageDisplay {
  final _sendRequest = StreamController<String>();

  @Input()
  String currentEmail;

  @Input()
  Message message;

  @Output()
  Stream<String> get reload => _sendRequest.stream;
}
