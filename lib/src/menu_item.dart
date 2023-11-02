class MenuItem {
  /// label to the main item
  final String label;

  /// should the label be shown below the icon ?
  final bool showLabel;

  /// IconData - Preferrably IconData Class.
  /// TODO: [colanapps] add support for SVG / PNG Icons
  final dynamic iconData;

  /// Action when the item is tapped. If null, the item will be shown
  /// but disabled.
  final void Function()? onTap;

  MenuItem(this.label, this.iconData, {this.onTap, this.showLabel = true});
}
