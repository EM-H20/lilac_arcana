import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lilac_arcana/constants/app_colors.dart';
import 'package:lilac_arcana/constants/tarot_data.dart';
import 'package:lilac_arcana/models/tarot_card.dart';
import 'dart:math' as math;

class CardDetailPage extends StatefulWidget {
  final int cardId;
  const CardDetailPage({super.key, required this.cardId});

  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (!_isFlipped) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 카드 ID에 해당하는 카드 찾기
    final card = majorArcanaCards.firstWhere(
      (card) => card.number == widget.cardId,
      orElse: () => majorArcanaCards[0], // 기본값으로 바보 카드
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(context, card),

            // 카드 이미지와 상세 정보
            Expanded(child: _buildFlippableCard(card)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TarotCard card) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: .15),
            AppColors.primaryLight.withValues(alpha: .08),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primaryDark,
                  size: 24.sp,
                ),
              ),
              Expanded(
                child: Text(
                  card.name,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 48.w),
            ],
          ),
          SizedBox(height: 16.h),

          // 카드 번호와 키워드
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '카드 ${card.number}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlippableCard(TarotCard card) {
    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) {
        final isShowingFront = _flipAnimation.value < 0.5;
        return Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_flipAnimation.value * math.pi),
          child:
              isShowingFront
                  ? _buildCardFront(card)
                  : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(math.pi),
                    child: _buildCardBack(card),
                  ),
        );
      },
    );
  }

  Widget _buildCardFront(TarotCard card) {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // 카드 이미지
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: _flipCard,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    card.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.lightGrey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 60.sp,
                              color: AppColors.grey,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '이미지를 불러올 수 없습니다',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // 클릭 안내
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.touch_app, color: AppColors.primary, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  '카드를 터치하여 해석을 확인하세요',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack(TarotCard card) {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 뒤로 돌리기 버튼
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _flipCard,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.flip_to_front,
                    color: AppColors.primary,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // 정방향 해석
            _buildInterpretationSection(
              '정방향 해석',
              card.interpretation,
              Icons.trending_up,
              AppColors.success,
            ),
            SizedBox(height: 24.h),

            // 역방향 해석
            _buildInterpretationSection(
              '역방향 해석',
              card.reversedInterpretation,
              Icons.trending_down,
              AppColors.error,
            ),
            SizedBox(height: 32.h),

            // 추가 정보 카드
            _buildAdditionalInfo(card),
          ],
        ),
      ),
    );
  }

  Widget _buildInterpretationSection(
    String title,
    String content,
    IconData icon,
    Color accentColor,
  ) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: accentColor.withValues(alpha: .2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: .1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, size: 20.sp, color: accentColor),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 16.sp,
              height: 1.6,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo(TarotCard card) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accent.withValues(alpha: .1),
            AppColors.accent.withValues(alpha: .05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.accent.withValues(alpha: .3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 20.sp, color: AppColors.accent),
              SizedBox(width: 8.w),
              Text(
                '타로 가이드',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            '타로카드는 자기 이해와 성찰의 도구입니다. \n'
            '카드의 의미를 참고하여 현재 상황을 되돌아보고, \n'
            '앞으로의 방향을 찾는 데 활용해보세요.',
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
