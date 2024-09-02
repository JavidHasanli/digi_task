import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/detail_problem.dart';
import 'package:flutter/material.dart';

class ServiceDialog extends StatelessWidget {
  final String serviceType;
  final int taskId;
  final TaskModel taskData;

  const ServiceDialog({
    super.key,
    required this.serviceType,
    required this.taskId,
    required this.taskData,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "Servis növü",
                    style: context.typography.subtitle1Medium,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Hansı anketi doldurursunuz?',
                  style: context.typography.body2Regular.copyWith(
                    color: context.colors.neutralColor50,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (taskData.isInternet == true &&
                        taskData.internet == null)
                      _buildServiceButton(
                        context,
                        'Internet',
                        taskId,
                      ),
                    if (taskData.isTv == true && taskData.tv == null)
                      _buildServiceButton(
                        context,
                        'Tv',
                        taskId,
                      ),
                    if (taskData.isVoice == true && taskData.voice == null)
                      _buildServiceButton(
                        context,
                        'Voice',
                        taskId,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildServiceButton(
      BuildContext context, String serviceType, int taskId) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            width: 4,
            color: Colors.yellow,
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateProblem(
              serviceType: serviceType,
              taskId: taskId,
            ),
          ),
        );
      },
      child: Text(
        serviceType,
        style: context.typography.body2SemiBold.copyWith(
          color: context.colors.primaryColor50,
        ),
      ),
    );
  }
}
