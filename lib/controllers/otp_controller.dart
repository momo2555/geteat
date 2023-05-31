import 'package:http/http.dart' as http;
import 'dart:convert';
class OtpController {
  final String _accountSid = "ACa70eb61eb54d8fa736cf8673ae967c72";
  final String _authToken = "1e6b68ee2bfdb31bdb5a294b7610e805";
  final String _channel = "sms";
  void sendOtpMessage(String phoneNumber) async {
    var url = Uri.parse(
        "https://verify.twilio.com/v2/Services/VAac781eb5d1cd14c7681cac1da96a304f/Verifications");
    var requestBody = {
      'To': phoneNumber,
      'Channel': _channel,
    };    
    var response = await http.post(url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$_accountSid:$_authToken')),
      },
      body: Uri(queryParameters: requestBody).query,
    );
    

  }
  Future<bool> verifyCode(String phoneNumber, String OtpCode) async {
    print("check phone $OtpCode phone = $phoneNumber");
    var url = Uri.parse(
        "https://verify.twilio.com/v2/Services/VAac781eb5d1cd14c7681cac1da96a304f/VerificationCheck");
    var requestBody = {
      'To': phoneNumber,
      'Code': OtpCode,
    };    
    var response = await http.post(url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$_accountSid:$_authToken')),
      },
      body: Uri(queryParameters: requestBody).query,
    );
    print(response.statusCode);
    print(response.body);
    var parsedBody = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return parsedBody["status"] == "approved";
    }else {
      return false;
    }
    
  }
}
