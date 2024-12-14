/// Here the singleton pattern is used so that only one instance can be created wherever we use it and not more than that

import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  // In order to specify the local storage for a specific user who is logged in we need to use bucket of GetStorage
  // For that we need to paas the id or something to GetStorage i.e: GetStorage('CwT');
  // To do this we need a variable of GetStorage which has currently nothing assigned
  late final GetStorage _storage;

  // Here we have created an instance of TLocalStorage and we are calling the TLocalStorage._internal() below again and again whenever this function is called.
  // The instance is created as below earlier which was predefined. but we don't need a assigned instance.
  // static final TLocalStorage _instance = TLocalStorage._internal();
  //  factory TLocalStorage() {
  //     return _instance;
  //   }

  // Therefore we will create an unassigned instance and use only factory method & utilize it for instance managing as below

  // Singleton instance
  static TLocalStorage? _instance;

  TLocalStorage._internal();

  factory TLocalStorage.instance() {
    _instance ??= TLocalStorage._internal();
    return _instance!;
  }

  // In order to assign the _storage we need to define a static function
  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = TLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}

/// *** *** *** *** *** Example *** *** *** *** *** ///

// LocalStorage localStorage = LocalStorage();
//
// //Save Data
// localStorage.saveData('username', 'JohnDoe');
//
// // Read Data
// String? username = localStorage.readData<String>('username');
// print('Username: $username'); // Output: Username: JohnDoe
//
// // Remove Data
// localStorage.removeData('username');
//
// // Clear all Data
// localStorage.clearAll();
