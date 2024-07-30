import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../generated/l10n.dart';
import '../../../core/local_storage/app_storage.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  static const routeName = '/';

  @override
  ConsumerState<DashboardView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashboardView'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).okGotIt),
            ElevatedButton(
              onPressed: () {},
              child: Text(S.of(context).okGotIt),
            ),
          ],
        ),
      ),
    );
  }
}
