import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_arcana/constants/app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _isNotificationEnabled = true;
  bool _isSoundEnabled = true;
  bool _isVibrationEnabled = true;
  String _selectedLanguage = '한국어';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          '설정',
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
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 헤더 섹션
              _buildHeader(),
              SizedBox(height: 24.h),

              // 외관 설정
              _buildSettingsSection('외관 설정', Icons.palette_outlined, [
                _buildSwitchTile(
                  '다크 모드',
                  '어두운 테마를 사용합니다',
                  Icons.dark_mode_outlined,
                  _isDarkMode,
                  (value) => setState(() => _isDarkMode = value),
                ),
                _buildLanguageTile(),
              ]),
              SizedBox(height: 20.h),

              // 알림 설정
              _buildSettingsSection('알림 설정', Icons.notifications_outlined, [
                _buildSwitchTile(
                  '푸시 알림',
                  '오늘의 카드 알림을 받습니다',
                  Icons.notifications_active_outlined,
                  _isNotificationEnabled,
                  (value) => setState(() => _isNotificationEnabled = value),
                ),
                _buildSwitchTile(
                  '사운드',
                  '알림 사운드를 재생합니다',
                  Icons.volume_up_outlined,
                  _isSoundEnabled,
                  (value) => setState(() => _isSoundEnabled = value),
                ),
                _buildSwitchTile(
                  '진동',
                  '알림 시 진동을 사용합니다',
                  Icons.vibration_outlined,
                  _isVibrationEnabled,
                  (value) => setState(() => _isVibrationEnabled = value),
                ),
              ]),
              SizedBox(height: 20.h),

              // 데이터 설정
              _buildSettingsSection('데이터 설정', Icons.storage_outlined, [
                _buildActionTile(
                  '데이터 백업',
                  '생년월일 및 설정을 백업합니다',
                  Icons.backup_outlined,
                  () => _showComingSoonDialog('데이터 백업'),
                ),
                _buildActionTile(
                  '데이터 복원',
                  '백업된 데이터를 복원합니다',
                  Icons.restore_outlined,
                  () => _showComingSoonDialog('데이터 복원'),
                ),
                _buildActionTile(
                  '데이터 초기화',
                  '모든 데이터를 삭제합니다',
                  Icons.delete_outline,
                  () => _showResetDialog(),
                  isDestructive: true,
                ),
              ]),
              SizedBox(height: 20.h),

              // 정보
              _buildSettingsSection('정보', Icons.info_outlined, [
                _buildActionTile(
                  '앱 정보',
                  '버전 및 라이센스 정보',
                  Icons.info_outlined,
                  () => _showAppInfoDialog(),
                ),
                _buildActionTile(
                  '이용약관',
                  '서비스 이용약관을 확인합니다',
                  Icons.description_outlined,
                  () => _showComingSoonDialog('이용약관'),
                ),
                _buildActionTile(
                  '개인정보처리방침',
                  '개인정보 보호 정책을 확인합니다',
                  Icons.privacy_tip_outlined,
                  () => _showComingSoonDialog('개인정보처리방침'),
                ),
              ]),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
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
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.settings,
              size: 32.sp,
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            '설정',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '앱 사용 환경을 설정하세요',
            style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 헤더
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 20.sp),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),
          // 섹션 컨텐츠
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGrey.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            inactiveThumbColor: AppColors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lightGrey.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color:
                    isDestructive
                        ? AppColors.error.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: isDestructive ? AppColors.error : AppColors.primary,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDestructive ? AppColors.error : AppColors.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.grey, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile() {
    return InkWell(
      onTap: () => _showLanguageDialog(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lightGrey.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.language_outlined,
                color: AppColors.primary,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '언어 설정',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '현재: $_selectedLanguage',
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.grey, size: 20.sp),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('언어 선택'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLanguageOption('한국어'),
                _buildLanguageOption('English'),
                _buildLanguageOption('日本語'),
              ],
            ),
          ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return RadioListTile<String>(
      title: Text(language),
      value: language,
      groupValue: _selectedLanguage,
      onChanged: (value) {
        setState(() => _selectedLanguage = value!);
        Navigator.pop(context);
      },
      activeColor: AppColors.primary,
    );
  }

  void _showComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('개발 예정'),
            content: Text('$feature 기능은 추후 업데이트에서 제공될 예정입니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('확인'),
              ),
            ],
          ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('데이터 초기화'),
            content: Text('모든 데이터가 삭제됩니다. 정말 계속하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showComingSoonDialog('데이터 초기화');
                },
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: Text('초기화'),
              ),
            ],
          ),
    );
  }

  void _showAppInfoDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Lilac Arcana'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('버전: 1.0.0'),
                SizedBox(height: 8.h),
                Text('개발자: Lilac Studio'),
                SizedBox(height: 8.h),
                Text('설명: 생년월일 기반 타로 카드 앱'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('확인'),
              ),
            ],
          ),
    );
  }
}
