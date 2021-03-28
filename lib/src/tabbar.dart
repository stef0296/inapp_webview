import 'package:flutter/material.dart';
import 'package:share/share.dart';

class Tabbar extends StatefulWidget {
  // final String? url;
  final List<Uri>? urls;
  final int? currentIndex;
  final Function? goBack;
  final Function? goForward;

  const Tabbar({
    // @required this.url,
    @required this.urls,
    @required this.currentIndex,
    @required this.goBack,
    @required this.goForward,
  });

  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  void _share() {
    Share.share(widget.urls![widget.currentIndex!].toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Color(0xFF212121),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap:
                  widget.currentIndex! < 1 ? null : () => widget.goBack!(null),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: widget.currentIndex! < 1 ? Colors.grey : Colors.white,
                size: 38,
              ),
            ),
          ),
          SizedBox(width: 24),
          SizedBox(
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: (widget.currentIndex == widget.urls!.length - 1)
                  ? null
                  : () => widget.goForward!(null),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: (widget.currentIndex == widget.urls!.length - 1)
                    ? Colors.grey
                    : Colors.white,
                size: 38,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: InkWell(
              onTap: _share,
              child: Icon(
                Icons.share,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          // SizedBox(
          //   width: 40,
          //   height: 40,
          //   child: Icon(
          //     Icons.more_horiz_outlined,
          //     color: Colors.white,
          //     size: 38,
          //   ),
          // ),
        ],
      ),
    );
  }
}
