import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:maps_flutter/bloc/drawer_bloc.dart';

class _NavigationItem {
  final NavItems item;
  final String title;
  final IconData icon;

  _NavigationItem(this.item, this.title, this.icon);
}

class NavDrawerWidget extends StatefulWidget {
  const NavDrawerWidget({super.key});

  @override
  State<NavDrawerWidget> createState() => _NavDrawerWidgetState();
}

class _NavDrawerWidgetState extends State<NavDrawerWidget> {
  /// Drawer Items
  final List<_NavigationItem> _drawerItems = [
    ///Maps home
    _NavigationItem(NavItems.mapView, "Map", IconlyBold.home),

    ///Profile
    _NavigationItem(NavItems.profileView, "Profile", IconlyBold.profile),

    ///History
    _NavigationItem(NavItems.historyView, "History", IconlyBold.time_circle),

    ///Support
    _NavigationItem(NavItems.supportView, "Support", IconlyBold.shield_done),
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        ///Header
        const UserAccountsDrawerHeader(
          accountName: Text(
            "User",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          accountEmail: Text(
            'User@email.com',
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://wallpapers.com/images/hd/profile-picture-background-xyyvpmbyouhknwrk.jpg"))),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://murrayglass.com/wp-content/uploads/2020/10/avatar-2048x2048.jpeg"),
          ),
        ),

        /// Items
        ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _drawerItems.length,
            shrinkWrap: true,
            itemBuilder: (ctx, i) {
              return BlocBuilder<DrawerBloc, DrawerState>(
                  buildWhen: (prev, curr) {
                    return prev.selectedItem != curr.selectedItem;
                  },
                  builder: (context, state) =>
                      _buildItem(_drawerItems[i], state));
            })
      ],
    ));
  }

  Widget _buildItem(_NavigationItem data, DrawerState state) =>
      _makeListItem(data, state);

  Widget _makeListItem(_NavigationItem data, DrawerState state) {
    return Card(
      color: Colors.grey[100],
      shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      borderOnForeground: true,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: ListTile(
        title: Text(
          data.title,
          style: TextStyle(
              fontWeight: data.item == state.selectedItem
                  ? FontWeight.bold
                  : FontWeight.w300,
              color: data.item == state.selectedItem
                  ? const Color.fromARGB(255, 112, 119, 249)
                  : Colors.grey[600]),
        ),
        leading: Icon(data.icon,
            color: data.item == state.selectedItem
                ? const Color.fromARGB(255, 112, 119, 249)
                : Colors.grey[600]),
        onTap: () => _handleItemClicked(context, data.item),
      ),
    );
  }

  void _handleItemClicked(BuildContext context, NavItems item) {
    BlocProvider.of<DrawerBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }
}
