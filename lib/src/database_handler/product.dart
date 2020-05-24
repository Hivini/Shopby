import 'package:Shopby/src/database_handler/user.dart';

class Product {
  String _productId;
  String _title;
  String _description;
  String _imageUrl;
  User _user;
  num _rating;
  int _totalRatings;

  Product(this._productId, this._title, this._description, this._imageUrl,
      this._user, this._rating, this._totalRatings);

  String get productId => _productId;

  String get title => _title;

  String get description => _description;

  String get imageUrl => _imageUrl;

  User get user => _user;

  num get rating => _rating;

  int get totalRatings => _totalRatings;
}