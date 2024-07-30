import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../generated/l10n.dart';
import '../../../core/local_storage/app_storage.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  static const routeName = '/main';

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: S.of(context).okGotIt,
            ),
          ),
          ElevatedButton(
            child: Text(S.of(context).okGotIt),
            onPressed: () {
              ref
                  .read(appStorageProvider)
                  .putString('hi', _textEditingController.text)
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Saved'),
                  ),
                );
              });
            },
          ),
          ElevatedButton(
            child: const Text('Read'),
            onPressed: () {
              ref
                  .read(appStorageProvider)
                  .getString(
                    'hi',
                  )
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Read: $value'),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
