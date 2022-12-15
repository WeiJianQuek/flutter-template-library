import 'package:flutter/material.dart';

enum TextButtonStyle {
  none,
  elevated,
  outlined,
}

class TextButtonComponent extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double minimumWidth;
  final double minimumHeight;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final OutlinedBorder? shape;
  final VoidCallback onPressed;
  final TextButtonStyle style;

  Widget get _infoWidget {
    final itemList = <Widget> [];
    if (prefixIcon is Widget) {
      itemList.add(prefixIcon ?? const SizedBox());
      itemList.add(const SizedBox(
        width: 8,
      ));
    }
    if (title?.isNotEmpty ?? false) {
      itemList.add(Text(title ?? ''));
    }

    if (suffixIcon is Widget) {
      itemList.add(const SizedBox(
        width: 8,
      ));
      itemList.add(suffixIcon ?? const SizedBox());
    }

    if (itemList.length == 1) {
      return itemList.first;
    } else if (itemList.length > 1) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: itemList,
      );
    } else {
      return const SizedBox();
    }
  }

  const TextButtonComponent({
    Key? key,
    required this.title,
    this.titleStyle,
    required this.onPressed,
    this.minimumHeight = 40,
    this.minimumWidth = 0,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.margin = const EdgeInsets.all(4),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(6),
      ),
    ),
    this.foregroundColor,
    this.backgroundColor,
    this.style = TextButtonStyle.none,
  }) : super(key: key);

  const TextButtonComponent.action({
    Key? key,
    required this.title,
    this.titleStyle,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.margin = const EdgeInsets.all(4),
    this.foregroundColor,
    this.backgroundColor,
    this.style = TextButtonStyle.none,
  }) :  minimumHeight = 40,
        minimumWidth = 0,
        shape = const StadiumBorder(),
        padding =  const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        super(key: key);

  const TextButtonComponent.submit({
    Key? key,
    required this.title,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.margin = const EdgeInsets.all(4),
    this.foregroundColor,
    this.backgroundColor,
    this.style = TextButtonStyle.none,
  }) :  minimumHeight = 50,
        minimumWidth = 100,
        titleStyle = const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        padding =  const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (margin == null) return _setupButtonComponent(context);

    return Padding(
      padding: margin ?? const EdgeInsets.all(0),
      child: _setupButtonComponent(context),
    );
  }

  Widget _setupButtonComponent(final BuildContext context) {
    switch(style) {
      case TextButtonStyle.none:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            minimumSize: Size(minimumWidth, minimumHeight),
            textStyle: titleStyle,
            padding: padding,
            shape: shape,
          ),
          child: _infoWidget,
        );
      case TextButtonStyle.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
            backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
            minimumSize: Size(minimumWidth, minimumHeight),
            textStyle: titleStyle,
            padding: padding,
            shape: shape,
          ),
          child: _infoWidget,
        );
      case TextButtonStyle.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.primary,
            backgroundColor: backgroundColor,
            minimumSize: Size(minimumWidth, minimumHeight),
            textStyle: titleStyle,
            padding: padding,
            shape: shape,
            side: BorderSide(
              color: foregroundColor ?? Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
          child: _infoWidget,
        );
    }
  }
}
