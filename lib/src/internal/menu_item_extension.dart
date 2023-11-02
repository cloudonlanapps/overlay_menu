import 'package:flutter/material.dart';

import 'custom_icon.dart';
import '../menu_item.dart';

extension MenuItemExtension on MenuItem {
  MenuItem copyWith({
    bool? showTitle,
    void Function()? onTap,
  }) {
    return MenuItem(
      label,
      iconData,
      showLabel: showTitle ?? showLabel,
      onTap: onTap ?? this.onTap,
    );
  }

  insertHook({
    Function()? pre,
    Function()? post,
  }) {
    if (onTap != null) {
      return copyWith(onTap: () {
        pre?.call();
        onTap?.call();
        post?.call();
      });
    }
    return this;
  }
}

class MenuButton extends StatelessWidget {
  final MenuItem menuItem;
  const MenuButton(
    this.menuItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color.fromARGB(128, 255, 0, 0),
      onTap: menuItem.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomIcon(
              menuItem.iconData,
              size: 20,
              color:
                  menuItem.onTap == null ? Colors.grey.shade300 : Colors.black,
            ),
            if (menuItem.showLabel)
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: Text(
                  menuItem.label,
                  style: TextStyle(
                      color: menuItem.onTap == null
                          ? Colors.grey.shade300
                          : Colors.black,
                      fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
