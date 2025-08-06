import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_arcana/constants/app_colors.dart';
import 'package:lilac_arcana/models/tarot_card.dart';

/// 생애수와 그림자수 카드를 함께 보여주는 위젯
class TarotCardPairWidget extends StatelessWidget {
  final String title; // "선천수", "후천수", "직업수" 등
  final TarotCard? lifeCard; // 생애수 카드
  final TarotCard? shadowCard; // 그림자수 카드
  final void Function(TarotCard)? onLifeCardTap; // 생애수 카드 클릭
  final void Function(TarotCard)? onShadowCardTap; // 그림자수 카드 클릭

  const TarotCardPairWidget({
    super.key,
    required this.title,
    this.lifeCard,
    this.shadowCard,
    this.onLifeCardTap,
    this.onShadowCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 12.h),

          // 카드 2개를 가로로 배치
          Row(
            children: [
              // 생애수 카드
              Expanded(
                child: _buildCardContainer(
                  label: "생애수",
                  card: lifeCard,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  onTap:
                      lifeCard != null
                          ? () => onLifeCardTap?.call(lifeCard!)
                          : null,
                ),
              ),
              SizedBox(width: 12.w),

              // 그림자수 카드
              Expanded(
                child: _buildCardContainer(
                  label: "그림자수",
                  card: shadowCard,
                  backgroundColor: AppColors.secondary.withValues(alpha: 0.1),
                  onTap:
                      shadowCard != null
                          ? () => onShadowCardTap?.call(shadowCard!)
                          : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardContainer({
    required String label,
    required TarotCard? card,
    required Color backgroundColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140.h, // 고정 높이 설정
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.grey.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
          children: [
            // 라벨
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGrey,
              ),
            ),
            SizedBox(height: 8.h),

            if (card != null) ...[
              // 카드 번호
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${card.number}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // 카드 이름
              Text(
                card.name,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ] else ...[
              // 로딩 상태
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '계산 중...',
                style: TextStyle(fontSize: 12.sp, color: AppColors.darkGrey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
