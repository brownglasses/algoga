import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class WeatherCircleDecoration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width - 25, 25);
    final paint = Paint()..style = PaintingStyle.fill;

    paint.color = const Color(0xFFFFFFFF).withOpacity(0.10);
    canvas.drawCircle(center, 60, paint);

    paint.color = const Color(0xFFFFFFFF).withOpacity(0.15);
    canvas.drawCircle(center, 45, paint);

    paint.color = const Color(0xFFFCE588);
    canvas.drawCircle(center, 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  int _selectedTabIndex = 0;
  late Timer _timer;

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  String _selectedCategory = '날씨';

  final List<Map<String, String>> _places = [
    {'title': '롯데월드', 'image': 'assets/images/lotte.png'},
    {'title': '창덕궁', 'image': 'assets/images/changdeok.jpg'},
    {'title': '한강공원', 'image': 'assets/images/hangang.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      _currentPage++;
      if (_currentPage >= _places.length) {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '다른 지역 정보 추천 해드릴까요?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: '여행지, 즐길 거리, 호텔 등',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '현재 여행지 정보 Algoga!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    ['날씨', '교통', '재난', '건강'].map((label) {
                      final isSelected = _selectedCategory == label;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ), // 버튼 간격
                        child: SizedBox(
                          width: 80,
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedCategory = label;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isSelected
                                      ? Colors.grey[400]
                                      : const Color(0xFFF0F0F0),
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              label,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 24),
              if (_selectedCategory == '날씨') _weatherCard(),
              if (_selectedCategory == '교통') _trafficCard(),
              if (_selectedCategory == '재난') _disasterCard(),
              if (_selectedCategory == '건강') _healthCard(),
              const SizedBox(height: 32),
              const Text(
                '현재 지역에서 인기있는 장소',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _places.length,
                  itemBuilder: (context, index) {
                    final place = _places[index];
                    return _placeCard(place['title']!, place['image']!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: _onTabTapped,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          iconSize: 37.0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: '좋아요',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox_outlined),
              activeIcon: Icon(Icons.inbox),
              label: '함',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '마이',
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: const BoxDecoration(
          color: Color(0xFF4CB5F5),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: WeatherCircleDecoration(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '17°C',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tuesday, 29 April',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          '🇰🇷 Seoul, South Korea',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '🌤️ Clear Sky',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trafficCard() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/traffic.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            '시내버스 준법운행 투쟁\n버스 운행 지연 우려',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black, blurRadius: 3)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _disasterCard() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/sinkhole.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            '서울 강동구\n대형 땅 꺼짐 발생',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black, blurRadius: 3)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _healthCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F6E8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '✅ 오늘의 건강 체크 포인트',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text('클릭 시 자세한 내용 확인 가능'),
          SizedBox(height: 12),
          Text('😷 미세먼지 농도 높음'),
          Text('🌞 자외선 지수 높음 (화상 위험)'),
          Text('🌼 꽃가루 알레르기 주의'),
        ],
      ),
    );
  }

  Widget _placeCard(String title, String imagePath) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black, blurRadius: 3)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
