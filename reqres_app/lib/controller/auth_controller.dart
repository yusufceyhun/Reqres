import 'dart:convert';

import '../services/provider.dart';
import '../widgets/returnmessage.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<ReturnMessage> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        print(token);
        TokenProvider tokenProvider = TokenProvider();
        await tokenProvider.setToken(token);

        return ReturnMessage(true, "Login successful");
      } else {
        final errorMessage = jsonDecode(response.body)['error'];

        return ReturnMessage(false, errorMessage);
      }
    } catch (error) {
      return ReturnMessage(false, error.toString());
    }
  }

  Future<ReturnMessage> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/register'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];

        TokenProvider tokenProvider = TokenProvider();
        await tokenProvider.setToken(token);

        return ReturnMessage(true, "Registration successful");
      } else {
        final errorMessage = jsonDecode(response.body)['error'];

        return ReturnMessage(false, errorMessage);
      }
    } catch (error) {
      return ReturnMessage(false, error.toString());
    }
  }

  Future<ReturnMessage> signOut() async {
    try {
      TokenProvider tokenProvider = TokenProvider();
      await tokenProvider.removeToken();
      return ReturnMessage(true, "Sign-out successful");
    } catch (error) {
      return ReturnMessage(false, error.toString());
    }
  }
}
