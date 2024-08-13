class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

// class ResponseMessage {
//   static const String SUCCESS = AppStrings.success; // success with data
//   static const String NO_CONTENT = AppStrings.success; // success with no data (no content)
//   static const String BAD_REQUEST = AppStrings.strBadRequestError; // failure, API rejected request
//   static const String UNAUTORISED = AppStrings.strUnauthorizedError; // failure, user is not authorised
//   static const String FORBIDDEN = AppStrings.strForbiddenError; //  failure, API rejected request
//   static const String INTERNAL_SERVER_ERROR = AppStrings.strInternalServerError; // failure, crash in server side
//   static const String NOT_FOUND = AppStrings.strNotFoundError; // failure, crash in server side

//   // local status code
//   static const String CONNECT_TIMEOUT = AppStrings.strTimeoutError;
//   static const String CANCEL = AppStrings.strDefaultError;
//   static const String RECIEVE_TIMEOUT = AppStrings.strTimeoutError;
//   static const String SEND_TIMEOUT = AppStrings.strTimeoutError;
//   static const String CACHE_ERROR = AppStrings.strCacheError;
//   static const String NO_INTERNET_CONNECTION = AppStrings.strNoInternetError;
//   static const String DEFAULT = AppStrings.strDefaultError;
// }
