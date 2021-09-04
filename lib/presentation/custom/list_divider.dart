import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: const EdgeInsets.only(top: 12, bottom: 16),
      height: 1,
      decoration: const BoxDecoration(color: Color(0x21000000)),
    ));
  }
}
