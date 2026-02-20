import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _connectionChecker;

  NetworkInfoImpl(this._connectionChecker);

  @override
  Future<bool> get isConnected => _connectionChecker.hasConnection;
}

@module
abstract class ExternalModule {
  @lazySingleton
  InternetConnectionChecker get connectionChecker => InternetConnectionChecker.createInstance();
}
