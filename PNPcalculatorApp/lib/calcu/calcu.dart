import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'service.dart';
import 'compute.dart';

class CalcuScreen extends StatefulWidget {
  final String? lengthOfService;

  CalcuScreen({this.lengthOfService});

  @override
  _CalcuScreenState createState() => _CalcuScreenState();
}

class _CalcuScreenState extends State<CalcuScreen> {
  bool _hovering = false;

  // Flag to Track if Submit was Attempted (REQUIRED)
  bool isSubmitAttempted = false;

  // Selected Values (HIGHEST, STATUS, RETIREMENT, LONGEVITY)
  String? selectedRankHighest;
  String? selectedRankStatus;
  String? selectedRankRetirement;
  String? selectedRankLongevity;

  String? selectedYears;
  String? selectedMonths;
  String? selectedDays;

  // Controller For Leave Credits Input
  TextEditingController _leaveCreditsController = TextEditingController();

  final Map<String, double> rankSalaries = {
    'Police General': 149785,
    'Police Lieutenant General': 125574,
    'Police Major General': 102896,
    'Police Brigadier General': 91058,
    'Police Colonel': 80583,
    'Police Lieutenant Colonel': 71313,
    'Police Major': 62555,
    'Police Captain': 56582,
    'Police Lieutenant': 49528,
    'Police Executive Master Sergeant': 38366,
    'Police Chief Master Sergeant': 34761,
    'Police Senior Master Sergeant': 34079,
    'Police Master Sergeant': 33411,
    'Police Staff Sergeant': 32114,
    'Police Corporal': 30867,
    'Patrolman/Patrolwoman': 29668
  };

  final Map<String, double> longevityRates = {
    'No Long Pay': 0.0,
    '1st Long Pay': 0.10,
    '2nd Long Pay': 0.21,
    '3rd Long Pay': 0.331,
    '4th Long Pay': 0.4641,
    '5th Long Pay': 0.50
  };

  final List<String> rankOrder = [
    'Patrolman/Patrolwoman',
    'Police Corporal',
    'Police Staff Sergeant',
    'Police Master Sergeant',
    'Police Senior Master Sergeant',
    'Police Chief Master Sergeant',
    'Police Executive Master Sergeant',
    'Police Lieutenant',
    'Police Captain',
    'Police Major',
    'Police Lieutenant Colonel',
    'Police Colonel',
    'Police Brigadier General',
    'Police Major General',
    'Police Lieutenant General',
    'Police General'
  ];

  double getNextRankBasePay(String? rank, {String? status}) {
    if (rank == null || !rankOrder.contains(rank)) return 0.0;

    if (status == '1 Year Permanent') {
      int currentIndex = rankOrder.indexOf(rank);
      if (currentIndex < rankOrder.length - 1) {
        String nextRank = rankOrder[currentIndex + 1];
        return rankSalaries[nextRank] ?? 0.0;
      }
    }

    return rankSalaries[rank] ?? 0.0;
  }

  double calculateMaxLeaveCredits({bool isForPension = false}) {
    int years = int.tryParse(selectedYears ?? '0') ?? 0;
    int months = int.tryParse(selectedMonths ?? '0') ?? 0;
    int days = int.tryParse(selectedDays ?? '0') ?? 0;

    if (isForPension) {
      return (years * 2.5) + (months * 0.208) + (days * 0.006);
    } else {
      return (years * 30) + (months * 2.5) + (days * 0.08) - (years * 5);
    }
  }

  double calculateBenefits() {
    double basePay = getNextRankBasePay(selectedRankHighest, status: selectedRankStatus);
    double longPay = 0.0;
    double leaveCredits = double.tryParse(_leaveCreditsController.text) ?? calculateMaxLeaveCredits();

    if (selectedRankLongevity != null && longevityRates.containsKey(selectedRankLongevity)) {
      longPay = basePay * longevityRates[selectedRankLongevity]!;
    }

    double totalBenefits = (basePay + longPay) * leaveCredits * 0.0481927;
    return totalBenefits;
  }

  double calculateGratuity() {
    double basePay = getNextRankBasePay(selectedRankHighest, status: selectedRankStatus);
    double longPay = 0.0;

    if (selectedRankLongevity != null && longevityRates.containsKey(selectedRankLongevity)) {
      longPay = basePay * longevityRates[selectedRankLongevity]!;
    }

    return (basePay + longPay) * 12;
  }

  Map<String, double> calculatePensionAndGratuity() {
    double basePay = getNextRankBasePay(selectedRankHighest, status: selectedRankStatus);
    double longPay = 0.0;

    if (selectedRankLongevity != null && longevityRates.containsKey(selectedRankLongevity)) {
      longPay = basePay * longevityRates[selectedRankLongevity]!;
    }

    double monthlyPension;
    double gratuity = 0.0;
    double lumpSum = 0.0;

    if (selectedRankRetirement == 'Total Permanent Physical Disability TPPD') {
      monthlyPension = (basePay + longPay) * 0.80;
      gratuity = (basePay + longPay) * 12;
    } else {
      double pensionMultiplier = calculateMaxLeaveCredits(isForPension: true);
      monthlyPension = (basePay + longPay) * (pensionMultiplier / 100);
    }

    lumpSum = monthlyPension * 36;

    return {
      'monthlyPension': monthlyPension,
      'gratuity': gratuity,
      'lumpSum': lumpSum
    };
  }

  String formatBenefits(double benefits) {
    final NumberFormat formatter = NumberFormat('#,###.00');
    return formatter.format(benefits);
  }

  // Check if Length of Service is Selected (REQUIRED)
  bool isServiceLengthSelected() {
    return selectedYears != null && selectedMonths != null && selectedDays != null &&
        selectedYears!.isNotEmpty && selectedMonths!.isNotEmpty && selectedDays!.isNotEmpty &&
        selectedYears != 'Select Year' && selectedMonths != 'Select Month' && selectedDays != 'Select Day';
  }

  void computeBenefits() {
    double totalBenefits = calculateBenefits();
    Map<String, double> pensionData = calculatePensionAndGratuity();

    setState(() {
      isSubmitAttempted = true;
    });

    // Check if Required Fields are Selected (DROP-DOWN REQUIRED)
    // HIGHEST RANK ATTAINED Selected (DROP-DOWN REQUIRED)
    if (selectedRankHighest == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please Select Highest Rank Attained')),
      );
      return;
    }

    // STATUS OF LAST PROMOTION Selected (DROP-DOWN REQUIRED)
    if (selectedRankStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please Select Status of Last Promotion')),
      );
      return;
    }

    // Check if Length of Service is Selected
    if (!isServiceLengthSelected()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please Select Length of Service')),
      );
      return;
    }

    // RETIREMENT MODE Selected (DROP-DOWN REQUIRED)
    if (selectedRankRetirement == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please Select Retirement Mode')),
      );
      return;
    }

    // LONGEVITY PAY Selected (DROP-DOWN REQUIRED)
    if (selectedRankLongevity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please Select Longevity Pay')),
      );
      return;
    }

    // MAXIMUM LEAVE CREDITS (REQUIRED)
    if (_leaveCreditsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please Enter Number of Leave Credits')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComputeScreen(
          benefits: totalBenefits,
          monthlyPension: pensionData['monthlyPension'] ?? 0.0,
          gratuity: pensionData['gratuity'] ?? 0.0,
          lumpSum: pensionData['lumpSum'] ?? 0.0,
        ),
      ),
    );
  }

  String getServiceLengthText() {
    if (selectedYears != null || selectedMonths != null || selectedDays != null) {
      List<String> parts = [];

      // YEAR PART
      int totalYears = int.tryParse(selectedYears ?? '0') ?? 0;
      int totalMonths = int.tryParse(selectedMonths ?? '0') ?? 0;
      int totalDays = int.tryParse(selectedDays ?? '0') ?? 0;

      totalYears += (totalMonths >= 6) ? 1 : 0;

      if (totalYears < 5) {
        selectedRankLongevity = 'No Long Pay';
      } else if (totalYears >= 5 && totalYears < 10) {
        selectedRankLongevity = '1st Long Pay';
      } else if (totalYears >= 10 && totalYears < 15) {
        selectedRankLongevity = '2nd Long Pay';
      } else if (totalYears >= 15 && totalYears < 20) {
        selectedRankLongevity = '3rd Long Pay';
      } else if (totalYears >= 20 && totalYears < 25) {
        selectedRankLongevity = '4th Long Pay';
      } else if (totalYears >= 25) {
        selectedRankLongevity = '5th Long Pay';
      }

      if (selectedYears != null && selectedYears!.isNotEmpty && selectedYears != 'Select Year') {
        parts.add('$selectedYears Year${totalYears > 1 ? 's' : ''}');
      }

      if (selectedMonths != null && selectedMonths!.isNotEmpty && selectedMonths != 'Select Month') {
        parts.add('$selectedMonths Month${totalMonths > 1 ? 's' : ''}');
      }

      if (selectedDays != null && selectedDays!.isNotEmpty && selectedDays != 'Select Day') {
        parts.add('$selectedDays Day${totalDays > 1 ? 's' : ''}');
      }

      if (parts.isNotEmpty) {
        return parts.join(' / ');
      }
    }
    return 'Length of Service';
  }


  @override
  void initState() {
    super.initState();

    if (widget.lengthOfService != null) {
      List<String> parts = widget.lengthOfService!.split('/');
      if (parts.length == 3) {
        selectedYears = parts[0].trim().split(' ')[0];
        selectedMonths = parts[1].trim().split(' ')[0];
        selectedDays = parts[2].trim().split(' ')[0];

        double maxLeaveCredits = calculateMaxLeaveCredits(isForPension: false);

        if (_leaveCreditsController.text.isEmpty) {
          _leaveCreditsController.text = maxLeaveCredits.toStringAsFixed(2);
        } else {
          double currentLeaveCredits = double.tryParse(_leaveCreditsController.text) ?? 0.0;

          if (maxLeaveCredits > currentLeaveCredits) {
            _leaveCreditsController.text = currentLeaveCredits.toStringAsFixed(2);
          } else {
            _leaveCreditsController.text = maxLeaveCredits.toStringAsFixed(2);
          }
          }
      }
    }
    _leaveCreditsController.addListener(() {
      double maxLeaveCredits = calculateMaxLeaveCredits(isForPension: false);
      double currentLeaveCredits = double.tryParse(_leaveCreditsController.text) ?? 0.0;

      if (currentLeaveCredits > maxLeaveCredits) {
        _leaveCreditsController.text = maxLeaveCredits.toStringAsFixed(2);
        _leaveCreditsController.selection = TextSelection.fromPosition(
            TextPosition(offset: _leaveCreditsController.text.length));
      }
    });
    // PORTRAIT MODE ONLY
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _leaveCreditsController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // FOR RESPONSIVENESS
    double paddingFactor = screenWidth < 600 ? 12.0 : 24.0;
    double titleFontSize = screenWidth * 0.06;
    double bodyFontSize = screenWidth * 0.035;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF07123C),
              Color(0xFF3B64D8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back Button
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),

              // Benefits Calculator Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingFactor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calculate,
                      color: Colors.white,
                      size: screenWidth * 0.15,
                    ),
                    SizedBox(width: 8),

                    // Vertical Line
                    Container(
                      height: screenHeight * 0.08,
                      width: 2,
                      color: Colors.white,
                    ),
                    SizedBox(width: 14),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Benefits',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFontSize,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'Calculator',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFontSize,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Information Text
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: paddingFactor,
                ),
                child: Text(
                  'Please Complete The Required Information',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(paddingFactor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            _buildDropdownFieldHighestRank(screenWidth),
                            SizedBox(height: screenHeight * 0.02),
                            _buildDropdownFieldStatusLastPromotion(screenWidth),
                            SizedBox(height: screenHeight * 0.02),
                            // Length of Service Button
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServiceScreen(
                                      onDone: (years, months, days) {
                                        setState(() {
                                          selectedYears = years;
                                          selectedMonths = months;
                                          selectedDays = days;

                                          // AUTO-POPULATE Leave Credits when Service Length Changes
                                          if (_leaveCreditsController.text.isEmpty) {
                                            double maxLeaveCredits = calculateMaxLeaveCredits(isForPension: false);

                                            _leaveCreditsController.text = maxLeaveCredits.toStringAsFixed(2);
                                          } else {
                                            double maxLeaveCredits = calculateMaxLeaveCredits(isForPension: false);
                                            double currentLeaveCredits = double.tryParse(_leaveCreditsController.text) ?? 0.0;

                                            if (maxLeaveCredits > currentLeaveCredits) {
                                              _leaveCreditsController.text = currentLeaveCredits.toStringAsFixed(2);
                                            } else {
                                              _leaveCreditsController.text = maxLeaveCredits.toStringAsFixed(2);
                                            }
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: MouseRegion(
                                onEnter: (_) {
                                  setState(() {
                                    _hovering = true;
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    _hovering = false;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: _hovering ? Colors.blueAccent : const Color(0xFF0A2A5E),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSubmitAttempted && !isServiceLengthSelected()
                                          ? Colors.red
                                          : Colors.white24,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Text(
                                          getServiceLengthText(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: bodyFontSize,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.white,
                                          size: screenWidth * 0.06,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            _buildDropdownFieldRetirementMode(screenWidth),
                            SizedBox(height: screenHeight * 0.02),
                            _buildDropdownFieldLongevityPay(screenWidth),
                            SizedBox(height: screenHeight * 0.03),
                            // Leave Credits Input
                            _buildLeaveCreditsInput(screenWidth, bodyFontSize),
                            SizedBox(height: screenHeight * 0.03),
                            // Compute Button
                            _buildComputeButton(screenWidth),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(
                    'Copyright 2016-2022\nPhilippine National Police\nInformation Technology Management Service\nwww.itms.pnp.gov.ph',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.5,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // New Widget For Leave Credits Input
  Widget _buildLeaveCreditsInput(double screenWidth, double bodyFontSize) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSubmitAttempted && _leaveCreditsController.text.isEmpty
              ? Colors.red
              : Colors.white24,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Maximum Leave Credits: ",
              style: TextStyle(
                color: Colors.black,
                fontSize: bodyFontSize,
              ),
            ),
          ),
          // EDITABLE FIELD
          Expanded(
            child: TextField(
              controller: _leaveCreditsController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                color: Colors.red,
                fontSize: bodyFontSize,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Compute Button Widget
  Widget _buildComputeButton(double screenWidth) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          computeBenefits();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF0A2A5E)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 15),
          ),
          side: MaterialStateProperty.all(
            const BorderSide(color: Colors.white24, width: 1),
          ),
        ),
        child: Text(
          'Compute Benefits',
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // DROPDOWN OPTIONS FOR HIGHEST RANK ATTAINED
  Widget _buildDropdownFieldHighestRank(double screenWidth) {
    Map<String, String> rankMapping = {
      'Police General': 'PGEN',
      'Police Lieutenant General': 'PLTGEN',
      'Police Major General': 'PMGEN',
      'Police Brigadier General': 'PBGEN',
      'Police Colonel': 'PCOL',
      'Police Lieutenant Colonel': 'PLTCOL',
      'Police Major': 'PMAJ',
      'Police Captain': 'PCPT',
      'Police Lieutenant': 'PLT',
      'Police Executive Master Sergeant': 'PEMS',
      'Police Chief Master Sergeant': 'PCMS',
      'Police Senior Master Sergeant': 'PSMS',
      'Police Master Sergeant': 'PMSg',
      'Police Staff Sergeant': 'PSSg',
      'Police Corporal': 'PCpl',
      'Patrolman/Patrolwoman': 'Pat',
    };

    List<String> options = ['Highest Rank Attained'] + rankMapping.keys.toList();
    String? subtitle = selectedRankHighest != null ? rankMapping[selectedRankHighest] : null;

    // !! REQUIRED WARNING FOR HIGHEST RANK ATTAINED !!
    Color borderColor = isSubmitAttempted && selectedRankHighest == null ? Colors.red : Colors.white24;

    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A5E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              _showCustomMenu(
                context,
                options,
                    (value) {
                  if (value != 'Highest Rank Attained') {
                    setState(() {
                      selectedRankHighest = value;
                    });
                  }
                },
                selectedRankHighest,
                rankMapping,
                screenWidth,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedRankHighest ?? 'Highest Rank Attained',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitle != null)
                          Text(
                            '(${subtitle})',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // DROPDOWN OPTIONS FOR STATUS OF LAST PROMOTION
  Widget _buildDropdownFieldStatusLastPromotion(double screenWidth) {
    Map<String, String> statusMapping = {
      'Permanent for more than a year': 'Status of Last Promotion',
      'Permanent for less than a year': 'Status of Last Promotion',
    };

    List<String> options = [
      'Status of Last Promotion',
    ] + statusMapping.keys.toList();

    String? subtitle = selectedRankStatus != null ? statusMapping[selectedRankStatus] : null;

    // !! REQUIRED WARNING FOR STATUS OF LAST PROMOTION !!
    Color borderColor = isSubmitAttempted && selectedRankStatus == null ? Colors.red : Colors.white24;

    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A5E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: MouseRegion(
          onEnter: (_) {
            setState(() {

            });
          },
          onExit: (_) {
            setState(() {

            });
          },
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                _showCustomMenu(
                  context,
                  options,
                      (value) {
                    if (value != 'Status of Last Promotion') {
                      setState(() {
                        selectedRankStatus = value;
                      });
                    }
                  },
                  selectedRankStatus,
                  statusMapping,
                  screenWidth,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedRankStatus ?? 'Status of Last Promotion',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.035,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (subtitle != null)
                            Text(
                              '(${subtitle})',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: screenWidth * 0.03,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// DROPDOWN OPTIONS FOR CHOOSE RETIREMENT MODE
  Widget _buildDropdownFieldRetirementMode(double screenWidth) {
    Map<String, String> retirementModeMapping = {
      'Compulsory': 'Retirement Mode',
      'Optional': 'Retirement Mode',
      'Total Permanent Physical Disability TPPD': 'Retirement Mode',
      'Posthumous': 'Retirement Mode',
    };

    List<String> options = [
      'Choose Retirement Mode',
    ] + retirementModeMapping.keys.toList();

    String? subtitle = selectedRankRetirement != null ? retirementModeMapping[selectedRankRetirement] : null;

    // !! REQUIRED WARNING FOR CHOOSE RETIREMENT MODE !!
    Color borderColor = isSubmitAttempted && selectedRankRetirement == null ? Colors.red : Colors.white24;

    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A5E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: MouseRegion(
          onEnter: (_) {
            setState(() {

            });
          },
          onExit: (_) {
            setState(() {

            });
          },
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                _showCustomMenu(
                  context,
                  options,
                      (value) {
                    if (value != 'Choose Retirement Mode') {
                      setState(() {
                        selectedRankRetirement = value;
                      });
                    }
                  },
                  selectedRankRetirement,
                  retirementModeMapping,
                  screenWidth,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedRankRetirement ?? 'Choose Retirement Mode',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.035,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (subtitle != null)
                            Text(
                              '(${subtitle})',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: screenWidth * 0.03,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TEXT VIEW FOR LONGEVITY PAY
  Widget _buildDropdownFieldLongevityPay(double screenWidth) {
    Map<String, String> longevityPayMapping = {
      'No Long Pay': 'Longevity pay',
      '1st Long Pay': 'Longevity pay',
      '2nd Long Pay': 'Longevity pay',
      '3rd Long Pay': 'Longevity pay',
      '4th Long Pay': 'Longevity pay',
      '5th Long Pay': 'Longevity pay',
    };

    String displayText = selectedRankLongevity ?? 'Longevity Pay';

    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A5E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    displayText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.035,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  // Custom Drop Down Menu
  void _showCustomMenu(
      BuildContext context,
      List<String> options,
      Function(String) onSelected,
      String? selectedValue,
      Map<String, String>? subtitles,
      double screenWidth,
      ) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        int maxVisibleOptions = 6;
        double boxHeight = options.length <= maxVisibleOptions
            ? options.length * 48.0
            : maxVisibleOptions * 48.0;

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: button.size.width * 0.9,
            decoration: BoxDecoration(
              color: Color(0xFF0A2A5E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                child: Column(
                  children: options.map((String value) {
                    bool isSelected = value == selectedValue;
                    bool isPlaceholder = value == "Highest Rank Attained" ||
                        value == "Status of Last Promotion" ||
                        value == "Choose Retirement Mode" ||
                        value == "Choose Longevity Pay";

                    return Material(
                      color: isSelected ? Colors.transparent : Colors.transparent,
                      child: GestureDetector(
                        onTap: isPlaceholder
                            ? null
                            : () {
                          onSelected(value);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.yellow
                                      : isPlaceholder
                                      ? Colors.grey
                                      : Colors.white,
                                  fontWeight: isSelected ? FontWeight.normal : FontWeight.normal,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                              if (subtitles != null && subtitles.containsKey(value))
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    '(${subtitles[value]})',
                                    style: TextStyle(
                                      color: isSelected ? Colors.white54.withOpacity(0.9) : Colors.white54,
                                      fontSize: screenWidth * 0.03,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }
}