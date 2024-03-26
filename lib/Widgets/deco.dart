import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;

  const CustomAppBar({Key? key, required this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColorLight,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onLogout,
            icon: Icon(Icons.exit_to_app,
                color: Theme.of(context).primaryColorDark, size: 30),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}
