import 'dart:convert';
import 'dart:io';
import 'package:approve_reject_quotation/service/API_services/apiService.dart';
import 'package:approve_reject_quotation/utils/encryptDecrypt.dart';
import 'package:get/get.dart';

class Invoker extends GetxController {
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>?> GetbyToken(String API, String sToken) async {
    final requestData = {"STOKEN": sToken};
    final response = await apiService.postData(API, requestData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sToken, encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{"statusCode": response.statusCode!};
      decodedResponse.addEntries(result.entries.map((e) => MapEntry(e.key, e.value)));
      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {"statusCode": response.statusCode, "message": "Server Error"};
      return reply;
    }
  }

  Future<Map<String, dynamic>?> GetbyQueryString(Map<String, dynamic> body, String API, String sToken) async {
    final dataToEncrypt = jsonEncode(body);
    final encryptedData = AES.encryptWithAES(sToken, dataToEncrypt);

    Map<String, dynamic> formData = {"STOKEN": sToken, "querystring": encryptedData};
    final response = await apiService.postData(API, formData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sToken, encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{"statusCode": response.statusCode!};
      decodedResponse.addEntries(result.entries.map((e) => MapEntry(e.key, e.value)));
      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {"statusCode": response.statusCode, "message": "Server Error"};
      return reply;
    }
  }

  Future<Map<String, dynamic>?> multiPart(File file, String API, String sToken) async {
    FormData formData = FormData({
      "file": MultipartFile(file, filename: file.path.split('/').last), // Attach file
      "STOKEN": sToken,
    });
    final response = await apiService.postMulter(API, formData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sToken, encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{"statusCode": response.statusCode!};
      decodedResponse.addEntries(result.entries.map((e) => MapEntry(e.key, e.value)));

      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {"statusCode": response.statusCode, "message": "Server Error"};
      return reply;
    }
  }

  Future<Map<String, dynamic>> Multer(String Token, String body, File file, String API, String sToken) async {
    final encryptedData = AES.encryptWithAES(sToken, body);

    FormData formData = FormData({
      "file": MultipartFile(file, filename: file.path.split('/').last), // Attach file
      "STOKEN": sToken,
      "querystring": encryptedData,
    });
    final response = await apiService.postMulter(API, formData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sToken, encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{"statusCode": response.statusCode!};
      decodedResponse.addEntries(result.entries.map((e) => MapEntry(e.key, e.value)));

      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {"statusCode": response.statusCode, "message": "Server Error"};
      return reply;
    }
  }

  Future<Map<String, dynamic>> SendByQuerystring(String body, String API, String sToken) async {
    final encryptedData = AES.encryptWithAES(sToken, body);

    final requestData = {"STOKEN": sToken, "querystring": encryptedData};

    final response = await apiService.post(API, requestData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sToken, encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{"statusCode": response.statusCode!};
      decodedResponse.addEntries(result.entries.map((e) => MapEntry(e.key, e.value)));

      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {"statusCode": response.statusCode, "message": "Server Error"};
      return reply;
    }
  }
}
