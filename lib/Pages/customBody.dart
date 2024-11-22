import 'package:flutter/material.dart';

class customBody extends StatelessWidget {
  const customBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return midBody(screenWidth, screenHeight);
  }

  Column midBody(double screenWidth, double screenHeight) {
    final String introduction = '''
North Somerset Council's CCTV system currently operates a total of 360 cameras of which 309 are Public Space Surveillance cameras with a further 51 cameras which cover internal council properties. The cameras transmit data back to the control room in the Town Hall and are monitored 24 hours a day, 365 days a year by a team of fully trained operators at North Somerset Council's emergency control centre.

The operators have direct radio communication with the police, council enforcement officers, businesses. and street wardens. They deal with emergency out-of-hours calls to the council, lone worker monitoring and provide a dedicated operator for the night-time Carelink service.

The purpose of the CCTV system is to:

• help make the area safe for those people who live, work and trade in it and those who visit North Somerset.
• help to prevent, detect, and reduce crime and disorder in the area.
• reduce the fear of crime and provide reassurance to the public.
• assist in crime prevention, combat terrorism, helping to identify/apprehend/prosecute offenders and to provide the police and the
council with
evidence to take criminal and civil action in the courts.
• assist the local authority in its enforcement and regulatory functions within North Somerset.

The CCTV system throughout North Somerset undergoes an annual privacy impact assessment. The assessment makes sure that CCTV systems are being operated in accordance with the current legislation surrounding data protection. The CCTV operators also make sure the cameras remain fit for the original purpose for which they were installed.

A Data Protection Privacy Assessment on all public space surveillance cameras was carried out on 13th January 2023, the assessment determined that all public space CCTV cameras are fulfilling their original purpose, as detailed in the CCTV System Code of Practice (please see Useful Links).

We have received one complaint since the last assessment on 11 Nov 2021. This was regarding camera DI 57 Baker Street and the concern of intrusion into a property. Following this, the camera has been set up with privacy zones.

The CCTV system has been awarded the Surveillance Camera Commissioner's accreditation which demonstrates compliance with good practice and legislation.
                       
                       
                        ''';

    final String navigation =
        '''1. Select the relevant page (buttons on ribbon above).
2. All the pages contain a date slicer and various drop-down menus.
3. The date slicer cen be moved from side to side to select a time frame or one specific drop-down menus to select a specific Incident Type, Street or Area.
5. Fully expand the date slicer and set drop down menus to 'All' for an overview of 'All' incidents captured by CCTV.
6. The graphs and number of 'Total Incidents' will change with your selections from the date slicer and drop-down menus.
7. To use the Heat Map, hover over the different Wards to see the Ward name and the number of incidents within that Ward. Select the Ward you wish to view - graphs/tabIe/TotaI Incidents will change with your selection.
8. Alternatively use the date slicer and drop-down menus to select a date range/specific date and/or a specific Incident Type or Area,
9. The heat map uses Red, Amber, Green (RAG) rating to show the Wards with high (Red) to low (Green) numbers of incidents caught on CCTV, Grey areas are not covered by CCTV.
10. To focus (zoom in) on a particular graph, hover over the chart title to display a 'Focus Mode' icon ) this will allow you to see the chart in full screen, Click 'Back to Report' to exit focus mode.
11. To clear your selection on a chart, click anywhere within the white of the selected chart.
12.The dashboard is updated monthly (a month in arrears)


''';

    final String usefulLinks = '''
North Somerset Council CCTV
North Somerset Council CCTV code of practice
North Somerset Council CCTV privacy impact statement
Contact us: E mailto:cctv@n-somerset_gov_uk


''';

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          color: Color.fromARGB(255, 53, 145, 195),
                          width: screenWidth * .49,
                          child: Text(' Introduction',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16.0), // Optional: add padding
                        child: Text(
                          introduction,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 70,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                color: Color.fromARGB(255, 53, 145, 195),
                                width: screenWidth * .5,
                                child: Text(' Navigation',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding:
                                  EdgeInsets.all(16.0), // Optional: add padding
                              child: Text(
                                navigation,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                color: Color.fromARGB(255, 53, 145, 195),
                                width: screenWidth * .5,
                                child: Text(' Useful links',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding:
                                  EdgeInsets.all(16.0), // Optional: add padding
                              child: Text(
                                usefulLinks,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomBody(screenWidth, screenHeight),
      ],
    );
  }

  SizedBox bottomBody(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth,
      child: BottomAppBar(
        color: Colors.red,
        child: Column(
          children: [
            Icon(Icons.format_align_center),
            Text('Emergency Box')
          ],
        ),
        height: screenHeight * .1,
      ),
    );
  }
}
