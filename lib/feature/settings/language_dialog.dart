import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'settings.dart';

void showLanguageDialog(BuildContext context) {
  showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          LanguageDialog(animation: animation));
}

class LanguageDialog extends StatefulWidget {
  final Animation<double> animation;

  const LanguageDialog({required this.animation, super.key});

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeOutCubic,
      ),
      child: SimpleDialog(
        title: const Text('Язык'),
        children: [
          TextField(
            controller: _controller,
            // autofocus: true,
            maxLength: 12,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              context.read<SettingsController>().setLanguage(value);
            },
            onSubmitted: (value) {
              // Player tapped 'Submit'/'Done' on their keyboard.
              Navigator.pop(context);
            },
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _controller.text = context.read<SettingsController>().language.value;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
