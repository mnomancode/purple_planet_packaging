class LocalStorage {
  static LocalStorage? _instance;

  static LocalStorage get instance => _instance ??= LocalStorage();
}
