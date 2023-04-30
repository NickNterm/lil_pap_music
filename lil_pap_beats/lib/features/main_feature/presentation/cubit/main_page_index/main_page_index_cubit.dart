import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class MainPageIndexCubit extends Cubit<int> {
  MainPageIndexCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }
}
