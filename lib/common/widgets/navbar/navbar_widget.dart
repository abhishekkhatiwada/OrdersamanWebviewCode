import 'package:flutter/material.dart';
import 'package:ordersaman/common/utils/size_config.dart';
import 'package:ordersaman/common/widgets/navbar/navbar_items.dart';

typedef NavbarItemBuilder =
    Widget Function(BuildContext context, int index, NavbarItem items);

class NavbarWidget extends StatefulWidget {
  final List<NavbarItem> items;
  final int currentIndex;
  final void Function(int val)? onTap;
  final Color selectedBackgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color backgroundColor;
  final double fontSize;
  final double iconSize;
  final double itemBorderRadius;
  final double borderRadius;
  final NavbarItemBuilder itemBuilder;
  final EdgeInsetsGeometry padding;
  final double width;
  final double elevation;
  final NavbarType navbarType;

  NavbarWidget({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    NavbarItemBuilder? itemBuilder,
    this.backgroundColor = Colors.black,
    this.selectedBackgroundColor = Colors.white,
    this.selectedItemColor = Colors.black,
    this.iconSize = 20.0,
    this.fontSize = 12.0,
    this.borderRadius = 10.0,
    this.itemBorderRadius = 10.0,
    this.unselectedItemColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0),
    this.width = double.infinity,
    this.elevation = 0.0,
    this.navbarType = NavbarType.fixed,
  }) : assert(items.length > 1),
       assert(items.length <= 5),
       assert(currentIndex <= items.length),
       assert(width > 50),
       itemBuilder =
           itemBuilder ??
           _defaultItemBuilder(
             unselectedItemColor: unselectedItemColor,
             selectedItemColor: selectedItemColor,
             borderRadius: borderRadius,
             fontSize: fontSize,
             width: width,
             backgroundColor: backgroundColor,
             currentIndex: currentIndex,
             iconSize: iconSize,
             itemBorderRadius: itemBorderRadius,
             items: items,
             onTap: onTap,
             selectedBackgroundColor: selectedBackgroundColor,
           );

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  List<NavbarItem> get items => widget.items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          widget.navbarType == NavbarType.fixed
              ? EdgeInsets.zero
              : EdgeInsets.only(right: 20.0, left: 20.0, bottom: 15.hp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        color:
            widget.navbarType == NavbarType.fixed
                ? widget.backgroundColor
                : Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: widget.backgroundColor,
            ),
            width: widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children:
                  items
                      .asMap()
                      .map(
                        (i, f) =>
                            MapEntry(i, widget.itemBuilder(context, i, f)),
                      )
                      .values
                      .toList(),
            ),
          ),
          SizedBox(height: 5.hp),
        ],
      ),
    );
  }
}

NavbarItemBuilder _defaultItemBuilder({
  Function(int val)? onTap,
  required List<NavbarItem> items,
  int? currentIndex,
  Color? selectedBackgroundColor,
  Color? selectedItemColor,
  Color? unselectedItemColor,
  Color? backgroundColor,
  double width = double.infinity,
  double? fontSize,
  double? iconSize,
  double? itemBorderRadius,
  double? borderRadius,
}) {
  return (BuildContext context, int index, NavbarItem item) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    double itemWidth =
        width.isFinite
            ? (width / items.length - 8)
            : MediaQuery.of(context).size.width / items.length - 24;
    if (itemWidth <= 0) {
      itemWidth = 50;
    }

    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              onTap!(index);
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: itemWidth,
              padding: EdgeInsets.symmetric(
                horizontal: 4,
                vertical: item.title != null ? 4 : 8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  item.customWidget == null
                      ? Image.asset(
                        item.icon.toString(),
                        color:
                            currentIndex == index
                                ? selectedItemColor
                                : unselectedItemColor,
                        height: iconSize,
                        width: iconSize,
                        fit: BoxFit.cover,
                      )
                      : item.customWidget!,
                  if (item.title != null)
                    Text(
                      '${item.title}',
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelMedium!.copyWith(
                        color:
                            currentIndex == index
                                ? selectedItemColor
                                : unselectedItemColor,
                        fontSize: fontSize,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  };
}
