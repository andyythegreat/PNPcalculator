import 'package:flutter/material.dart';

class FontSizeCalculator {
  static double getResponsiveSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return baseSize * 0.85;
    if (screenWidth < 480) return baseSize;
    if (screenWidth < 600) return baseSize * 1.1;
    return baseSize * 1.2;
  }
}

void main() {
  runApp(const ProcessScreen());
}

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingFactor = screenWidth < 600 ? 16.0 : 24.0;

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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text('Back',
                                style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Main Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingFactor,
                      vertical: 16,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth > 600 ? 600 : screenWidth * 0.95,
                        ),
                        child: Column(
                          children: [
                            Container(
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
                                  Image.asset(
                                    'images/pnp_logo.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'PHILIPPINE NATIONAL POLICE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Image.asset(
                                    'images/prbs_logo.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      // TITLE
                                      Center(
                                        child: Text(
                                          'PROCESS',
                                          style: TextStyle(
                                            fontSize: FontSizeCalculator.getResponsiveSize(context, 18),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Funding and Crediting of Retirement Benefits to PNP ATM Pension System',
                                        style: TextStyle(
                                          fontSize: FontSizeCalculator.getResponsiveSize(context, 13),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                      const SizedBox(height: 16),

                                      // PROCESS TABLE
                                      Table(
                                        border: TableBorder.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                        columnWidths: const {
                                          0: FlexColumnWidth(1.4),
                                          1: FlexColumnWidth(2.5),
                                          2: FlexColumnWidth(3),
                                        },
                                        children: [
                                          _buildTableRow(
                                            ['STEPS', 'OFFICE', 'FUNCTION'],
                                            isHeader: true,
                                          ),
                                          _buildTableRow([
                                            '1',
                                            'PRBS',
                                            'Consolidation of Complete documents and preparation of DVs and computation sheet'
                                          ]),
                                          _buildTableRow([
                                            '2',
                                            'Accounting Division',
                                            'Check entitlement, computation, deduction and completeness of requirement'
                                          ]),
                                          _buildTableRow([
                                            '3',
                                            'Management Division',
                                            'Pre-audit'
                                          ]),
                                          _buildTableRow([
                                            '4',
                                            'RPBS, Fiscal Division',
                                            'Batching and preparation of Fund Request to DBM thru DILG'
                                          ]),
                                          _buildTableRow([
                                            '5',
                                            'DILG',
                                            'Endorses to DBM'
                                          ]),
                                          _buildTableRow([
                                            '6',
                                            'DBM',
                                            'Approval and Fund Release'
                                          ]),
                                          _buildTableRow([
                                            '7',
                                            'DILG',
                                            'Endorses to PNP the availability of fund as approved and released by DBM'
                                          ]),
                                          _buildTableRow([
                                            '8',
                                            'RPBS, FD, ODC',
                                            'Preparation of NFA and processing of DVs'
                                          ]),
                                          _buildTableRow([
                                            '9',
                                            'NCA Section, Budget Division, OCD',
                                            'Charging of NCA'
                                          ]),
                                          _buildTableRow([
                                            '10',
                                            'AD, DC',
                                            'Issuance of Journal Entry Voucher(JEV)'
                                          ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              width: double.infinity,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0A3D91),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'images/bagong_ph_logo.png',
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Footer
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: const Text(
                    "Copyright 2016-2022\nPhilippine National Police\nInformation Technology Management Service\nwww.itms.pnp.gov.ph",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white70,
                      fontSize: 10,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Table Controller
  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? Colors.grey.shade200 : Colors.white,
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cells[0],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cells[1],
              textAlign: isHeader ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cells[2],
              textAlign: isHeader ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
