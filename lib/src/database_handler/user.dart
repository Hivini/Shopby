import 'package:Shopby/src/database_handler/abstract_user.dart';

class User extends AbstractUser {
  String _phoneNumber;
  String _deliveryDirection;

  User(String email, String name, int role, this._phoneNumber,
      this._deliveryDirection) : super(email, name, role);

  String get getPhoneNumber => _phoneNumber;

  String get getDeliveryDirection => _deliveryDirection;
}