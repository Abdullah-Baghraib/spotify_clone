import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityService {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  
  final ValueNotifier<bool> isConnected = ValueNotifier<bool>(true);
  
  ConnectivityService(this._connectivity) {
    _initConnectivity();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  
  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      isConnected.value = false;
    }
  }
  
  void _updateConnectionStatus(List<ConnectivityResult> result) {
    // If there's any connection other than none, consider it as connected
    isConnected.value = result.isNotEmpty && !result.every((element) => element == ConnectivityResult.none);
  }
  
  void dispose() {
    _subscription.cancel();
  }
} 