import 'package:Shopby/src/chat_window/message_display.dart';
import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/database_handler/message.dart';
import 'package:Shopby/src/database_handler/user.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/angular_components.dart';
import 'package:pq_toast/pq_toast.dart';

@Component(
  selector: 'user-chat',
  templateUrl: 'chat_window.html',
  providers: [overlayBindings],
  directives: [
    AutoDismissDirective,
    AutoFocusDirective,
    coreDirectives,
    formDirectives,
    materialInputDirectives,
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
    MessageDisplay,
  ],
  styleUrls: [
    'chat_window.css',
    'package:angular_components/app_layout/layout.scss.css',
  ],
)
class ChatWindow implements OnInit {
  final DatabaseHandlerService _dbService;

  bool showNewChatDialog = false;
  User currentUser;
  Map<String, List<Message>> messagesMap;
  List<String> from = <String>[];
  List<Message> messages = <Message>[];
  String receiverEmail = '';
  String receiverMessage = '';
  String selectedUser = '';
  String newMessage = '';

  ChatWindow(this._dbService);

  @override
  void ngOnInit() {
    reload();
  }

  void reload() async {
    from = <String>[];
    currentUser = _dbService.currentUser;
    messagesMap = await _dbService.getUserMessages(currentUser.getEmail());
    if (messagesMap != null) {
      from.addAll(messagesMap.keys);
    }
  }

  void setMessages(String usr) {
    selectedUser = usr;
    messages = <Message>[];
    messages.addAll(messagesMap[usr]);
  }

  void sendNewMessage(String to, String from, String content, bool firstTime) async {
    var resp = await _dbService.sendNewMessage(to, from, content);
    if (resp) {
      if (firstTime) {
        Toast.showSuccessToast('New message sent');
      }
      reload();
    } else {
      Toast.showErrorToast('Something went wrong when sending the message');
    }
  }

  void processNewChat() {
    showNewChatDialog = false;
    sendNewMessage(receiverEmail, currentUser.getEmail(), receiverMessage, true);
    receiverEmail = '';
    receiverMessage = '';
  }

  void sendMessage() {
    sendNewMessage(selectedUser, currentUser.getEmail(), newMessage, false);
    setMessages(selectedUser);
    newMessage = '';
  }
}
