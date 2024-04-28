import 'package:flutter/material.dart';

class ItemPublic extends StatefulWidget {
  final Map<String, dynamic> publicFData;
  ItemPublic({Key? key, required this.publicFData}) : super(key: key);

  @override
  State<ItemPublic> createState() => _ItemPublicState();
}

class _ItemPublicState extends State<ItemPublic> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: CircleAvatar(
            child: Text("${widget.publicFData["username"].toString()[0]}"),
          ),
          title: Text("${widget.publicFData["title"]}"),
          subtitle: Text("${widget.publicFData["publishedAt"].toDate()}"),
          trailing: Wrap(
            children: [
              IconButton(
                icon: Icon(Icons.star_outlined, color: Colors.green),
                tooltip: "Likes: ${widget.publicFData["stars"]}",
                onPressed: () {},
              ),
              IconButton(
                tooltip: "Compartir",
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
