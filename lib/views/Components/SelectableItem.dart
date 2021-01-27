import 'package:flutter/material.dart';
import 'package:fotopal_beta/models/foto.dart';
import 'package:fotopal_beta/models/foto_simp.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class SelectableItem extends StatefulWidget {
  const SelectableItem(
      {Key key,
      @required this.index,
      @required this.color,
      @required this.selected,
      @required this.foto})
      : super(key: key);

  final FotoSimp foto;
  final int index;
  final MaterialColor color;
  final bool selected;

  @override
  _SelectableItemState createState() => _SelectableItemState();
}

class _SelectableItemState extends State<SelectableItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      value: widget.selected ? 1 : 0,
      duration: kThemeChangeDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void didUpdateWidget(SelectableItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      if (widget.selected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(1),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: DecoratedBox(
              child: child,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: calculateColor(),
              ),
            ),
          ),
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.fill,
                placeholder: 'assets/images/spinner.gif',
                image: this.widget.foto.foto_thumb,
              ),
            ),
          ),
          Center(
              child: (this.widget.selected)
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Colors.white)),
                      child: Icon(
                        Icons.check_circle,
                        color: Color(0xfff97fe3),
                      ),
                    )
                  : SizedBox.shrink()),
          (!this.widget.selected)
              ? FlatButton(
                  height: double.infinity,
                  onPressed: () {
                    Get.to(PhotoView(
                        minScale: 0.25,
                        imageProvider:
                            NetworkImage(this.widget.foto.foto_thumb)));
                  },
                  child: null,
                  minWidth: double.infinity,
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }

  Color calculateColor() {
    return Color.lerp(
      Colors.transparent,
      Colors.white,
      _controller.value,
    );
  }
}
