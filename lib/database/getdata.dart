import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestResult{
  bool ok;
  dynamic data;
  RequestResult(this.ok,this.data);
}
const protocol = "http";
const domain = "Your_IP:PORT";
Future<RequestResult> http_get_users(String route,[dynamic data])async{
  var dataStr = jsonEncode(data);
  var url = "$protocol://$domain/$route?data=$dataStr";
  var result = await http.get(url);
  return RequestResult(true,jsonDecode(result.body));
}
Future<RequestResult> http_post_register(String route,[dynamic data])async{
  var url = "$protocol://$domain/$route";
  var dataStr = jsonEncode(data);
  // print(dataStr);
//  print(dataStr);
  var result = await http.post(url,body: dataStr,headers: {"Content-Type":"application/json"});
  return RequestResult(true,jsonDecode(result.body));
}

Future<RequestResult> http_put_admin(String route,[dynamic data])async{
  var url = "$protocol://$domain/$route";
  var dataStr = jsonEncode(data);
//  print(dataStr);
  var result = await http.put(url,body: dataStr,headers: {"Content-Type":"application/json"});
  return RequestResult(true,jsonDecode(result.body));
}