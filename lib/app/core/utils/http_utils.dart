import 'package:html/parser.dart';

class HttpUtils {
  HttpUtils._();

  static String getForgetMessage(String data) {
    var document = parse(data);

    try {
      var element = document.getElementById("login_error");

      if (element != null) {
        return element.children.first.text;
      }

      return "Forget Password";
    } catch (e) {
      return "Forget Password";
    }
  }
}
