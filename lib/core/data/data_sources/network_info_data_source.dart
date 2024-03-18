import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:identidaddigital/core/error/exceptions.dart';

abstract class NetworkInfoDataSource {
  /// Check if there is a network connection available.
  Future<bool> get isConnected;

  /// Checks for a network connection.
  ///
  /// Throws a [NetworkException] if there is no connection.
  Future<void> ensureConnection();
}

@LazySingleton(as: NetworkInfoDataSource)
class NetworkInfoDataSourceImpl implements NetworkInfoDataSource {
  final DataConnectionChecker connectionChecker;

  NetworkInfoDataSourceImpl({@required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Future<void> ensureConnection() async {
    // final connected = await isConnected;
    // if (!connected) {
    //   throw NetworkException();
    // }
  }
}
