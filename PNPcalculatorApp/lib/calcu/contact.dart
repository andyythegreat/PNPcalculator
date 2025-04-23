import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // ONLY AVAILABLE IN PORTRAIT MODE
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ContactScreen());
  });
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF07123C), Color(0xFF3B64D8)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildBackButton(context),
                const SizedBox(height: 10),
                _buildContactHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildContactTable(),
                        _buildServiceFooter(),
                      ],
                    ),
                  ),
                ),
                _buildAppFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Back Button
  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back, color: Colors.white, size: 20),
              SizedBox(width: 4),
              Text('Home', style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  // CONTACT US Top Header
  Widget _buildContactHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(top: 20),
      color: const Color(0xFF0A3D91),
      alignment: Alignment.center,
      child: const Text(
        'CONTACT US',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  // Contact Table
  Widget _buildContactTable() {
    final rows = <Widget>[
      _buildSectionHeader('Main Building Address'),
      _buildBorderedCellRow([
        _buildIconText('PRBS Building, 1234 Roxas Boulevard, Malate, Manila', Icons.location_on),
      ]),
      _buildDualSectionHeader('Phone Support (+63)', 'Toll-Free'),
      _buildBorderedCellRow([
        _buildIconText('2-8876-5432', Icons.phone),
        _buildIconText('1-800-PRBS (7727)', Icons.phone),
      ]),
      _buildSectionHeader('Email Support'),
      _buildBorderedCellRow([
        _buildIconText('support@prbs.ph', Icons.email),
        _buildIconText('info@prbs.ph', Icons.email),
      ]),
      _buildSectionHeader('Support Hours'),
      _buildBorderedCellRow([
        _buildIconText('Monday - Friday:\n8:00 AM - 5:00 PM', Icons.access_time),
        _buildIconText('Saturday:\n8:00 AM - 12:00 PM', Icons.access_time),
      ]),
      _buildSectionHeader('Other Contact Options'),
      _buildBorderedCellRow([
        _buildIconText('prbs.gov.ph', Icons.language),
        _buildIconText('Prbs Pnp', Icons.facebook),
      ]),
      _buildSectionHeader('Hotline Numbers'),
      _buildHotlineRow('0961-899-0928'),
      _buildHotlineRow('0931-064-4316'),
      _buildHotlineRow('0977-714-5263'),
      _buildHotlineRow('0953-413-5924'),
      _buildHotlineRow('8723-0401 local 7551'),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rows,
      ),
    );
  }

  // Service Bottom Header
  Widget _buildServiceFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: const Color(0xFF0A3D91),
      alignment: Alignment.center,
      child: const Text(
        'PNP Retirement and Benefits Administration Service',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  // App Footer
  Widget _buildAppFooter() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Copyright 2016-2022', style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text('Philippine National Police', style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text('Information Technology Management Service', style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text('www.itms.pnp.gov.ph', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  // Contact Rows
  Widget _buildSectionHeader(String title) {
    return Container(
      color: const Color(0xFF002171),
      padding: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildDualSectionHeader(String leftTitle, String rightTitle) {
    return Container(
      color: const Color(0xFF002171),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Center(child: Text(leftTitle, style: _headerStyle))),
          Expanded(child: Center(child: Text(rightTitle, style: _headerStyle))),
        ],
      ),
    );
  }

  Widget _buildBorderedCellRow(List<Widget> cells) {
    return Row(
      children: cells
          .map((cell) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          padding: const EdgeInsets.all(6),
          child: cell,
        ),
      ))
          .toList(),
    );
  }

  Widget _buildHotlineRow(String number) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      padding: const EdgeInsets.symmetric(vertical: 2.8, horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.phone, size: 16),
          const SizedBox(width: 8),
          Text(number, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildIconText(String text, IconData icon) {
    return Row(
        children: [
        Icon(icon, size: 16),
    const SizedBox(width: 6),
    Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
    ],
    );
  }

  TextStyle get _headerStyle => const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
}
