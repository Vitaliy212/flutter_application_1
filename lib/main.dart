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
          _buildMuscleHeatPanel(),
          _buildSkinFlowPanel(),
        ],
      ),
    );
  }

  // Вкладка: Sweat evaporation
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

  // Вкладка: Muscle heat production
  Widget _buildMuscleHeatPanel() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildParameterSection('Central temperature', 155, 0.25, 'kcal/h °C'),
          SizedBox(height: 16),
          _buildParameterSection('Skin temperature', 47, 0.5, 'kcal/h °C'),
          SizedBox(height: 16),
          _buildParameterSection(
            'Skin temperature derivative',
            0,
            0,
            'kcal/h °C',
          ),
          SizedBox(height: 16),
          _buildParameterSection('Outer heat flow', 0, 0, 'kcal/h'),
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

  // Вкладка: Skin flow
  Widget _buildSkinFlowPanel() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Central and skin temperatures',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Central threshold, h11', '0.05'),
              ),
              SizedBox(width: 16),
              Expanded(child: _buildTextField('Skin threshold, h12', '0.1')),
            ],
          ),
          SizedBox(height: 16),
          _buildSensitivityBlock(
            title: 'Id > h11, Id > h12',
            centralSensitivity: 200,
            skinSensitivity: 10,
            unit: 'l/h °C',
          ),
          SizedBox(height: 16),
          _buildSensitivityBlock(
            title: 'Id < h11, Id > h12',
            centralSensitivity: 50,
            skinSensitivity: 10,
            unit: 'l/h °C',
          ),
          SizedBox(height: 16),
          _buildParameterSection(
            'Skin temperature derivative',
            0.01,
            30,
            'l/°C',
          ),
          SizedBox(height: 16),
          _buildParameterSection('Outer heat flow', 0, 0, 'l/kcal'),
          SizedBox(height: 16),
          Text(
            'Skin blood flow, fls',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildTextField('Maximum fls', '480')),
              SizedBox(width: 16),
              Expanded(child: _buildTextField('Minimum fls', '3')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Checkbox(value: true, onChanged: (bool? value) {}),
              Text('Head skin flow changes'),
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

  Widget _buildSensitivityBlock({
    required String title,
    required double centralSensitivity,
    required double skinSensitivity,
    required String unit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                'Central sensitivity',
                centralSensitivity.toString(),
              ),
            ),
            SizedBox(width: 16),
            Text(unit),
            SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                'Skin sensitivity',
                skinSensitivity.toString(),
              ),
            ),
            SizedBox(width: 16),
            Text(unit),
          ],
        ),
      ],
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
            Text('°C/h'),
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
