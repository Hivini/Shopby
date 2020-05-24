import 'dart:async';
import 'dart:convert';
import 'package:Shopby/src/database_handler/product.dart';
import 'package:Shopby/src/database_handler/user.dart';
import 'package:Shopby/config/credentials.dart' as credentials;
import 'package:http/http.dart';

class DatabaseHandlerService {
  static final _headers = {'Content-Type': 'application/json'};
  static const _dbUrl = credentials.dbUrl; // URL to web API
  final Client _http;
  User currentUser;

  DatabaseHandlerService(this._http);

  dynamic _extractData(Response resp) => json.decode(resp.body);

  Future<User> getUser(String email) async {
    try {
      final response = await _http.get('${_dbUrl}/users/getByEmail', headers: {'email': email});
      print(_extractData(response));
    } catch(e) {
      throw Future.error(e);
    }
  }

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
        'phoneNumber': password,
        'name': name,
        'role': '0',
        'phoneNumber': phoneNumber,
        'deliveryDirection': deliveryDirection,
      };
      final response = await _http.post('${_dbUrl}/users/registerUser', body: body);
      var data = _extractData(response);
      if (data['successful'] == 1) {
        print('sucessfulRegister');
        return true;
      }
      return false;
    } catch (e) {
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
          resultProds.add(transformToProduct(prod['_id'], prod['title'], prod['description'], prod['imageUrl'], prod['user'], prod['rating'], prod['totalRatings']));
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
      print(id);
      final response = await _http.delete('${_dbUrl}/products/deleteProduct', headers: {'_id': id});
      var data = _extractData(response);
      print(data);
      if (data['successful'] == 1) {
        return true;
      }
      return false;
    } catch (e) {
      throw Future.error(e);
    }
  }

  User transformToUser(String email, String name, String role, String phoneNumber, String deliveryDirection) {
    return User(email, name, int.parse(role), phoneNumber, deliveryDirection);
  }

  Product transformToProduct(productId, title, description, imageUrl, user, rating, totalRatings) {
    return Product(productId, title, description, imageUrl,
        transformToUser(user['email'], user['name'], user['role'],
            user['phoneNumber'], user['deliveryDirection']),
        rating, totalRatings);
  }
}
