import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

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
  final Connectivity connectivity;

  NetworkInfoDataSourceImpl({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<void> ensureConnection() async {
    // final connected = await isConnected;
    // if (!connected) {
    //   throw NetworkException();
    // }
  }
}
