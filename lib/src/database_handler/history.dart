class History {
  num _timestamp;
  String _email;
  String _title;
  String _vendor;
  num _price;

  History(this._timestamp, this._email, this._title, this._vendor, this._price);

  num get price => _price;

  String get vendor => _vendor;

  String get title => _title;

  String get email => _email;

  num get timestamp => _timestamp;
}