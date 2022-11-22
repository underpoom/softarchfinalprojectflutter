import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:softarchfinal/widgets/icbutton.dart';

class TagsField extends StatefulWidget {
  final void Function()? onPressed;
  final String tags;
  const TagsField({Key? key, required this.tags, this.onPressed})
      : super(key: key);

  @override
  State<TagsField> createState() => _TagsFieldState();
}

class _TagsFieldState extends State<TagsField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black),
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.tags,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                )),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 6),
                  child: GestureDetector(
                    onTap: widget.onPressed,
                    child: FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
