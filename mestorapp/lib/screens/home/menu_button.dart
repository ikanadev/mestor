import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum MenuOption {
  settings,
  about,
}

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
      onSelected: (value) {
        switch (value) {
          case MenuOption.settings:
            context.push("/settings");
          case MenuOption.about:
          // TODO: todo page
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: MenuOption.settings,
            child: Text('Settings'),
          ),
          const PopupMenuItem(
            value: MenuOption.about,
            child: Text('About'),
          ),
        ];
      },
    );
  }
}
