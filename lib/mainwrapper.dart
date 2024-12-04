import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_flutter/bloc/drawer_bloc.dart';
import 'package:maps_flutter/widgets/drawer_widget.dart';
import 'package:maps_flutter/views/history_view.dart';
import 'package:maps_flutter/views/map_view.dart';
import 'package:maps_flutter/views/profile_view.dart';
import 'package:maps_flutter/views/support_view.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  late DrawerBloc _bloc;

  ///for each item in drawer content
  late Widget _content;

  @override
  void initState() {
    super.initState();
    _bloc = DrawerBloc();
    _content = _getContentFromState(_bloc.state.selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<DrawerBloc, DrawerState>(
        listener: (context, state) {
          _content = _getContentFromState(state.selectedItem);
        },
        buildWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },
        builder: (context, state) {
          return Scaffold(
            /// App bar
            appBar: _buildAppBar(state),

            drawer: const NavDrawerWidget(),

            body: AnimatedSwitcher(
                duration: const Duration(microseconds: 400),
                switchInCurve: Curves.easeInExpo,
                switchOutCurve: Curves.easeOutExpo,
                child: _content),
          );
        },
      ),
    );
  }

  ///main wrapper appbar
  AppBar _buildAppBar(DrawerState state) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        _getAppBarTitle(state.selectedItem),
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: false,
      backgroundColor: const Color.fromARGB(255, 112, 119, 249),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  String _getAppBarTitle(NavItems selectedItem) {
    switch (selectedItem) {
      case NavItems.mapView:
        return "Map";
      case NavItems.profileView:
        return "Profile";
      case NavItems.historyView:
        return "History";
      case NavItems.supportView:
        return "Support";
      default:
        return "Map";
    }
  }

  Widget _getContentFromState(NavItems selectedItem) {
    switch (selectedItem) {
      case NavItems.mapView:
        return const MapView();
      case NavItems.profileView:
        return const ProfileView();
      case NavItems.historyView:
        return const HistoryView();
      case NavItems.supportView:
        return const SupportView();
      default:
        return const MapView();
    }
  }
}
