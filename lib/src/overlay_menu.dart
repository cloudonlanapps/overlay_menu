import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'menu_item.dart';
import 'internal/internals.dart';

class OverlayMenu extends ConsumerWidget {
  const OverlayMenu({
    super.key,

    /// widget on which the overlay menu is shown.
    required this.child,

    /// Menu items in the top menu
    this.topMenuItems,

    /// Menu items in the bottom menu
    this.bottomMenuItems,

    /// a Special Menu item  in the top left corner.
    /// May be used for back navigation / open side bar
    this.topMenuItemSpecialLeft,

    /// a Special Menu item  in the top left corner.
    /// May be used for back navigation / open side bar
    this.bottomMenuItemSpecialLeft,

    /// A Menu item without action to insert a action to hide menu to be added.
    this.hideMenuItem,

    /// Boolean, to insert the 'hide menu' action into top or bottom menu
    this.hideMenuOnTop = true,

    /// time out for auto-hide,
    /// after this time, the menu disappears if no action
    this.timeout = const Duration(seconds: 3),
  });
  final Widget child;
  final List<CLMenuItem>? topMenuItems;
  final CLMenuItem? topMenuItemSpecialLeft;
  final List<CLMenuItem>? bottomMenuItems;
  final CLMenuItem? bottomMenuItemSpecialLeft;
  final CLMenuItem? hideMenuItem;
  final bool hideMenuOnTop;
  final Duration timeout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget? topMenu, bottomMenu;
    final hasTopMenu = topMenuItems != null ||
        topMenuItemSpecialLeft != null ||
        (hideMenuOnTop && hideMenuItem != null);
    final hasBottomMenu = bottomMenuItems != null ||
        bottomMenuItemSpecialLeft != null ||
        (!hideMenuOnTop && hideMenuItem != null);
    if (hasTopMenu) {
      topMenu = MenuView(
        menuItemSpecialLeft: topMenuItemSpecialLeft,
        menuItems: topMenuItems,
        hideMenuItem: hideMenuOnTop ? hideMenuItem : null,
      );
    }
    if (hasBottomMenu) {
      bottomMenu = MenuView(
        menuItemSpecialLeft: bottomMenuItemSpecialLeft,
        menuItems: bottomMenuItems,
        hideMenuItem: (!hideMenuOnTop) ? hideMenuItem : null,
      );
    }

    return ProviderScope(
      overrides: [
        menuVisibilityProvider.overrideWith((ref) {
          ref.onDispose(() {});

          return MenuVisibiltiyNotifier(isVisible: true, duration: timeout);
        }),
      ],
      child: OverlayMenuImplementation(
        mainWidget: child,
        topMenu: topMenu,
        bottomMenu: bottomMenu,
      ),
    );
  }
}
