import 'package:flutter/material.dart';

class DonateBloodScreen extends StatefulWidget {
  @override
  _DonateBloodScreenState createState() => _DonateBloodScreenState();
}

class _DonateBloodScreenState extends State<DonateBloodScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Blood'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fill in your details to become a donor:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Blood Group Dropdown
              Text('Blood Group:', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                    .map((group) => DropdownMenuItem(
                          value: group,
                          child: Text(group),
                        ))
                    .toList(),
                onChanged: (value) {
                  // Handle blood group selection
                },
                hint: Text('Select Blood Group'),
              ),
              SizedBox(height: 20),
              // Last Donation Date
              Text('Last Donation Date:', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: _selectedDate == null
                      ? 'Select a date'
                      : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              // Location
              Text('Location:', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your location',
                ),
              ),
              SizedBox(height: 20),
              // Contact Information
              Text('Contact Information:', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name',
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your phone number',
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email (optional)',
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20),
              // Health Notes
              Text('Health Notes (optional):', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Mention any health conditions or medications',
                ),
              ),
              SizedBox(height: 30),
              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
