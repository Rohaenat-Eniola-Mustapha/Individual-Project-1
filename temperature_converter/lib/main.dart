import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverterHome(),
    );
  }
}

class TemperatureConverterHome extends StatefulWidget {
  @override
  _TemperatureConverterHomeState createState() => _TemperatureConverterHomeState();
}

class _TemperatureConverterHomeState extends State<TemperatureConverterHome> {
  // Variables for input and conversion options
  double? _inputValue;
  String _selectedConversion = 'F to C';
  String _result = '';
  List<String> _history = [];

  final TextEditingController _controller = TextEditingController();

  // Conversion Logic
  void _convertTemperature() {
    setState(() {
      if (_inputValue != null) {
        double result;
        if (_selectedConversion == 'F to C') {
          result = (_inputValue! - 32) * 5 / 9;
          _result = '$_inputValue°F = ${result.toStringAsFixed(2)}°C';
        } else {
          result = _inputValue! * 9 / 5 + 32;
          _result = '$_inputValue°C = ${result.toStringAsFixed(2)}°F';
        }
        _history.add(_result);  // Add to history
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for temperature
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
              ),
              onChanged: (value) {
                setState(() {
                  _inputValue = double.tryParse(value);
                });
              },
            ),
            SizedBox(height: 20),
            
            // Radio buttons for conversion selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                Text('F to C'),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                Text('C to F'),
              ],
            ),
            
            // Convert button
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
            
            // Display the result
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 24),
            ),
            
            // Display conversion history
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
