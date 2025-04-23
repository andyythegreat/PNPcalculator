import "package:flutter/material.dart";
import "calcu.dart";

class OptionalScreen extends StatefulWidget {
  const OptionalScreen({super.key});

  @override
  State<OptionalScreen> createState() => _AssistScreenState();
}

class _AssistScreenState extends State<OptionalScreen> {
  String? selectedYearOfBirth;
  String? selectedMonthOfBirth;
  String? selectedDayOfBirth;
  String? selectedEnteredServiceYear;
  String? selectedEnteredServiceMonth;
  String? selectedEnteredServiceDay;

  bool isSubmitAttempted = false;
  String? resultMessage;

  String? calculateServiceDurationExcludingWeekends() {
    if (selectedYearOfBirth != null &&
        selectedMonthOfBirth != null &&
        selectedDayOfBirth != null &&
        selectedEnteredServiceYear != null &&
        selectedEnteredServiceMonth != null &&
        selectedEnteredServiceDay != null) {

      // Parse the Entered Service Date
      DateTime enteredServiceDate = DateTime(
        int.parse(selectedYearOfBirth!),
        _monthStringToInt(selectedMonthOfBirth!),
        int.parse(selectedDayOfBirth!),
      );

      // Parse the Retirement Date (when the user wants to retire)
      DateTime retirementDate = DateTime(
        int.parse(selectedEnteredServiceYear!),
        _monthStringToInt(selectedEnteredServiceMonth!),
        int.parse(selectedEnteredServiceDay!),
      );

      if (retirementDate.isBefore(enteredServiceDate)) {
        return "Retirement date is before service start.";
      }

      // Count total weekdays in the range (including both start and retirement date)
      int totalWeekdays = 0;
      // Use <= retirementDate to include the retirement day if desired.
      for (DateTime current = enteredServiceDate;
      current.isBefore(retirementDate) || current.isAtSameMomentAs(retirementDate);
      current = current.add(Duration(days: 1))) {
        if (current.weekday != DateTime.saturday && current.weekday != DateTime.sunday) {
          totalWeekdays++;
        }
      }

      int years = totalWeekdays ~/ 260;
      int remainingDays = totalWeekdays % 260;
      int months = remainingDays ~/ 22;
      int days = remainingDays % 22;

      return "$years Year${years == 1 ? '' : 's'} / "
          "$months Month${months == 1 ? '' : 's'} / "
          "$days Day${days == 1 ? '' : 's'}";
    }
    return null;
  }

  int _monthStringToInt(String month) {
    switch (month) {
      case 'January': return 1;
      case 'February': return 2;
      case 'March': return 3;
      case 'April': return 4;
      case 'May': return 5;
      case 'June': return 6;
      case 'July': return 7;
      case 'August': return 8;
      case 'September': return 9;
      case 'October': return 10;
      case 'November': return 11;
      case 'December': return 12;
      default: return 1;
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.arrow_back, color: Colors.white, size: 20),
                          SizedBox(width: 4),
                          Text('Back', style: TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calculate, color: Colors.white, size: screenWidth * 0.15),
                          const SizedBox(width: 8),
                          Container(height: screenHeight * 0.08, width: 2, color: Colors.white),
                          const SizedBox(width: 12),
                          const Text(
                            'Optional',
                            style: TextStyle(fontSize: 24, color: Colors.white, height: 1.2),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'When did you enter police service?',
                          style: TextStyle(fontSize: 16, color: Colors.white, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildDropdownField(
                        List.generate(2025 - 1900 + 1, (index) => (2025 - index).toString()),
                        selectedYearOfBirth,
                            (value) => setState(() => selectedYearOfBirth = value),
                        'Select Entered Service Year',
                        screenWidth,
                      ),
                      const SizedBox(height: 12),
                      _buildDropdownField(
                        ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                        selectedMonthOfBirth,
                            (value) => setState(() => selectedMonthOfBirth = value),
                        'Select Entered Service Month',
                        screenWidth,
                      ),
                      const SizedBox(height: 12),
                      _buildDropdownField(
                        List.generate(31, (index) => (index + 1).toString()),
                        selectedDayOfBirth,
                            (value) => setState(() => selectedDayOfBirth = value),
                        'Select Entered Service Day',
                        screenWidth,
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'When will you want to retire?',
                          style: TextStyle(fontSize: 16, color: Colors.white, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildDropdownField(
                        List.generate(2025 - 1900 + 1, (index) => (2025 - index).toString()),
                        selectedEnteredServiceYear,
                            (value) => setState(() => selectedEnteredServiceYear = value),
                        'Select Retirement Year',
                        screenWidth,
                      ),
                      const SizedBox(height: 12),
                      _buildDropdownField(
                        ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                        selectedEnteredServiceMonth,
                            (value) => setState(() => selectedEnteredServiceMonth = value),
                        'Select Retirement Month',
                        screenWidth,
                      ),
                      const SizedBox(height: 12),
                      _buildDropdownField(
                        List.generate(31, (index) => (index + 1).toString()),
                        selectedEnteredServiceDay,
                            (value) => setState(() => selectedEnteredServiceDay = value),
                        'Select Retirement Day',
                        screenWidth,
                      ),
                      const SizedBox(height: 20),
                      if (resultMessage != null)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            resultMessage!,
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isSubmitAttempted = true;
                            });
                            if (selectedYearOfBirth == null || selectedYearOfBirth == 'Select Year') {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select Year of Birth')));
                              return;
                            }
                            if (selectedMonthOfBirth == null || selectedMonthOfBirth == 'Select Month') {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select Month of Birth')));
                              return;
                            }
                            if (selectedDayOfBirth == null || selectedDayOfBirth == 'Select Day') {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select Day of Birth')));
                              return;
                            }
                            if (selectedEnteredServiceYear == null || selectedEnteredServiceYear == 'Select Year') {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select Entered Service Year')));
                              return;
                            }
                            if (selectedEnteredServiceMonth == null || selectedEnteredServiceMonth == 'Select Month') {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select Entered Service Month')));
                              return;
                            }
                            if (selectedEnteredServiceDay == null || selectedEnteredServiceDay == 'Select Day') {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select Entered Service Day')));
                              return;
                            }
                            String? result = calculateServiceDurationExcludingWeekends();
                            if (result != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CalcuScreen(lengthOfService: result),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill out all the fields.')));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A2A5E),
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 50),
                            fixedSize: Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.white24, width: 1),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text('Done!', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(
                    'Copyright 2016-2022\nPhilippine National Police\nInformation Technology Management Service\nwww.itms.pnp.gov.ph',
                    style: const TextStyle(
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

  Widget _buildDropdownField(List<String> options, String? selectedValue, Function(String) onSelected, String title, double screenWidth) {
    String placeholder = "Select $title";
    if (!options.contains(placeholder)) {
      options.insert(0, placeholder);
    }
    bool isValid = selectedValue != null && selectedValue != placeholder;
    Color borderColor = isSubmitAttempted && !isValid ? Colors.red : Colors.white24;

    return Container(
      height: 50,
      width: screenWidth * 0.9,
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
              _showCustomMenu(context, options, onSelected, selectedValue, screenWidth, title);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectedValue ?? placeholder,
                      style: TextStyle(
                        color: selectedValue == null || selectedValue == placeholder ? Colors.white : Colors.white,
                        fontSize: screenWidth * 0.035,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
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

  void _showCustomMenu(BuildContext context, List<String> options, Function(String) onSelected, String? selectedValue, double screenWidth, String title) {
    String placeholder = "Select $title";
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: screenWidth * 0.9,
            decoration: BoxDecoration(
              color: const Color(0xFF0A2A5E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                child: Column(
                  children: options.map((String value) {
                    bool isSelected = value == selectedValue;
                    bool isPlaceholder = value == placeholder;
                    return Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: isPlaceholder ? null : () {
                          onSelected(value);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Text(
                            value,
                            style: TextStyle(
                              color: isSelected ? Colors.yellow : isPlaceholder ? Colors.grey : Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: screenWidth * 0.035,
                            ),
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
    );
  }
}