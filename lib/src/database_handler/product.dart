import 'package:Shopby/src/database_handler/user.dart';

class Product {
  String _productId;
  String _title;
  String _description;
  num _price;
  String _imageUrl;
  User _user;
  num _rating;
  int _totalRatings;

  Product(this._productId, this._title, this._description, this._price,
      this._imageUrl, this._user, this._rating, this._totalRatings);

  String getProductId() => _productId;

  int getTotalRatings() => _totalRatings;

  num getRating() => _rating;

  User getUser() => _user;

  String getImageUrl() => _imageUrl;

  num getPrice() => _price;

  String getDescription() => _description;

  String getTitle() => _title;
}