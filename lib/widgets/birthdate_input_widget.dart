import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_arcana/constants/app_colors.dart';
import 'package:lilac_arcana/widgets/common/date_input_section.dart';

/// 생년월일 입력을 위한 공용 위젯
class BirthdateInputWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  // 양력 컨트롤러
  final TextEditingController yearController;
  final TextEditingController monthController;
  final TextEditingController dayController;
  // 음력 컨트롤러
  final TextEditingController lunarYearController;
  final TextEditingController lunarMonthController;
  final TextEditingController lunarDayController;
  final VoidCallback onCalculate;
  final bool isLoading;

  const BirthdateInputWidget({
    super.key,
    required this.formKey,
    required this.yearController,
    required this.monthController,
    required this.dayController,
    required this.lunarYearController,
    required this.lunarMonthController,
    required this.lunarDayController,
    required this.onCalculate,
    this.isLoading = false,
  });

  @override
  State<BirthdateInputWidget> createState() => _BirthdateInputWidgetState();
}

class _BirthdateInputWidgetState extends State<BirthdateInputWidget> {
  // 더 이상 내부 컨트롤러가 필요 없음 - HomePage에서 직접 전달받음

  @override
  void initState() {
    super.initState();
    // 더 이상 내부 컨트롤러 초기화 불필요
  }

  @override
  void dispose() {
    // 더 이상 내부 컨트롤러 dispose 불필요
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 헤더 섹션
              _buildHeader(),
              SizedBox(height: 40.h),

              // 입력 필드 섹션
              _buildInputFields(),
              SizedBox(height: 24.h),

              // 계산 버튼
              _buildCalculateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text('🔮', style: TextStyle(fontSize: 48.sp)),
        SizedBox(height: 16.h),
        Text(
          '타로 생년월일 입력',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          '생년월일을 입력하여 당신만의 타로카드를 찾아보세요',
          style: TextStyle(fontSize: 16.sp, color: AppColors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        // 설명 텍스트
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primary, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '음력과 양력 생년월일을 모두 입력해주세요. 음력을 먼저 입력해주세요.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // 음력 입력 섹션 (우선 입력)
        DateInputSection(
          title: '음력 (필수)',
          yearController: widget.lunarYearController,
          monthController: widget.lunarMonthController,
          dayController: widget.lunarDayController,
          color: AppColors.primary,
          enabled: true,
        ),
        SizedBox(height: 24.h),

        // 양력 입력 섹션
        DateInputSection(
          title: '양력 (필수)',
          yearController: widget.yearController,
          monthController: widget.monthController,
          dayController: widget.dayController,
          color: AppColors.accent,
          enabled: true,
        ),
      ],
    );
  }

  Widget _buildCalculateButton() {
    // 양력과 음력 모두 입력되었는지 확인
    final bool solarComplete =
        widget.yearController.text.isNotEmpty &&
        widget.monthController.text.isNotEmpty &&
        widget.dayController.text.isNotEmpty;

    final bool lunarComplete =
        widget.lunarYearController.text.isNotEmpty &&
        widget.lunarMonthController.text.isNotEmpty &&
        widget.lunarDayController.text.isNotEmpty;

    final bool canCalculate =
        solarComplete && lunarComplete && !widget.isLoading;

    return ElevatedButton(
      onPressed: canCalculate ? widget.onCalculate : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 4,
        shadowColor: AppColors.primary.withValues(alpha: .3),
      ),
      child:
          widget.isLoading
              ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
              : Text(
                canCalculate ? '타로카드 계산하기' : '양력과 음력을 모두 입력하세요',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
    );
  }
}
