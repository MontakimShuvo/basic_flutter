import 'package:kiwi/kiwi.dart';
import '../data/services/database_service.dart';
import '../data/services/database_service_impl.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.singleton(DatabaseService, from: DatabaseServiceImpl)
  void configure();
}

void setupInjector() {
  final injector = _$Injector();
  injector.configure();
}

T resolve<T>() {
  return KiwiContainer().resolve<T>();
}
