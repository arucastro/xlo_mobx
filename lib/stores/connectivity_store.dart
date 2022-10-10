import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStore with _$ConnectivityStore;

abstract class _ConnectivityStore with Store {
  _ConnectivityStore() {
    _setupListener();
  }

  void _setupListener() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      setConnected(event == InternetConnectionStatus.connected);
    });
  }

  @observable
  bool connected = true;

  @action
  void setConnected(bool value) => connected = value;
}
