import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _UserTravelInfoPageState();
}

class _UserTravelInfoPageState extends State<FormPage> {

  String? _age;
  String? _gender;
  String? _nationality;
  String? _diseaseInfo;

  final List<String> ageOptions = ['10s', '20s', '30s', '40s', 'more than 50s'];
  final List<String> genderOptions = ['Men', 'Woman', 'Other'];
  final List<String> nationalityOptions = ['korea', 'china', 'japan', 'usa', 'taiwan', 'thailand', 'vietnam', 'philippines', 'malaysia', 'singapore', 'indonesia', 'hongkong', 'australia', 'canada', 'russia', 'mongolia', 'india', 'unitedkingdom', 'germany', 'france', 'italy', 'spain', 'netherlands', 'switzerland', 'sweden', 'norway', 'denmark', 'finland', 'austria', 'belgium', 'czechrepublic', 'poland', 'turkey', 'unitedarabemirates', 'qatar', 'saudiarabia', 'kazakhstan', 'uzbekistan', 'newzealand', 'brazil', 'mexico', 'argentina', 'chile', 'southafrica', 'egypt', 'morocco', 'israel', 'myanmar', 'cambodia', 'laos', 'nepal'];
  final List<String> diseaseOptions = ['Hypertension', 'Diabetes', 'Hyperlipidemia', 'Asthma', 'Arthritis', 'UlcerativeColitis', 'CoronaryHeartDisease', 'Depression', 'AnxietyDisorder', 'ChronicObstructivePulmonaryDisease', 'Insomnia', 'AllergicRhinitis', 'GastroesophagealRefluxDisease', 'IrritableBowelSyndrome', 'Osteoporosis', 'MigraineHeadache', 'ThyroidDisorder', 'ChronicKidneyDisease', 'Eczema', 'HeartFailure', 'Anemia', 'GoutArthritis', 'SleepApnea', 'LactoseIntolerance', 'Glaucoma', 'ArrhythmiaAfib', 'BackPain', 'BenignProstaticHyperplasia', 'Osteoarthritis', 'ParkinsonsDisease', 'AlzheimersDisease'];

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
      backgroundColor: Colors.white,
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
          const SizedBox(height: 48),
          _buildLabel('사용자 연령'),
          _buildDropdown(
            hint: '나이 선택',
            value: _age,
            items: ageOptions,
            onChanged: (v) => setState(() => _age = v),
          ),
          const SizedBox(height: 24),

          _buildLabel('사용자 성별'),
          _buildDropdown(
            hint: '성별을 입력해주세요',
            value: _gender,
            items: genderOptions,
            onChanged: (v) => setState(() => _gender = v),
          ),
          const SizedBox(height: 24),

          _buildLabel('사용자 국적'),
          _buildDropdown(
            hint: '국적을 입력해주세요',
            value: _nationality,
            items: nationalityOptions,
            onChanged: (v) => setState(() => _nationality = v),
          ),
          const SizedBox(height: 24),

          _buildLabel('질병 유무 및 정보'),
          _buildDropdown(
            hint: '질병에 관한 정보를 입력해주세요',
            value: _diseaseInfo,
            items: diseaseOptions,
            onChanged: (v) => setState(() => _diseaseInfo = v),
          ),
          const SizedBox(height: 24),

          const Spacer(),
          const SizedBox(height: 48),
          Center(
            child: SizedBox(
              width: 151,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CC7EB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 4,
                ),
                onPressed: _nextPage,
                child: const Text('다음 단계', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTravelInfoPage() {
    return Container(
      color: Colors.white,
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
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '사용자 정보를 입력해주시면\n원활한 여행 정보를 제공 해 드리겠습니다',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 48),
            _buildLabel('여행지'),
            _buildDropdown(
              hint: '여행할 지역을 선택해주세요',
              value: _nationality,
              items: nationalityOptions,
              onChanged: (v) => setState(() => _nationality = v),
            ),
            const SizedBox(height: 24),

            _buildLabel('여행 기간'),
            _buildDropdown(
              hint: '여행 기간을 입력해주세요',
              value: _nationality,
              items: nationalityOptions,
              onChanged: (v) => setState(() => _nationality = v),
            ),
            const SizedBox(height: 24),

            _buildLabel('여행 단위'),
            _buildDropdown(
              hint: '여행 단위를 입력해주세요',
              value: _nationality,
              items: nationalityOptions,
              onChanged: (v) => setState(() => _nationality = v),
            ),
            const SizedBox(height: 24),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 151,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE6D85A), // 노란색
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _prevPage,
                    child: const Text('이전 단계', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 151,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CC7EB), // 하늘색
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {

                    },
                    child: const Text('분석 하기', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
  );

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          focusColor: Colors.transparent,
          value: value,
          hint: Text(hint, style: const TextStyle(color: Colors.black38)),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: onChanged,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        ),
      ),
    );
  }
}
