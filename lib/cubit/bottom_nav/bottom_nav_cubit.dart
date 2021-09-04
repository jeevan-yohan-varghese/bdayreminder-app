import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavState(selectedIndex: 0));

  void setSelectedIndex(int index) =>
      emit(BottomNavState(selectedIndex: index));
}
