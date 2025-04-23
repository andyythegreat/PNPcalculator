import 'package:flutter/material.dart';

void main() {
  runApp(const TransferScreen());
}

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingFactor = screenWidth < 600 ? 12.0 : 24.0;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF07123C), Color(0xFF3B64D8)],
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
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text('Back', style: TextStyle(color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // TITLES FOR EACH REQUIREMENTS
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(paddingFactor),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildHeader(),

                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _buildTextTitle('REQUIMENTS FOR TRANSFER OF PENSION'),
                                  _buildRequirements(),
                                  const SizedBox(height: 20),

                                  _buildTextTitle('Sub-requirements for issuance of CLB:'),
                                  _buildLegalBeneficiaryRequirements(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildFooter(screenHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF0A3D91),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/pnp_logo.png', height: 40, width: 40),
          const SizedBox(width: 10),
          const Text(
            'PHILIPPINE NATIONAL POLICE',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(width: 10),
          Image.asset('images/prbs_logo.png', height: 40, width: 40),
        ],
      ),
    );
  }

  // SECTION TITLE
  Widget _buildTextTitle(String title, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
        textAlign: TextAlign.center,
      ),
    );
  }

  // FOOTER
  Widget _buildFooter(double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: const Text(
        "Copyright 2016-2022\nPhilippine National Police\nInformation Technology Management Service\nwww.itms.pnp.gov.ph",
        style: TextStyle(fontFamily: 'Roboto', color: Colors.white70, fontSize: 10, height: 1.5),
        textAlign: TextAlign.center,
      ),
    );
  }

  // REQUIREMENTS LIST
  Widget _buildRequirements() {
    return Column(
      children: [
        _buildNumberedItem(1, 'Retirement Order'),
        _buildNumberedItem(2, 'Service Record from RMD, DPRM', hasBackground: true),
        _buildNumberedItem(3, 'Promotion Order'),
        _buildNumberedItem(4, 'Statement of Assets and Liabilities Net worth (SALN)', hasBackground: true),
        _buildNumberedItem(5, 'Certificate of Last Payment'),
        _buildNumberedItem(6, 'Death Certificate from PSA', hasBackground: true),
        _buildNumberedItem(7, 'Certificate of Legal Beneficiary from PRBS'),
        _buildNumberedItem(8, 'Decree of Entitlement and Distribution from PRBS', note: '* CLB - Sub-Requirement for issuance of DED:', hasBackground: true),
      ],
    );
  }

  Widget _buildLegalBeneficiaryRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        _buildTextTitle('IF PNP personnel is MARRIED:', color: Colors.red),
        const SizedBox(height: 1),
        _buildLetteredItem('a', 'Advisory on Marriages of both husband and wife from Phil Statistics Authority (PSA)'),
        _buildLetteredItem('b', 'Marriage Contract from PSA', hasBackground: true),
        _buildLetteredItem('c', 'Birth Certificate of Husband and Wife from PSA'),
        _buildLetteredItem('d', 'Birth Certification of Minor Children from PSA'),

        const SizedBox(height: 20),

        _buildTextTitle('If PNP personnel is SINGLE:', color: Colors.red),
        const SizedBox(height: 1),
        _buildLetteredItem('a', 'Certificate of Singleness from PSA'),
        _buildLetteredItem('b', 'Marriage Contract of Parents from PSA', hasBackground: true),
        _buildLetteredItem('c', 'Birth Certificate of PNP personnel from PSA'),
      ],
    );
  }

  Widget _buildNumberedItem(int number, String text, {String? note, bool hasBackground = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: hasBackground ? Colors.grey.shade200 : Colors.transparent,
        border: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 14),
                ),
                if (note != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    note,
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // To Handle Lettered Items
  Widget _buildLetteredItem(String letter, String text, {String? note, bool hasBackground = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: hasBackground ? Colors.transparent : Colors.transparent,
        border: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$letter. ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 14),
                ),
                if (note != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    note,
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
