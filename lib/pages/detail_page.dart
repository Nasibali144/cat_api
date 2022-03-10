import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  static const String id = "/detail_page";
  String? url;
  String? imageId;

  DetailPage({this.url, this.imageId, Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.imageId!,
      child: InteractiveViewer(
        child: CachedNetworkImage(
          imageUrl: widget.url!,
          placeholder: (context, text) => Container(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
