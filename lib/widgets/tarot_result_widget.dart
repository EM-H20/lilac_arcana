import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_arcana/constants/app_colors.dart';
import 'package:lilac_arcana/models/tarot_card.dart';
import 'package:lilac_arcana/widgets/tarot_card_widget.dart';

/// 타로카드 계산 결과를 표시하는 공용 위젯
class TarotResultWidget extends StatelessWidget {
  final TarotCard? innateLifeCard;
  final TarotCard? acquiredLifeCard;
  final TarotCard? vocationCard;
  final TarotCard? shadowCard;
  final VoidCallback onRecalculate;
  final Function(TarotCard)? onCardTap;

  const TarotResultWidget({
    super.key,
    this.innateLifeCard,
    this.acquiredLifeCard,
    this.vocationCard,
    this.shadowCard,
    required this.onRecalculate,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 헤더 섹션
          _buildHeader(),
          SizedBox(height: 32.h),

          // 카드 결과 섹션
          _buildCardResults(),
          SizedBox(height: 32.h),

          // 액션 버튼들
          _buildActionButtons(),
          SizedBox(height: 16.h),

          // 안내 텍스트
          _buildGuideText(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: .1),
            AppColors.primaryLight.withValues(alpha: .05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: .2)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.auto_awesome, size: 32.sp, color: Colors.white),
          ),
          SizedBox(height: 16.h),
          Text(
            '당신의 타로카드',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            '생년월일을 바탕으로 계산된\n당신만의 특별한 카드들입니다',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.grey,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCardResults() {
    final cardData = [
      {
        'title': '생애수 (선천)',
        'card': innateLifeCard,
        'description': '태어날 때부터 가진 본질적 성향',
        'icon': Icons.brightness_high,
      },
      {
        'title': '생애수 (후천)',
        'card': acquiredLifeCard,
        'description': '후천적으로 발달시킬 수 있는 능력',
        'icon': Icons.trending_up,
      },
      {
        'title': '직업수',
        'card': vocationCard,
        'description': '직업과 사회적 역할에서의 특성',
        'icon': Icons.work,
      },
      {
        'title': '그림자카드',
        'card': shadowCard,
        'description': '숨겨진 잠재력과 극복해야 할 과제',
        'icon': Icons.psychology,
      },
    ];

    return Column(
      children:
          cardData.map((data) {
            final card = data['card'] as TarotCard?;
            if (card == null) return const SizedBox.shrink();

            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 카테고리 헤더
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withValues(alpha: .2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          data['icon'] as IconData,
                          size: 16.sp,
                          color: AppColors.primaryDark,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          data['description'] as String,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // 타로카드 위젯
                  TarotCardWidget(
                    title: data['title'] as String,
                    card: card,
                    onTap: onCardTap != null ? () => onCardTap!(card) : null,
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // 다시 계산하기 버튼
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onRecalculate,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 4,
              shadowColor: AppColors.primary.withValues(alpha: .3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.refresh, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  '다시 계산하기',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // 카드 정보 더보기 버튼
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              // TODO: 카드 정보 페이지로 이동
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  '타로카드 해석 보기',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuideText() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.accent.withValues(alpha: .3)),
      ),
      child: Column(
        children: [
          Icon(Icons.lightbulb_outline, size: 20.sp, color: AppColors.accent),
          SizedBox(height: 8.h),
          Text(
            '각 카드를 탭하면 더 자세한 해석을 볼 수 있습니다.\n타로카드는 자기 이해와 성찰의 도구로 활용해보세요.',
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.grey,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
