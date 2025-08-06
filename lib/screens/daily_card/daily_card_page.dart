import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lilac_arcana/constants/app_colors.dart';
import 'package:lilac_arcana/constants/tarot_data.dart';
import 'package:lilac_arcana/models/tarot_card.dart';

class DailyCardPage extends StatefulWidget {
  const DailyCardPage({super.key});

  @override
  State<DailyCardPage> createState() => _DailyCardPageState();
}

class _DailyCardPageState extends State<DailyCardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  TarotCard? _todayCard;
  bool _isRevealed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _generateTodayCard();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateTodayCard({bool isReroll = false}) {
    int cardNumber;

    if (isReroll) {
      // 다시 뽑기일 경우, 랜덤으로 카드 선택
      cardNumber = Random().nextInt(majorArcanaCards.length);
    } else {
      // 첫 로드 시, 오늘 날짜를 기반으로 시드 생성
      final now = DateTime.now();
      final seed = now.year * 10000 + now.month * 100 + now.day;
      cardNumber = seed % majorArcanaCards.length;
    }

    _todayCard = majorArcanaCards.firstWhere(
      (card) => card.number == cardNumber,
      orElse: () => majorArcanaCards.first, // 혹시 모를 경우 대비
    );
  }

  void _revealCard() {
    setState(() {
      _isRevealed = true;
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          '오늘의 카드',
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
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              // 간단한 안내 메시지
              if (!_isRevealed)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  margin: EdgeInsets.only(bottom: 40.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.touch_app,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '카드를 터치하여 오늘의 운세를 확인하세요',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),

              // 카드 영역
              GestureDetector(
                onTap: _isRevealed ? null : _revealCard,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _isRevealed ? _scaleAnimation.value : 1.0,
                      child: Opacity(
                        opacity: _isRevealed ? _fadeAnimation.value : 1.0,
                        child:
                            _isRevealed
                                ? _buildRevealedCard()
                                : _buildHiddenCard(),
                      ),
                    );
                  },
                ),
              ),

              if (_isRevealed) ...[
                SizedBox(height: 40.h),
                _buildCardInterpretation(),
                SizedBox(height: 32.h),
                _buildActionButtons(),
                SizedBox(height: 24.h),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHiddenCard() {
    return Container(
      width: 220.w,
      height: 320.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 25,
            offset: const Offset(0, 15),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 배경 패턴
          Positioned(
            top: 20.h,
            right: 20.w,
            child: Icon(
              Icons.star,
              size: 24.sp,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          Positioned(
            bottom: 30.h,
            left: 25.w,
            child: Icon(
              Icons.star,
              size: 16.sp,
              color: Colors.white.withValues(alpha: 0.15),
            ),
          ),

          // 메인 컨텐츠
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    size: 40.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  '?',
                  style: TextStyle(
                    fontSize: 52.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '터치하여 공개',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevealedCard() {
    if (_todayCard == null) return const SizedBox();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Text(
        _todayCard!.name,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDark,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCardInterpretation() {
    if (_todayCard == null) return const SizedBox();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 카드 이름
          Text(
            _todayCard!.name,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),

          // 키워드
          Text(
            _todayCard!.keyword,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),

          // 구분선
          Container(
            height: 1,
            width: 60.w,
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),

          // 해석
          Text(
            _todayCard!.interpretation,
            style: TextStyle(
              fontSize: 15.sp,
              height: 1.6,
              color: AppColors.black,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // 상세보기 버튼
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.push('/card-info/${_todayCard!.number}'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              '카드 상세보기',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // 다시 뽑기 버튼
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                _isRevealed = false;
                _animationController.reset();
                _generateTodayCard(isReroll: true);
              });
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary, width: 1.5),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              '다시 뽑기',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
