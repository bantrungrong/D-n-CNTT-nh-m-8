import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../core/values/strings.dart';


class WidgetUser extends StatefulWidget {
  final String assetsname;
  final String cell;
  final String name;
  const WidgetUser(
      {super.key,
      required this.assetsname,
      required this.cell,
      required this.name});

  @override
  State<WidgetUser> createState() => _WidgetUserState();
}

class _WidgetUserState extends State<WidgetUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.only(left: 24),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(image: AssetImage(widget.assetsname))),
        ),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: AppStyle.medium(fontSize: 14)
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              widget.cell,
              style: AppStyle.regular(fontSize: 13),
            ),
          ],
        )
      ]),
    );
  }
}
