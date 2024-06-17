
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Notes",
                style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  " app",
                  style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
                ),
              ),
            ],
          ),
          Text(
            " Safeguard Your Ideas with NotesApp",
            style: Theme.of(context)
              .textTheme
              .bodyMedium,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/about');
          },
          iconSize: 28.0,
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.info_outline),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(100);
}
