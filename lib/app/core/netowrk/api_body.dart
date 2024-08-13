class ApiBody {
  ApiBody._();

  static Map<String, String> lostPassword({required String userLogin}) {
    return {"user_login": "chnoman503@gmail.com"};
  }
}

class LostPasswordBody {
  final String userLogin;

  LostPasswordBody({required this.userLogin});

  Map<String, String> toJson() => {
        "user_login": userLogin,
      };
}
