import 'package:pain_tracker/BlocProvider.dart';
import 'package:pain_tracker/Database.dart';
import 'package:pain_tracker/PainModel.dart';
import 'package:rxdart/rxdart.dart';

class PainBloc implements BlocBase {
  PainBloc() {
    getClients();
  }
  BehaviorSubject<List<Pain>> _painController = BehaviorSubject<List<Pain>>();
  Stream<List<Pain>> get pains => _painController.stream;

  dispose() {
    _painController.close();
  }

  newPain(Pain newPain) {
    DBProvider.db.newPain(newPain);
    getClients();
  }

  removeLastPain() {
    DBProvider.db.removeLastPain();
    getClients();
  }

  getClients() async {
    _painController.sink.add(await DBProvider.db.getAllPains());
  }
}
