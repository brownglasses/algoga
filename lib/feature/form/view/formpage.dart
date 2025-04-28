import 'package:flutter/material.dart';

class UserTravelInfoPage extends StatefulWidget {
  const UserTravelInfoPage({super.key});

  @override
  State<UserTravelInfoPage> createState() => _UserTravelInfoPageState();
}

class _UserTravelInfoPageState extends State<UserTravelInfoPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentPage == 0 ? Colors.white : Colors.black,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), // 스와이프 막고 버튼으로만 이동
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: [_buildUserInfoPage(), _buildTravelInfoPage()],
        ),
      ),
    );
  }

  Widget _buildUserInfoPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            'Algoga에 오신것을 환영합니다!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          const Text(
            '사용자 정보를 입력해주시면\n원활한 여행 정보를 제공 해 드리겠습니다',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 30),
          _buildDropdownField('사용자 연령', '나이 선택'),
          const SizedBox(height: 15),
          _buildDropdownField('사용자 성별', '성별을 입력해주세요'),
          const SizedBox(height: 15),
          _buildDropdownField('사용자 국적', '국적을 입력해주세요'),
          const SizedBox(height: 15),
          _buildDropdownField('질병 유무 및 정보', '질병에 관한 정보를 입력해주세요'),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 15,
                ),
              ),
              child: const Text('다음 단계', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTravelInfoPage() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Algoga에 오신것을 환영합니다!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '사용자 정보를 입력해주시면\n원활한 여행 정보를 제공 해 드리겠습니다',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 30),
            _buildDropdownField('여행지', '여행할 지역을 선택해주세요', isDark: true),
            const SizedBox(height: 15),
            _buildDropdownField('여행 기간', '여행 기간을 입력해주세요', isDark: true),
            const SizedBox(height: 15),
            _buildDropdownField('관심사', '관심사를 선택해주세요', isDark: true),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _prevPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    '이전 단계',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 완료 처리
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('다음 단계', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String hint, {bool isDark = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(border: InputBorder.none),
            dropdownColor: isDark ? Colors.grey[800] : Colors.white,
            hint: Text(
              hint,
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
            ),
            items: [], // 실제 아이템 추가 가능
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
