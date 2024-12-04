part of 'drawer_bloc.dart';

enum NavItems { mapView, profileView, historyView, supportView }

class DrawerState extends Equatable {
  final NavItems selectedItem;
  const DrawerState({required this.selectedItem});

  @override
  List<Object> get props => [selectedItem];
}
