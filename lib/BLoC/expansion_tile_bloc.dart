import 'package:flutter_bloc/flutter_bloc.dart';

enum ExpansionTileEvent { toggle }

class ExpansionTileBloc extends Bloc<ExpansionTileEvent, bool> {
  ExpansionTileBloc() : super(false);

  @override
  Stream<bool> mapEventToState(ExpansionTileEvent event) async* {
    switch (event) {
      case ExpansionTileEvent.toggle:
        yield !state;
        break;
    }
  }
}
