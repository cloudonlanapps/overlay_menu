import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../menu_item.dart';
import 'menu_item_extension.dart';
import 'menu_visibility.dart';

class MenuView extends ConsumerWidget {
  const MenuView({
    super.key,
    this.menuItems,
    this.menuItemSpecialLeft,
    this.mainAxisAlignment,
    this.hideMenuItem,
  });

  final List<CLMenuItem>? menuItems;
  final CLMenuItem? menuItemSpecialLeft;
  final MainAxisAlignment? mainAxisAlignment;
  final CLMenuItem? hideMenuItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if ((menuItems == null) && (menuItemSpecialLeft == null)) {
      throw Exception(
          "Either menuItems or onExitMenuItem or both must be provided");
    }
    if (hideMenuItem != null && hideMenuItem!.onTap != null) {
      throw Exception("You can't provide action for closeMenuItem");
    }
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          if (menuItemSpecialLeft != null) ...[
            Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: CLMenuButton(menuItemSpecialLeft?.insertHook(
                      pre: ref.read(menuVisibilityProvider.notifier).hide))),
            ),
            const VerticalDivider(),
          ],
          if (hideMenuItem != null || (menuItems != null))
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: mainAxisAlignment ??
                    ((menuItemSpecialLeft == null)
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.end),
                children: [
                  if (menuItems != null)
                    ...menuItems!
                        .map((e) => CLMenuButton(e.insertHook(pre: () {
                              ref
                                  .read(menuVisibilityProvider.notifier)
                                  .holdMore();
                            })))
                        .toList(),
                  if (hideMenuItem != null)
                    CLMenuButton(hideMenuItem!.copyWith(onTap: () {
                      ref.read(menuVisibilityProvider.notifier).hide();
                    }))
                ],
              ),
            ),
        ]),
      ),
    );
  }
}
