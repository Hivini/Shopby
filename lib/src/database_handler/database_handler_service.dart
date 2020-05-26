import 'dart:async';
import 'dart:convert';
import 'package:Shopby/src/database_handler/message.dart';
import 'package:Shopby/src/database_handler/product.dart';
import 'package:Shopby/src/database_handler/user.dart';
import 'package:Shopby/config/credentials.dart' as credentials;
import 'package:http/http.dart';

import 'history.dart';

class DatabaseHandlerService {
  static const _dbUrl = credentials.dbUrl; // URL to web API
  final Client _http;
  User currentUser;

  DatabaseHandlerService(this._http);

  dynamic _extractData(Response resp) => json.decode(resp.body);

  Future<bool> login(String email, String password) async {
    try {
      final response = await _http.post('${_dbUrl}/users/loginUser', headers: {'email':email, 'password':password});
      var data = _extractData(response);
      if (data['email'] != null) {
        currentUser = transformToUser(data['email'], data['name'], data['role'], data['phoneNumber'], data['deliveryDirection']);
        return true;
      }
      return false;
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<bool> registerUser(String email, String password, String name, String phoneNumber, String deliveryDirection) async {
    try {
      var body = {
        'email': email,
        'password': password,
        'name': name,
        'role': '0',
        'phoneNumber': phoneNumber,
        'deliveryDirection': deliveryDirection,
      };
      final response = await _http.post('${_dbUrl}/users/registerUser', body: body);
      var data = _extractData(response);
      if (data['successful'] == 1) {
        return true;
      }
      return false;
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<bool> registerProduct(String email, String title, String description, num price, String imageUrl) async {
    try {
      var body = {
        'email': email,
        'title': title,
        'description': description,
        'price': price.toString(),
        'imageUrl': imageUrl
      };
      var response = await _http.post('${_dbUrl}/products/registerProduct', body: body);
      var data = _extractData(response);
      if (data['successful'] == 1) {
        return true;
      }
      return false;
    } catch(e) {
      throw Future.error(e);
    }
  }

  Future<List<Product>> getProductsByUser(String email) async {
    try {
      final response = await _http.get('${_dbUrl}/products/getAllProductsByUser', headers: {'email': email});
      var data = _extractData(response);
      if (data['successful'] == 1) {
        var products = data['products'];
        var resultProds = <Product>[];
        for (var prod in products) {
          resultProds.add(transformToProduct(prod['_id'], prod['title'], prod['description'], prod['price'], prod['imageUrl'], prod['user'], prod['rating'], prod['totalRatings']));
        }
        return resultProds;
      } else {
        return <Product>[];
      }
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final response = await _http.delete('${_dbUrl}/products/deleteProduct', headers: {'_id': id});
      var data = _extractData(response);
      if (data['successful'] == 1) {
        return true;
      }
      return false;
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      var response = await _http.get('${_dbUrl}/products/searchProduct', headers: {'query': query});
      var data = _extractData(response);
      if (data['successful'] == 1 && data['products'].length > 0) {
        var products = data['products'];
        var resultProds = <Product>[];
        for (var prod in products) {
          resultProds.add(transformToProduct(prod['_id'], prod['title'], prod['description'], prod['price'], prod['imageUrl'], prod['user'], prod['rating'], prod['totalRatings']));
        }
        return resultProds;
      } else {
        return <Product>[];
      }
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<Map<String, List<Message>>> getUserMessages(String user) async {
    try {
      var response = await _http.get('${_dbUrl}/chat/getUserMessages', headers: {'user': user});
      var data = _extractData(response);
      if (data.length > 0) {
        var resultMessages = <String, List<Message>>{};
        for (var d in data) {
          var messages = d['messages'];
          var users = d['users'];
          var otherUser = users[0] != user ? users[0] : users[1];
          resultMessages[otherUser] = <Message>[];
          for (var msg in messages) {
            resultMessages[otherUser].add(transformToMessage(msg['from'], msg['message'], msg['timestamp']));
          }
        }
        return resultMessages;
      } else {
        return null;
      }
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<bool> sendNewMessage(String to, String from, String message) async {
    try {
      var response = await _http.post('${_dbUrl}/chat/saveMessage', headers: {'to': to, 'from': from, 'message': message});
      var data = _extractData(response);
      if (data['successful'] == 1) {
        return true;
      }
      return false;
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<bool> addToRatings(String id, String rating) async {
    try {
      var response = await _http.post('${_dbUrl}/products/addToRatings', headers: {'id': id, 'rating': rating});
      var data = _extractData(response);
      if (data['successful'] == 1) {
        return true;
      }
      return false;
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<List<num>> getStatistics() async {
    try {
      var response = await _http.get('${_dbUrl}/users/getStatistics');
      var data = _extractData(response);
      var lst = <num>[];
      lst.add(data[0]);
      lst.add(data[1]);
      lst.add(data[2]);
      lst.add(0);
      return lst;
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<bool> registerModerator(email, password, name) async {
    try {
      var body = {
        'email': email,
        'password': password,
        'name': name,
        'role': '1',
        'phoneNumber': '',
        'deliveryDirection': '',
      };
      final response = await _http.post('${_dbUrl}/users/registerUser', body: body);
      var data = _extractData(response);
      if (data['successful'] == 1) {
        return true;
      }
      return false;
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<bool> addToUserHistory(String email, Product product) async {
    try {
      var response = await _http.post('${_dbUrl}/users/addUserHistory', headers:
      {'email': email, 'title': product.getTitle(),
        'vendor': product.getUser().getEmail(),
        'price': product.getPrice().toString()});
      var data = _extractData(response);
      if (data['successful'] == 1) {
        return true;
      }
      return false;
    } catch (e) {
      throw Future.error(e);
    }
  }

  History transformToHistory(num timestamp, String email, String title, String vendor, num price) {
    return History(timestamp, email, title, vendor, price);
  }

  Future<List<History>> getUserHistory(String email) async {
    try {
      var response = await _http.get('${_dbUrl}/users/getUserHistory', headers: {'email': email});
      var data = _extractData(response);
      if (data.length > 0) {
        var resultHistory = <History>[];
        for (var d in data) {
          resultHistory.add(transformToHistory(d['timestamp'], d['email'], d['title'], d['vendor'], d['price']));
        }
        return resultHistory;
      } else {
        return null;
      }
    } catch (e) {
      throw Future.error(e);
    }
  }

  User transformToUser(String email, String name, String role, String phoneNumber, String deliveryDirection) {
    return User(email, name, int.parse(role), phoneNumber, deliveryDirection);
  }

  Product transformToProduct(productId, title, description, price, imageUrl, user, rating, totalRatings) {
    return Product(productId, title, description, price, imageUrl,
        transformToUser(user['email'], user['name'], user['role'],
            user['phoneNumber'], user['deliveryDirection']),
        rating, totalRatings);
  }

  Message transformToMessage(String from, String message, num timestamp) {
    return Message(timestamp, from, message);
  }
}
