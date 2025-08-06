import 'package:flutter/material.dart';
import 'package:lilac_arcana/providers/tarot_provider.dart';
import 'package:lilac_arcana/widgets/birthdate_input_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:lilac_arcana/widgets/tarot_card_pair_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_arcana/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  // 양력 컨트롤러 (선천수 계산에 사용)
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();

  // 음력 컨트롤러 (후천수 계산에 사용)
  final _lunarYearController = TextEditingController();
  final _lunarMonthController = TextEditingController();
  final _lunarDayController = TextEditingController();

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _lunarYearController.dispose();
    _lunarMonthController.dispose();
    _lunarDayController.dispose();
    super.dispose();
  }

  void _calculate() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      // 양력 데이터 검증
      final solarYear = int.tryParse(_yearController.text);
      final solarMonth = int.tryParse(_monthController.text);
      final solarDay = int.tryParse(_dayController.text);

      // 음력 데이터 검증
      final lunarYear = int.tryParse(_lunarYearController.text);
      final lunarMonth = int.tryParse(_lunarMonthController.text);
      final lunarDay = int.tryParse(_lunarDayController.text);

      if (solarYear == null ||
          solarMonth == null ||
          solarDay == null ||
          lunarYear == null ||
          lunarMonth == null ||
          lunarDay == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('양력과 음력을 모두 입력해주세요.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      try {
        // 양력 DateTime 생성 (선천수 계산에 사용)
        final solarBirthDate = DateTime(solarYear, solarMonth, solarDay);

        // 음력 DateTime 생성 (후천수 계산에 사용)
        final lunarBirthDate = DateTime(lunarYear, lunarMonth, lunarDay);

        Provider.of<TarotProvider>(
          context,
          listen: false,
        ).calculateAll(solarBirthDate, lunarBirthDate);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('유효하지 않은 날짜입니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _clearAndRecalculate() {
    Provider.of<TarotProvider>(context, listen: false).clear();
    _yearController.clear();
    _monthController.clear();
    _dayController.clear();
    _lunarYearController.clear();
    _lunarMonthController.clear();
    _lunarDayController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Consumer<TarotProvider>(
          builder: (context, provider, child) {
            // 로딩 상태
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // 결과가 있는 경우 결과 화면 표시
            if (provider.innateLifeNumberCard != null) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 제목
                    Text(
                      '타로 계산 결과',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // 선천수 (음력)
                    TarotCardPairWidget(
                      title: '선천수 (음력)',
                      lifeCard: provider.innateLifeNumberCard,
                      shadowCard: provider.innateShadowCard,
                      onLifeCardTap:
                          (card) => context.push('/card-info/${card.number}'),
                      onShadowCardTap:
                          (card) => context.push('/card-info/${card.number}'),
                    ),

                    // 후천수 (양력)
                    TarotCardPairWidget(
                      title: '후천수 (양력)',
                      lifeCard: provider.acquiredLifeNumberCard,
                      shadowCard: provider.acquiredShadowCard,
                      onLifeCardTap:
                          (card) => context.push('/card-info/${card.number}'),
                      onShadowCardTap:
                          (card) => context.push('/card-info/${card.number}'),
                    ),

                    // 직업수
                    TarotCardPairWidget(
                      title: '직업수',
                      lifeCard: provider.vocationLifeNumberCard,
                      shadowCard: provider.vocationShadowCard,
                      onLifeCardTap:
                          (card) => context.push('/card-info/${card.number}'),
                      onShadowCardTap:
                          (card) => context.push('/card-info/${card.number}'),
                    ),

                    SizedBox(height: 20.h),

                    // 다시 계산 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _clearAndRecalculate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          '다시 계산하기',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            // 초기 상태 - 입력 화면 표시
            return BirthdateInputWidget(
              formKey: _formKey,
              yearController: _yearController,
              monthController: _monthController,
              dayController: _dayController,
              lunarYearController: _lunarYearController,
              lunarMonthController: _lunarMonthController,
              lunarDayController: _lunarDayController,
              onCalculate: _calculate,
              isLoading: provider.isLoading,
            );
          },
        ),
      ),
    );
  }
}
