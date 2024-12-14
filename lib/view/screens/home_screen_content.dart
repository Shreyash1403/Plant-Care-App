import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_care_app/view/widgets/custom_card.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Shreyash!',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Weekly Plant Health
              CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Plant Health',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.green,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Water',
                                    style: GoogleFonts.jost(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '5/7 Days',
                                style: GoogleFonts.jost(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(48, 48, 48, 1),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.blue,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Fertilizer',
                                    style: GoogleFonts.jost(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '5/7 Days',
                                style: GoogleFonts.jost(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(48, 48, 48, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Care Schedule
              Text(
                'Care Schedule',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's task",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.circle_outlined),
                        title: Text(
                          'Fertilize Spider Plant',
                          style: GoogleFonts.jost(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.circle_outlined),
                        title: Text(
                          'Mist Fern for Humidity',
                          style: GoogleFonts.jost(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.circle_outlined),
                        title: Text(
                          'Prune Rose Bush',
                          style: GoogleFonts.jost(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.add_circle_outline,
                            color: Color.fromRGBO(62, 102, 24, 1)),
                        title: Text(
                          'Add Task',
                          style: GoogleFonts.jost(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(62, 102, 24, 1),
                          ),
                        ),
                        onTap: () {
                          // Add task action
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // My Environment
              Text(
                'My Environment',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Austin, Texas',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Text('24°C (75°F)  •  82%'),
                            ],
                          ),
                          const Icon(Icons.info_outline, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('2.9 m/s'),
                          Text('3 to 7.5 kWh/m²'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
