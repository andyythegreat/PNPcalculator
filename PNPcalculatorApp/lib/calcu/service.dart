import 'package:flutter/material.dart';
import 'assist.dart';

class ServiceScreen extends StatefulWidget {
  final Function(String, String, String) onDone;

  const ServiceScreen({Key? key, required this.onDone}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String? selectedYears;
  String? selectedMonths;
  String? selectedDays;

  // Flag to Track if Submit was Attempted (REQUIRED)
  bool isSubmitAttempted = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                            'Back',
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

              // Length of Service Header
              SizedBox(height: screenHeight * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.calculate,
                        color: Colors.white,
                        size: screenWidth * 0.15,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      height: screenHeight * 0.08,
                      width: 2,
                      color: Colors.white,
                    ),
                    SizedBox(width: 12),
                    const Text(
                      'Length of\nService',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              // Instruction Text
              SizedBox(height: screenHeight * 0.02),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Carefully Provide the Length of Service',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Height Spacing
              SizedBox(height: screenHeight * 0.04),
              _buildDropdownFieldYears(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildDropdownFieldMonths(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildDropdownFieldDays(screenWidth),

              // Done Button
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Set Flag to Show Validation Errors (REQUIRED)
                    setState(() {
                      isSubmitAttempted = true;
                    });

                    // REQUIRED DROP-DOWN
                    if (selectedYears == null || selectedYears == 'Select Year') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select Year')),
                      );
                      return;
                    }

                    if (selectedMonths == null || selectedMonths == 'Select Month') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select Month')),
                      );
                      return;
                    }
                    if (selectedDays == null || selectedDays == 'Select Day') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select Day')),
                      );
                      return;
                    }
                    // Pass the Selected Values Back to the Parent Screen
                    widget.onDone(selectedYears ?? '', selectedMonths ?? '', selectedDays ?? '');
                    Navigator.pop(context);
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
                  child: const Text(
                    'Done!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // Assist Me Section
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34488C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Image.asset(
                              'images/annoucement_logo.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Don't know how to compute for the Length of Service?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AssistScreen()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A2A5E),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white24, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Assist me!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              Expanded(
                child: Container(),
              ),
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


  Widget _buildDropdownFieldYears(double screenWidth) {
    // NUMBER OF YEARS OPTION
    List<String> options = List.generate(50, (index) => (index + 1).toString());

    return _buildDropdownField(options, selectedYears, (value) {
      setState(() {
        selectedYears = value;
      });
    }, 'Year', screenWidth);
  }

  Widget _buildDropdownFieldMonths(double screenWidth) {
    // NUMBER OF MONTHS OPTION
    List<String> options = List.generate(12, (index) => (index + 1).toString());

    return _buildDropdownField(options, selectedMonths, (value) {
      setState(() {
        selectedMonths = value;
      });
    }, 'Month', screenWidth);
  }

  Widget _buildDropdownFieldDays(double screenWidth) {
    // NUMBER OF DAYS OPTION
    List<String> options = List.generate(31, (index) => (index + 1).toString());

    return _buildDropdownField(options, selectedDays, (value) {
      setState(() {
        selectedDays = value;
      });
    }, 'Day', screenWidth);
  }

  Widget _buildDropdownField(List<String> options, String? selectedValue, Function(String) onSelected, String title, double screenWidth) {
    String placeholder = 'Select $title';
    if (!options.contains(placeholder)) {
      options.insert(0, placeholder);
    }

    // !! REQUIRED WARNING FOR YEAR, MONTH AND DAY !!
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
              _showCustomMenu(
                context,
                options,
                onSelected,
                selectedValue,
                screenWidth,
                title,
              );
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
                        color: selectedValue == null || selectedValue == placeholder
                            ? Colors.white
                            : Colors.white,
                        fontSize: screenWidth * 0.035,
                      ),
                      overflow: TextOverflow.ellipsis,
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

  void _showCustomMenu(BuildContext context, List<String> options, Function(String) onSelected, String? selectedValue, double screenWidth, String title) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    String placeholder = 'Select $title';

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                    bool isPlaceholder = value == placeholder;

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
                          child: Text(
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
