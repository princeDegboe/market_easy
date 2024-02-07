import 'package:e_com_app/const/colors.dart';
import 'package:flutter/material.dart';

class ModifInfo extends StatefulWidget {
  const ModifInfo({
    super.key,
    required this.label,
    required this.title,
  });
  final String label;
  final String title;
  @override
  State<ModifInfo> createState() => _ModifInfoState();
}

class _ModifInfoState extends State<ModifInfo> {
  late String text;
  @override
  void initState() {
    super.initState();
    currentTextEditingController.text = widget.label;
  }

  TextEditingController currentTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    currentTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.black,
                ),
            controller: currentTextEditingController,
          ),
        ],
      ),
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Colors.black,
            ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Quitter",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            
          },
          child: Text(
            "Valider",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: myOrange,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
