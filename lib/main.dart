import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ThermoregulationScreen(),
    );
  }
}

class ThermoregulationScreen extends StatefulWidget {
  @override
  _ThermoregulationScreenState createState() => _ThermoregulationScreenState();
}

class _ThermoregulationScreenState extends State<ThermoregulationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Thermoregulation'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Sweat evaporation'),
            Tab(text: 'Muscle heat production'),
            Tab(text: 'Skin flow'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildControlPanel(),
          Center(child: Text('Muscle heat production settings...')),
          Center(child: Text('Skin flow settings...')),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildParameterSection('Central temperature', 500, 37.3, 'kcal/h °C'),
          SizedBox(height: 16),
          _buildParameterSection('Skin temperature', 50, 36.5, 'kcal/h °C'),
          SizedBox(height: 16),
          _buildParameterSection(
            'Skin temperature derivative',
            0,
            0,
            'kcal/h °C',
          ),
          SizedBox(height: 16),
          _buildParameterSection('Outer heat flow', 0, 0, 'nd'),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField('Koef. surface', '1')),
              SizedBox(width: 16),
              Expanded(child: _buildTextField('Wettedness', '0.5')),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Cancel')),
              ElevatedButton(onPressed: () {}, child: Text('OK')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParameterSection(
    String title,
    double sensitivity,
    double threshold,
    String unit,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(value: true, onChanged: (bool? value) {}),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildTextField('Sensitivity', sensitivity.toString()),
            ),
            SizedBox(width: 8),
            Text(unit),
            SizedBox(width: 16),
            Expanded(child: _buildTextField('Threshold', threshold.toString())),
            SizedBox(width: 8),
            Text('°C'),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      controller: TextEditingController(text: initialValue),
    );
  }
}
