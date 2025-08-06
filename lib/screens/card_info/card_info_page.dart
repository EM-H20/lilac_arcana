import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lilac_arcana/constants/app_colors.dart';
import 'package:lilac_arcana/constants/tarot_data.dart';

class CardInfoPage extends StatelessWidget {
  const CardInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          '타로카드 정보',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withValues(alpha: 0.05),
              AppColors.lightGrey,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 헤더 섹션
              _buildHeader(context),

              // 카드 리스트
              _buildCardList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.15),
            AppColors.primaryLight.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // 아이콘
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.auto_stories,
              size: 32.sp,
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(height: 16.h),

          // 타이틀
          Text(
            '메이저 아르카나',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(height: 8.h),

          // 서브 타이틀
          Text(
            '22장의 신비로운 카드들을 탐험해보세요',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.grey,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),

          // 통계 정보
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('카드 수', '22장', Icons.style),
                Container(
                  width: 1,
                  height: 30.h,
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
                _buildStatItem('카테고리', '메이저', Icons.category),
                Container(
                  width: 1,
                  height: 30.h,
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
                _buildStatItem('범위', '0-21', Icons.numbers),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.primary),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 10.sp, color: AppColors.grey)),
      ],
    );
  }

  Widget _buildCardList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      itemCount: majorArcanaCards.length,
      itemBuilder: (context, index) {
        final card = majorArcanaCards[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          child: _buildCardItem(card, index),
        );
      },
    );
  }

  Widget _buildCardItem(card, int index) {
    return Builder(
      builder:
          (context) => InkWell(
            onTap: () => context.push('/card-info/${card.number}'),
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    AppColors.primaryLight.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // 카드 번호 배지
                  Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${card.number}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),

                  // 카드 정보
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          card.keyword,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          card.interpretation,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // 화살표 아이콘
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
