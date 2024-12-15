//  correct code

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:plant_care_app/view/widgets/custom_card.dart';
// import 'package:plant_care_app/view_model/task_view_model.dart';
// import 'package:provider/provider.dart';

// class HomeScreenContent extends StatelessWidget {
//   const HomeScreenContent({super.key});

//   void _showAddTaskBottomSheet(BuildContext context) {
//     final TextEditingController taskController = TextEditingController();

//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: EdgeInsets.only(
//               top: 16,
//               left: 16,
//               right: 16,
//               bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Add Task',
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: taskController,
//                 decoration: InputDecoration(
//                   labelText: 'Task Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (taskController.text.isNotEmpty) {
//                       Provider.of<TaskViewModel>(context, listen: false)
//                           .addTask(taskController.text);
//                       Navigator.pop(context);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromRGBO(62, 102, 24, 1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'Add Task',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TaskViewModel>(
//       builder: (context, taskModel, child) {
//         return Scaffold(
//           backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
//           body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Hello Shreyash!',
//                     style: GoogleFonts.poppins(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // Weekly Plant Health Card
//                   CustomCard(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Weekly Plant Health',
//                             style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const CircleAvatar(
//                                         radius: 5,
//                                         backgroundColor: Colors.green,
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         'Water',
//                                         style: GoogleFonts.jost(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Text(
//                                     '5/7 Days',
//                                     style: GoogleFonts.jost(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       color:
//                                           const Color.fromRGBO(48, 48, 48, 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(width: 15),
//                               Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const CircleAvatar(
//                                         radius: 5,
//                                         backgroundColor: Colors.blue,
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         'Fertilizer',
//                                         style: GoogleFonts.jost(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Text(
//                                     '5/7 Days',
//                                     style: GoogleFonts.jost(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       color:
//                                           const Color.fromRGBO(48, 48, 48, 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Care Schedule',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   // Today's Tasks
//                   CustomCard(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Today's tasks",
//                             style: GoogleFonts.poppins(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           taskModel.tasks.isEmpty
//                               ? const Text('No tasks today')
//                               : ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: taskModel.tasks.length,
//                                   itemBuilder: (context, index) {
//                                     final task = taskModel.tasks[index];
//                                     return ListTile(
//                                       title: Text(
//                                         task,
//                                         style: GoogleFonts.jost(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                       trailing: IconButton(
//                                         icon: const Icon(Icons.delete),
//                                         onPressed: () {
//                                           taskModel.deleteTask(index);
//                                         },
//                                       ),
//                                     );
//                                   },
//                                 ),
//                           ListTile(
//                             leading: const Icon(Icons.add_circle_outline,
//                                 color: Color.fromRGBO(62, 102, 24, 1)),
//                             title: Text(
//                               'Add Task',
//                               style: GoogleFonts.jost(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                                 color: const Color.fromRGBO(62, 102, 24, 1),
//                               ),
//                             ),
//                             onTap: () => _showAddTaskBottomSheet(context),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // My Environment Section
//                   Text(
//                     'My Environment',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   CustomCard(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Austin, Texas',
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   const Text('24°C (75°F)  •  82%'),
//                                 ],
//                               ),
//                               const Icon(Icons.info_outline,
//                                   color: Colors.grey),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           const Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('2.9 m/s'),
//                               Text('3 to 7.5 kWh/m²'),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

///Most Correct Code
///
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:plant_care_app/view/widgets/custom_card.dart';
// import 'package:provider/provider.dart';
// import 'package:plant_care_app/view_model/task_view_model.dart';

// class HomeScreenContent extends StatelessWidget {
//   const HomeScreenContent({super.key});

//   void _showAddTaskBottomSheet(BuildContext context) {
//     final TextEditingController taskController = TextEditingController();

//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: EdgeInsets.only(
//               top: 16,
//               left: 16,
//               right: 16,
//               bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Add Task',
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: taskController,
//                 decoration: InputDecoration(
//                   labelText: 'Task Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (taskController.text.isNotEmpty) {
//                       Provider.of<TaskViewModel>(context, listen: false)
//                           .addTask(taskController.text);
//                       Navigator.pop(context);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromRGBO(62, 102, 24, 1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'Add Task',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TaskViewModel>(builder: (context, taskModel, child) {
//       return Scaffold(
//         backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Hello Shreyash!',
//                   style: GoogleFonts.poppins(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 Text(
//                   'Weekly Plant Health',
//                   style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 CustomCard(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       children: [
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 const CircleAvatar(
//                                   radius: 5,
//                                   backgroundColor: Colors.green,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   'Water',
//                                   style: GoogleFonts.jost(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               '5/7 Days',
//                               style: GoogleFonts.jost(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: const Color.fromRGBO(48, 48, 48, 1),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(width: 15),
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 const CircleAvatar(
//                                   radius: 5,
//                                   backgroundColor: Colors.blue,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   'Fertilizer',
//                                   style: GoogleFonts.jost(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               '5/7 Days',
//                               style: GoogleFonts.jost(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: const Color.fromRGBO(48, 48, 48, 1),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "Today's tasks",
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 CustomCard(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         taskModel.tasks.isEmpty
//                             ? const Text('No tasks today')
//                             : ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: taskModel.tasks.length,
//                                 itemBuilder: (context, index) {
//                                   final task = taskModel.tasks[index];
//                                   return ListTile(
//                                     title: Text(
//                                       task.title,
//                                       style: GoogleFonts.jost(
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                     trailing: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Checkbox(
//                                           activeColor: Colors.green,
//                                           value: task.isDone,
//                                           onChanged: (bool? newValue) {
//                                             if (newValue != null) {
//                                               Provider.of<TaskViewModel>(
//                                                       context,
//                                                       listen: false)
//                                                   .toggleTaskCompletion(index);
//                                             }
//                                           },
//                                         ),
//                                         IconButton(
//                                           icon: const Icon(Icons.delete),
//                                           onPressed: () {
//                                             Provider.of<TaskViewModel>(context,
//                                                     listen: false)
//                                                 .deleteTask(index);
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                         ListTile(
//                           leading: const Icon(Icons.add_circle_outline,
//                               color: Color.fromRGBO(62, 102, 24, 1)),
//                           title: Text(
//                             'Add Task',
//                             style: GoogleFonts.jost(
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold,
//                               color: const Color.fromRGBO(62, 102, 24, 1),
//                             ),
//                           ),
//                           onTap: () => _showAddTaskBottomSheet(context),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'My Environment',
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 CustomCard(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Austin, Texas',
//                                   style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 const Text('24°C (75°F)  •  82%'),
//                               ],
//                             ),
//                             const Icon(Icons.info_outline, color: Colors.grey),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('2.9 m/s'),
//                             Text('3 to 7.5 kWh/m²'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_care_app/view/widgets/custom_card.dart';
import 'package:plant_care_app/view_model/task_view_model.dart';
import 'package:plant_care_app/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  void _showAddTaskBottomSheet(BuildContext context) {
    final TextEditingController taskController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  labelText: 'Task Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      Provider.of<TaskViewModel>(context, listen: false)
                          .addTask(taskController.text);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(62, 102, 24, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Add Task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Fetch weather for a default city
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherViewModel>(context, listen: false)
          .fetchWeather('Pune');
    });

    return Consumer2<TaskViewModel, WeatherViewModel>(
      builder: (context, taskModel, weatherModel, child) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Shreyash!',
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    // Weekly Plant Health Section
                    Text(
                      'Weekly Plant Health',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    CustomCard(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                        radius: 5,
                                        backgroundColor: Colors.green),
                                    const SizedBox(width: 8),
                                    Text('Water',
                                        style: GoogleFonts.jost(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                Text('5/7 Days',
                                    style: GoogleFonts.jost(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            const SizedBox(width: 15),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                        radius: 5,
                                        backgroundColor: Colors.blue),
                                    const SizedBox(width: 8),
                                    Text('Fertilizer',
                                        style: GoogleFonts.jost(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                Text('5/7 Days',
                                    style: GoogleFonts.jost(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Today's Tasks Section
                    Text(
                      "Today's tasks",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CustomCard(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            taskModel.tasks.isEmpty
                                ? const Text('No tasks today')
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: taskModel.tasks.length,
                                    itemBuilder: (context, index) {
                                      final task = taskModel.tasks[index];
                                      return ListTile(
                                        title: Text(task.title,
                                            style:
                                                GoogleFonts.jost(fontSize: 17)),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Checkbox(
                                              activeColor: Colors.green,
                                              value: task.isDone,
                                              onChanged: (bool? newValue) {
                                                if (newValue != null) {
                                                  taskModel
                                                      .toggleTaskCompletion(
                                                          index);
                                                }
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () =>
                                                  taskModel.deleteTask(index),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
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
                              onTap: () => _showAddTaskBottomSheet(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // My Environment Section
                    Text(
                      'My Environment',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CustomCard(
                      child: weatherModel.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : weatherModel.weather == null
                              ? const Text('Failed to fetch weather data')
                              : Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    weatherModel
                                                        .weather!.cityName,
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  const SizedBox(
                                                    width: 250,
                                                  ),
                                                  const Icon(Icons.info_outline,
                                                      color: Colors.grey),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                'Temp: ${weatherModel.weather!.temperature}°C          Humidity:  ${weatherModel.weather!.humidity}%',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Wind Speed: ${weatherModel.weather!.windSpeed} m/s'),
                                    ],
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
