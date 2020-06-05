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

  /// Tries to login into the database.
  ///
  /// The database endpoint receives and email and password on the headers,
  /// so we do a post HTTP request on the server to login. If the user inserts
  /// the valid credentials returns [true] else [false]
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

  /// Registers the user on the database.
  ///
  /// Sends a post HTTP request to the database to register the user. Afterwards
  /// verifies the answer of the database to check if it was valid.
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

  /// Registers the product of the user
  ///
  /// Sends an post HTTP request to the server with the information about the
  /// to be registered product.
  Future<bool> registerProduct(String email, String title, String description, num price, String imageUrl) async {
    try {
      var body = {
        'email': email,
        'title': title,
        'description': description,
        'price': price.toString(), // Needs to be String because Dart library limitations.
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

  /// Get products of the user.
  ///
  /// Creates a get HTTP request to the server with the email of the user.
  /// If the user does have products the response it's transformed into
  /// [Product] objects. If no products are found, returns an empty list.
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

  /// Deletes the product of the user.
  ///
  /// Sends a delete HTTP request to the server. Checks if the server could
  /// delete the product, if it did, it returns true, otherwise, false.
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

  /// Search for products that match with the queries.
  ///
  /// Creates a get HTTP request to the server with the keywords given by the
  /// user, if it's successful, it creates the products that are returned,
  /// if the search returns empty, it returns an empty list.
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

  /// Get the user chats
  ///
  /// Creates a get HTTP request with the user email, if it returns data creates
  /// a list of [Message] objects, otherwise, returns an empty list.
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

  /// Sends a new message to a user
  ///
  /// Creates a post HTTP request to the server with the information of [to]
  /// containing the email of destination user, [from] the email of the
  /// [currentUser] and [message] that contains the message to be sent.
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

  /// Add a rating to a product.
  ///
  /// Creates a post HTTP request to the server with the parameters [id]
  /// containing the ID of the [Product] and [rating] that contains the rating
  /// that the user gives. Return true if it was successful and false if not.
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

  /// Get the statistics of the page.
  ///
  /// Gets the statistics of the page and creates a list of numbers which are
  /// listed in the following way:
  /// - Products count
  /// - Users count
  /// - Messages count
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

  /// Registers a moderator in the database.
  ///
  /// Creates a post HTTP request that sends on the body the information of the
  /// user. Returns true if the server returns successful, else, false.
  Future<bool> registerModerator(email, password, name) async {
    try {
      var body = {
        'email': email,
        'password': password,
        'name': name,
        'role': '1',
        'phoneNumber': '', // No need for moderator.
        'deliveryDirection': '', // No need for moderator.
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

  /// Add to the user history the bought product.
  ///
  /// Creates post HTTP request that sends the [email] of the user, and the
  /// title, vendor and price of the [product]. Returns true if the server
  /// response with a successful message, else, false.
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

  /// Gets the user buy history.
  ///
  /// Creates a get HTTP request to the server with the users [email].
  /// If there is data on the response, it returns a List of [History] of each
  /// record. If no data is found returns null.
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

  /// Creates a [History] object given the attributes.
  History transformToHistory(num timestamp, String email, String title, String vendor, num price) {
    return History(timestamp, email, title, vendor, price);
  }

  /// Creates a [User] object given the attributes.
  User transformToUser(String email, String name, String role, String phoneNumber, String deliveryDirection) {
    return User(email, name, int.parse(role), phoneNumber, deliveryDirection);
  }

  /// Creates a [Product] object given the attributes.
  Product transformToProduct(productId, title, description, price, imageUrl, user, rating, totalRatings) {
    return Product(productId, title, description, price, imageUrl,
        transformToUser(user['email'], user['name'], user['role'],
            user['phoneNumber'], user['deliveryDirection']),
        rating, totalRatings);
  }

  /// Creates a [Message] object given the attributes.
  Message transformToMessage(String from, String message, num timestamp) {
    return Message(timestamp, from, message);
  }
}
