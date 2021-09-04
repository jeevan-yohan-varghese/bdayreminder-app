part of 'bottom_nav_cubit.dart';

class BottomNavState extends Equatable {
  int selectedIndex;
  BottomNavState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
