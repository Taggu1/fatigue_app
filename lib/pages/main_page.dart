import 'package:fatigue_predictor_website/domain/fatiuge_data.dart';
import 'package:fatigue_predictor_website/utils.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class FatiguePredictorScreen extends StatefulWidget {
  @override
  _FatiguePredictorScreenState createState() => _FatiguePredictorScreenState();
}

class _FatiguePredictorScreenState extends State<FatiguePredictorScreen> {
  // Input Controllers & Variables
  final _decisionsController = TextEditingController();
  final _switchesController = TextEditingController();
  final _caffeineController = TextEditingController();

  double _hoursAwake = 8.0;
  double _sleepHours = 7.0;
  double _stressLevel = 5.0; // 1 to 10 scale

  String _result = "Enter data and tap Predict";
  bool _isLoading = false;

  void _handlePrediction() async {
    setState(() => _isLoading = true);

    // Create the data object (using the class we defined earlier)
    final data = FatigueData(
      decisionsMade: int.tryParse(_decisionsController.text) ?? 0,
      hoursAwake: _hoursAwake,
      taskSwitches: int.tryParse(_switchesController.text) ?? 0,
      caffeineCups: int.tryParse(_caffeineController.text) ?? 0,
      sleepHours: _sleepHours,
      stressLevel: _stressLevel.toInt(),
    );

    // Call your API service
    final recommendation = await getFatigueRecommendation(data);

    setState(() {
      _result = recommendation;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fatigue Predictor"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildNumericField(
              _decisionsController,
              "Decisions Made",
              Icons.ads_click,
            ),
            _buildNumericField(
              _switchesController,
              "Task Switches",
              Icons.compare_arrows,
            ),
            _buildNumericField(
              _caffeineController,
              "Caffeine (Cups)",
              Icons.coffee,
            ),

            Divider(height: 40),

            _buildSlider(
              "Hours Awake",
              _hoursAwake,
              1,
              24,
              (val) => setState(() => _hoursAwake = val),
            ),
            _buildSlider(
              "Sleep Last Night",
              _sleepHours,
              0,
              12,
              (val) => setState(() => _sleepHours = val),
            ),
            _buildSlider(
              "Stress Level",
              _stressLevel,
              1,
              10,
              (val) => setState(() => _stressLevel = val),
            ),

            SizedBox(height: 30),

            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _handlePrediction,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      child: Text("Predict Recommendation"),
                    ),
                  ),

            SizedBox(height: 30),
            Text(
              _result,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumericField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ${value.toStringAsFixed(1)}"),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt() * 2,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
