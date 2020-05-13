
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/http_exception.dart';

class Auth with ChangeNotifier{

  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth{
    return token != null;
  }
  String get userId{
    return _userId;
  } 

  String get token {
    if(_token != null && _expiryDate.isAfter(DateTime.now()) && _expiryDate != null){
      return _token;
    }
    return null;
  }
  Future<void> requestBody(
    String email, String password, String urlPeace) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlPeace?key=AIzaSyDh2o3wiv3QF96rD3elw7CZ8ESD6lPq3P4';
    try{
       final response = await http.post(
        url, 
        body: json.encode(
      {
        'email':email,
        'password' : password,
        'returnSecureToken':true,
      }
    )
    );
    print(json.decode(response.body));
    final responseDate = json.decode(response.body);
    if(responseDate['error'] != null){
      throw HttpException(responseDate['error']['message']);
    }
    _token = responseDate['idToken'];
    _userId = responseDate['localId'];
    _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseDate['expiresIn']
    )
    )
    );
    autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token':_token,
      'userId':_userId,
      'expiryDate':_expiryDate.toIso8601String()
    });
    prefs.setString('userData', userData);
    }catch(error){
      throw error;
    }  
  } 
  Future<bool> autoLogin () async {

    final prefs = await SharedPreferences.getInstance();
    if(! prefs.containsKey('userData')){
      return false;
    }
    final extractData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractData['expiryDate']);
    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }
    _token =extractData['token'];
    _userId = extractData['userId'];
    _expiryDate = extractData['expiryDate'];
    notifyListeners();
    autoLogout(); // to set the timer again
    return true;
  }
  Future<void> singup(String email, String password) async{
    return requestBody(email, password, 'signUp');    
  }

  Future<void> login(String email, String password) async{
    return requestBody(email, password, 'signInWithPassword');
    
  }
  void logout(){
    _token = null;
    _expiryDate = null;
    _userId = null;
    if(_authTimer != null){
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }
  void autoLogout(){
    if(_authTimer != null){
      _authTimer.cancel();
    }
    final expiredTime = _expiryDate.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: expiredTime), logout);
  }

}