import 'package:Shopby/src/database_handler/abstract_user.dart';

class PrivilegedUser extends AbstractUser{
  PrivilegedUser(String email, String name, int role) : super(email, name, role);
}