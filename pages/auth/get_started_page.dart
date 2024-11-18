import 'package:bulkfitness/pages/first_page.dart';
import 'package:flutter/material.dart';
import '../../components/my_button.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  String _selectedSex = 'M';
  String? _selectedActivityLevel;
  final _heightController = TextEditingController();
  final _currentWeightController = TextEditingController();
  final _goalWeightController = TextEditingController();

  final List<String> _activityLevels = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Extra Active'
  ];

  @override
  void dispose() {
    _heightController.dispose();
    _currentWeightController.dispose();
    _goalWeightController.dispose();
    super.dispose();
  }

  void _getStarted() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FirstPage(),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String suffix) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[800]!,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffix: Text(
                  suffix,
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[400],
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false, // Prevent resizing when keyboard appears
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          // Wrap with a Stack to handle keyboard visibility
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  const Text(
                    'Welcome to Bulk!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tell us about yourself',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Form section in a scrollable container
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Height section
                          _buildLabel('Current Height'),
                          const SizedBox(height: 4),
                          _buildTextField(_heightController, 'cm'),
                          const SizedBox(height: 16),

                          // Sex section
                          _buildLabel('Sex'),
                          const SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () => setState(() => _selectedSex = 'M'),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedSex == 'M'
                                          ? Colors.white
                                          : Colors.grey[800],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'M',
                                      style: TextStyle(
                                        color: _selectedSex == 'M'
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() => _selectedSex = 'F'),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedSex == 'F'
                                          ? Colors.white
                                          : Colors.grey[800],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'F',
                                      style: TextStyle(
                                        color: _selectedSex == 'F'
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Weight section
                          _buildLabel('Current Weight'),
                          const SizedBox(height: 4),
                          _buildTextField(_currentWeightController, 'kg'),
                          const SizedBox(height: 16),

                          // Goal Weight section
                          _buildLabel('Goal Weight'),
                          const SizedBox(height: 4),
                          _buildTextField(_goalWeightController, 'kg'),
                          const SizedBox(height: 16),

                          // Activity Level section
                          _buildLabel('Activity Level'),
                          const SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[800]!,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedActivityLevel,
                              hint: Text(
                                'Select',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                              isExpanded: true,
                              dropdownColor: Colors.grey[900],
                              underline: Container(),
                              style: const TextStyle(color: Colors.white),
                              items: _activityLevels
                                  .map((level) => DropdownMenuItem(
                                value: level,
                                child: Text(level),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedActivityLevel = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  // Button section
                  MyButton(
                    onTap: _getStarted,
                    text: "GET STARTED",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}