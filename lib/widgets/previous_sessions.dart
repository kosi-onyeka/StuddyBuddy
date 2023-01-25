import 'package:flutter/material.dart';
import 'package:studdy_bestie/utils/colors.dart';
import 'package:studdy_bestie/utils/dimensions.dart';

class PreviousSessions extends StatelessWidget {
  final String sessionName;
  const PreviousSessions({super.key, required this.sessionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColorPalette,
        borderRadius: BorderRadius.circular(10),
      ),
      height: rowObjectSize,
      width: rowObjectSize,
      child: Center(child: Text(sessionName)),
    );
  }
}
