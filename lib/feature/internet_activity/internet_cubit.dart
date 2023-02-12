import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetConnectionState {
  final bool connected;
  InternetConnectionState(this.connected);
}

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  late StreamSubscription<ConnectivityResult> _subscription;
  InternetConnectionCubit() : super(InternetConnectionState(false)) {
    _subscription = Connectivity().onConnectivityChanged.listen((event) {
      emit(InternetConnectionState(event != ConnectivityResult.none));
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
