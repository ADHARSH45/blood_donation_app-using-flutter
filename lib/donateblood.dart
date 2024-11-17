import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonateBloodScreen extends StatefulWidget {
  @override
  _DonateBloodScreenState createState() => _DonateBloodScreenState();
}

class _DonateBloodScreenState extends State<DonateBloodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _healthNotesController = TextEditingController();
  String? _bloodGroup;
  DateTime? _lastDonationDate;

  Future<void> _submitDonorData() async {
    if (_formKey.currentState!.validate()) {
      // Ensure the last donation date is more than 3 months ago
      if (_lastDonationDate != null) {
        final currentDate = DateTime.now();
        final difference = currentDate.difference(_lastDonationDate!).inDays;

        if (difference < 90) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'You can donate blood only after 3 months from your last donation.')),
          );
          return;
        }
      }

      // Gather donor data
      final donorData = {
        'name': _nameController.text,
        'bgroup': _bloodGroup,
        'location': _locationController.text,
        'phonenumber': _phoneController.text,
        'email':
            _emailController.text.isNotEmpty ? _emailController.text : null,
        'hnote': _healthNotesController.text,
        'lastdate': _lastDonationDate?.toIso8601String(),
        'createdAt': Timestamp.now(),
      };

      try {
        // Save donor data to Firestore
        await FirebaseFirestore.instance.collection('donor').add(donorData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Donor data submitted successfully!')),
        );

        // Clear form after submission
        _formKey.currentState!.reset();
        _nameController.clear();
        _locationController.clear();
        _phoneController.clear();
        _emailController.clear();
        _healthNotesController.clear();
        setState(() {
          _bloodGroup = null;
          _lastDonationDate = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting donor data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Blood'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fill in your details to become a donor:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter your full name',
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Name is required'
                      : null,
                ),
                SizedBox(height: 20),
                // Blood Group Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Blood Group',
                  ),
                  items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                      .map((group) => DropdownMenuItem(
                            value: group,
                            child: Text(group),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _bloodGroup = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a blood group' : null,
                  value: _bloodGroup,
                ),
                SizedBox(height: 20),
                // Last Donation Date
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Donation Date',
                    hintText: _lastDonationDate == null
                        ? 'Select a date'
                        : '${_lastDonationDate!.day}/${_lastDonationDate!.month}/${_lastDonationDate!.year}',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _lastDonationDate = pickedDate;
                      });
                    }
                  },
                  validator: (value) => _lastDonationDate == null
                      ? 'Please select your last donation date'
                      : null,
                ),
                SizedBox(height: 20),
                // Location Field
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                    hintText: 'Enter your location',
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Location is required'
                      : null,
                ),
                SizedBox(height: 20),
                // Contact Information
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Phone number is required'
                      : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email (optional)',
                  ),
                ),
                SizedBox(height: 20),
                // Health Notes Field
                TextFormField(
                  controller: _healthNotesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Health Notes (optional)',
                    hintText: 'Mention any health conditions or medications',
                  ),
                ),
                SizedBox(height: 30),
                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: _submitDonorData,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
      ),
    );
  }
}
