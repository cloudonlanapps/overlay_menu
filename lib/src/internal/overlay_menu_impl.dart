import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'menu_animator.dart';
import 'menu_visibility.dart';

class OverlayMenuImplementation extends ConsumerStatefulWidget {
  const OverlayMenuImplementation({
    super.key,
    required this.mainWidget,
    this.topMenu,
    this.bottomMenu,
  });
  final Widget mainWidget;
  final Widget? topMenu;
  final Widget? bottomMenu;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      OverlayMenuImplementationState();
}

class OverlayMenuImplementationState
    extends ConsumerState<OverlayMenuImplementation>
    with SingleTickerProviderStateMixin {
  late final SystemUiOverlayStyle? originalOverlayStyle;
  late final AnimationController animationController;
  @override
  void initState() {
    // ignore: invalid_use_of_visible_for_testing_member
    originalOverlayStyle = SystemChrome.latestStyle;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Theme.of(context).colorScheme.surface, // Set the desired color here
      statusBarIconBrightness:
          Brightness.dark, // Control the color of the icons (light/dark)
    ));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(originalOverlayStyle ??
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Set the desired color here
          statusBarIconBrightness:
              Brightness.light, // Control the color of the icons (light/dark)
        ));
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.topMenu == null) && (widget.bottomMenu == null)) {
      throw Exception("Either topMenu or bottomMenu or both must be provided");
    }
    final bool isVisible = ref.watch(menuVisibilityProvider);
    if (!isVisible) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    return SafeArea(
      child: Listener(
        onPointerSignal: (PointerSignalEvent pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            // do something when scrolled

            if (pointerSignal.scrollDelta.dy < 0.0) {
              if (context.mounted) {
                ref.read(menuVisibilityProvider.notifier).holdMore();
              }
            } else {
              if (context.mounted) {
                ref.read(menuVisibilityProvider.notifier).hide();
              }
            }
          }
        },
        onPointerMove: (event) {
          if (event.delta.dy > 0) {
            if (context.mounted) {
              ref.read(menuVisibilityProvider.notifier).holdMore();
            }
          } else if (event.delta.dy < 0) {
            if (context.mounted) {
              ref.read(menuVisibilityProvider.notifier).hide();
            }
          }
        },
        onPointerPanZoomUpdate: (PointerPanZoomUpdateEvent event) {
          debugPrint('trackpad scrolled ${event.panDelta}');
          if (event.panDelta.dy > 0) {
            if (context.mounted) {
              ref.read(menuVisibilityProvider.notifier).holdMore();
            }
          } else if (event.panDelta.dy < 0) {
            if (context.mounted) {
              ref.read(menuVisibilityProvider.notifier).hide();
            }
          }
        },
        child: Stack(
          children: [
            widget.mainWidget,
            if (widget.topMenu != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: MenuAnimator(
                  animationController: animationController,
                  animateFrom: AnimateFrom.top,
                  child: widget.topMenu!,
                ),
                /* child: AnimatedOpacity(
                opacity: isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: widget.topMenuItems,
              ), */
              ),
            if (widget.bottomMenu != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: MenuAnimator(
                  animationController: animationController,
                  animateFrom: AnimateFrom.bottom,
                  child: widget.bottomMenu!,
                ),
                /* child: AnimatedOpacity(
                opacity: isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: widget.topMenuItems,
              ), */
              )
          ],
        ),
      ),
    );
  }
}
