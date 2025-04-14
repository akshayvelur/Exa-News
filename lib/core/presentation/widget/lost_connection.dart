
import 'package:flutter/material.dart';

class LostConnection extends StatelessWidget {
  const LostConnection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
      children: [Icon(Icons.wifi_off,color: Colors.red,size: 50,)
      ,Text("You are not connected to internet.")],),);
  }
}
