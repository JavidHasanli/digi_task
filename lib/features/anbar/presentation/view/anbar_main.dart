import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/features/anbar/presentation/view/anbar_history.dart';
import 'package:digi_task/features/anbar/presentation/view/anbar_view.dart';
import 'package:digi_task/features/anbar/presentation/view/widgets/anbar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/path/icon_path.dart';

class AnbarMain extends StatefulWidget {
  const AnbarMain({super.key});

  @override
  State<AnbarMain> createState() => _AnbarMainState();
}

class _AnbarMainState extends State<AnbarMain> {
  int _selectedIndex = 0;

  final ValueNotifier<String> _appBarTitleNotifier =
      ValueNotifier<String>('Anbar');

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _appBarTitleNotifier.value = 'Anbar';
          break;
        case 1:
          _appBarTitleNotifier.value = 'Anbar Tarixçəsi';
          break;
      }
    });
  }

  @override
  void dispose() {
    _appBarTitleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg),
        ),
        title: ValueListenableBuilder<String>(
          valueListenable: _appBarTitleNotifier,
          builder: (context, title, child) {
            return Text(title, style: context.typography.subtitle2Medium);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AnbarDialog();
                },
              );
            },
            icon: SvgPicture.asset(IconPath.import.toPathSvg),
          ),
          const SizedBox(width: 14),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          AnbarView(),
          AnbarHistoryView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Anbar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Anbar Tarixçəsi',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
