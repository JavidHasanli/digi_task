import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../features/performance/data/model/performance_model.dart';

class PerformanceTable extends StatelessWidget {
  const PerformanceTable({
    super.key,
    required this.performance,
  });

  final List<PerformanceModel>? performance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.colors.primaryColor50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Ad',
                      style: context.typography.subtitle2SemiBold
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Qrup',
                        style: context.typography.subtitle2SemiBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Tasklar',
                        style: context.typography.subtitle2SemiBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: performance!.length,
              itemBuilder: (context, index) {
                final e = performance![index];
                return Column(
                  children: [
                    Divider(
                      color: context.colors.neutralColor90,
                      height: 0,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${e.firstName}",
                              maxLines: 1,
                              style:
                                  context.typography.subtitle2Regular.copyWith(
                                color: context.colors.primaryColor50,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                e.group?.group ?? '-',
                                style: context.typography.subtitle2Regular,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "${e.taskCount?.total}",
                                style: context.typography.subtitle2SemiBold
                                    .copyWith(
                                  color: context.colors.primaryColor50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
