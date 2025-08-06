import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_arcana/constants/app_colors.dart';
import 'package:lilac_arcana/widgets/common/date_input_field.dart';

/// 날짜 입력 섹션 컴포넌트 (년/월/일 필드 그룹)
class DateInputSection extends StatelessWidget {
  final String title;
  final TextEditingController yearController;
  final TextEditingController monthController;
  final TextEditingController dayController;
  final Color color;
  final bool enabled;
  final String? subtitle;

  const DateInputSection({
    super.key,
    required this.title,
    required this.yearController,
    required this.monthController,
    required this.dayController,
    required this.color,
    this.enabled = true,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: enabled ? color : Colors.grey.shade300,
          width: enabled ? 2 : 1,
        ),
        boxShadow:
            enabled
                ? [
                  BoxShadow(
                    color: color.withValues(alpha: .1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
                : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목 및 상태 표시
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: enabled ? color : AppColors.grey,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 16.h),

          // 날짜 입력 필드들
          Row(
            children: [
              DateInputField(
                controller: yearController,
                label: '년도',
                hint: 'YYYY',
                maxLength: 4,
                flex: 2,
                focusColor: color,
                enabled: enabled,
              ),
              SizedBox(width: 12.w),
              DateInputField(
                controller: monthController,
                label: '월',
                hint: 'MM',
                maxLength: 2,
                focusColor: color,
                enabled: enabled,
              ),
              SizedBox(width: 12.w),
              DateInputField(
                controller: dayController,
                label: '일',
                hint: 'DD',
                maxLength: 2,
                focusColor: color,
                enabled: enabled,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
