import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_arcana/constants/app_colors.dart';

/// 날짜 입력을 위한 공통 텍스트 필드 컴포넌트
class DateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLength;
  final int flex;
  final Color? focusColor;
  final bool enabled;

  const DateInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.maxLength,
    this.flex = 1,
    this.focusColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color:
                  enabled
                      ? AppColors.grey
                      : AppColors.grey.withValues(alpha: .6),
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppColors.lightGrey, fontSize: 16.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.lightGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.lightGrey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppColors.lightGrey.withValues(alpha: .5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: focusColor ?? AppColors.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.error),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              counterText: '',
              filled: !enabled,
              fillColor: enabled ? null : Colors.grey.shade50,
            ),
            maxLength: maxLength,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: enabled ? AppColors.black : AppColors.grey,
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '필수 입력';
              }
              final intValue = int.tryParse(value);
              if (intValue == null) {
                return '숫자만 입력';
              }

              // 년도 검증
              if (label == '년도' && (intValue < 1900 || intValue > 2100)) {
                return '1900-2100';
              }
              // 월 검증
              if (label == '월' && (intValue < 1 || intValue > 12)) {
                return '1-12';
              }
              // 일 검증
              if (label == '일' && (intValue < 1 || intValue > 31)) {
                return '1-31';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
