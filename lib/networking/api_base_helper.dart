import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:loyaltyapp/authentication/models/authentication_model.dart';
import 'package:loyaltyapp/networking/api_exceptions.dart';
import 'package:loyaltyapp/registration/registration_model.dart';

class ApiBaseHelper {
   static final String _baseUrl =
      "https://loyaltyapp.pgbison.co.ke/";
      //"http://tenepl-002-site1.htempurl.com/"; //"""http://105.161.151.4:8000/";// "http://192.168.40.12:8000/";//
      //"http://192.168.40.24:8000/";//
  static final String _tokenUrl = "api/login/authenticate";

  static final Map<String, String> requestHeaders = {
    'RequestType': 'Mobile',
    'X-Requested-With': 'XMLHttpRequest',
    'Token': 'wTzMKIAfW742VOX2GqgwMYgmC8vYsymToxtkULEcBAPuKsI5s9ZBVvM2giin'
  };

  static String baseUrl() {
    return _baseUrl;
  }

  Future<dynamic> get(String url, String token) async {
    print('Api Get, url $url');

    Map<String, String> requestHeaders = {
      'Token':
          token, //'wTzMKIAfW742VOX2GqgwMYgmC8vYsymToxtkULEcBAPuKsI5s9ZBVvM2giin',
      'Charset': 'utf-8',
      'Content-Type': 'application/json;charset=UTF-8',
      'X-Requested-With': 'XMLHttpRequest',
      'RequestType': 'Mobile'
    };

    var responseJson;
    try {
      var uri = Uri.parse(ApiBaseHelper._baseUrl + url);
      //uri.path= ApiBaseHelper._baseUrl + url;
      final response =
          await  http.get(uri, headers: requestHeaders);
      //print("Get Resp");
      //print(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    //print('Api get received');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, String token) async {
    //print('API Post, url $url <Body> $body');
    var responseJson;
    try {
      Map<String, String> requestHeaders = {
        'Token':
            token, //'wTzMKIAfW742VOX2GqgwMYgmC8vYsymToxtkULEcBAPuKsI5s9ZBVvM2giin',
        'Charset': 'utf-8',
        'X-Requested-With': 'XMLHttpRequest',
        'RequestType': 'Mobile'
      };
      var uri = Uri.parse(ApiBaseHelper._baseUrl + url);
      final response = await http.post(uri,
          body: body, headers: requestHeaders);
      //print(response.body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    //print('Api put, url $url');
    var responseJson;
    try {
      var uri = Uri.parse(ApiBaseHelper._baseUrl + url);
      final response = await http.put(uri, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      //print('No net');
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    //print('Api delete, url $url');
    var apiResponse;
    try {
      var uri = Uri.parse(ApiBaseHelper._baseUrl + url);
      final response = await http.delete(uri);
      apiResponse = _returnResponse(response);
    } on SocketException {
      //print('No net');
      throw FetchDataException('No Internet Connection');
    }
    return apiResponse;
  }

  Future<Map<String, dynamic>> getToken(
      AuthenticationModel authenticationModel) async {
    var responseJson;
    try {
      //,text/javascript, */*; q=0.01 'Content-type': 'application/json;charset=UTF-8',
      Map<String, String> requestHeaders = {
        'RequestType': 'Mobile',
        'Charset': 'utf-8',
        'X-Requested-With': 'XMLHttpRequest',
        'XSRF-TOKEN': 'rEhGfZhMW5eGdI2EffF0g5kgYUwUItrjfUIDx73n',
        'Token': ''
      };
      //print(ApiBaseHelper._baseUrl + ApiBaseHelper._tokenUrl);
      var uri = Uri.parse(ApiBaseHelper._baseUrl + ApiBaseHelper._tokenUrl);
      final response = await http.post(
          uri,
          body: authenticationModel.toJson(),
          headers: requestHeaders);
      //print(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      //print('no net');
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> forgotPassword(
      Map<String, dynamic> forgotPasswordJson, String token) async {
    var responseJson;
    try {
      Map<String, String> requestHeaders = {
        /*'RequestType': 'Mobile',
        'Charset': 'utf-8',
        'X-Requested-With': 'XMLHttpRequest',
        'XSRF-TOKEN': 'rEhGfZhMW5eGdI2EffF0g5kgYUwUItrjfUIDx73n',
        'Token': ''*/
        'Token': token, //'wTzMKIAfW742VOX2GqgwMYgmC8vYsymToxtkULEcBAPuKsI5s9ZBVvM2giin',
        'Charset': 'utf-8',
        'X-Requested-With': 'XMLHttpRequest',
        'RequestType': 'Mobile'
      };
      print(ApiBaseHelper._baseUrl + "api/login/forgotpassword");
      var uri = Uri.parse(ApiBaseHelper._baseUrl + "api/login/forgotpassword");
      final response = await http.post(
          uri,
          body: forgotPasswordJson,
          headers: requestHeaders);
      print(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> getWhat3Words(What3Words what3words) async {
    var responseJson;
    print("GET 3 Words");
    try {
      Map<String, dynamic> parameters = {
        "lat": what3words.lat,
        "long": what3words.long
      };

      var uri =
          Uri.http(ApiBaseHelper._baseUrl, "register/what3words", parameters);
      final response =
          await http.get(uri, headers: ApiBaseHelper.requestHeaders);
      //print("RESPONSE ${response.body.toString()}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communicating with server with status code : ${response.statusCode} ${response.body.toString()}');
    }
  }
}
