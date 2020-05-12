import 'package:meta/meta.dart';

abstract class AbstractUser {
  @protected
  String email;

  @protected
  String name;

  @protected
  int role;

  AbstractUser(this.email, this.name, this.role);

  String getEmail() {
    return email;
  }

  String getName() {
    return name;
  }

  int getRole() {
    return role;
  }
}