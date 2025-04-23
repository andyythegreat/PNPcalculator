import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComputeScreen extends StatelessWidget {
  final double benefits;
  final double monthlyPension;
  final double gratuity;
  final double lumpSum;

  const ComputeScreen({
    super.key,
    required this.benefits,
    required this.monthlyPension,
    required this.gratuity,
    required this.lumpSum,
  });

  String formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat('#,###.00');
    return 'Php ${formatter.format(amount)}';
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                          const SizedBox(width: 4),
                          const Text('Back', style: TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Main Content
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
                            'Calculation\nResults',
                            style: TextStyle(fontSize: 24, color: Colors.white, height: 1.2),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      _buildResultItem(
                        context: context,
                        label: 'Monthly Pension:',
                        value: formatCurrency(monthlyPension),
                      ),

                      if (gratuity > 0) ...[
                        SizedBox(height: screenHeight * 0.03),
                        _buildResultItem(
                          context: context,
                          label: '1 Year Gratuity:',
                          value: formatCurrency(gratuity),
                        ),
                      ],

                      SizedBox(height: screenHeight * 0.03),

                      _buildResultItem(
                        context: context,
                        label: 'Lumpsum:',
                        value: formatCurrency(lumpSum),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      _buildResultItem(
                        context: context,
                        label: 'Commutation of Accrued Leave:',
                        value: formatCurrency(benefits),
                        isLongText: true,
                      ),

                      SizedBox(height: screenHeight * 0.03),
                    ],
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
                      color: Colors.white30,
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

  Widget _buildResultItem({
    required BuildContext context,
    required String label,
    required String value,
    bool isLongText = false,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final resultItemHeight = screenHeight * 0.12;

    return Container(
      width: double.infinity,
      height: resultItemHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: isLongText
            ? SingleChildScrollView(
          child: _buildTextContent(context, label, value),
        )
            : _buildTextContent(context, label, value),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, String label, String value) {
    double fontSizeLabel = 13 + (MediaQuery.of(context).size.width * 0.01);
    double fontSizeValue = 20 + (MediaQuery.of(context).size.width * 0.01);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: fontSizeLabel,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSizeValue,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}