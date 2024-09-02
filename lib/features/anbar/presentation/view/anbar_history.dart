import 'package:digi_task/features/anbar/presentation/view/pages/idxal_page.dart';
import 'package:digi_task/features/anbar/presentation/view/pages/ixrac_page.dart';
import 'package:flutter/material.dart';

class AnbarHistoryView extends StatelessWidget {
  const AnbarHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0.0,
          bottom: const TabBar(
            tabs: [
              Tab(text: "İxrac"),
              Tab(text: "İdxal"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            IxracPage(),
            IdxalPage(),
          ],
        ),
      ),
    );
  }
}

