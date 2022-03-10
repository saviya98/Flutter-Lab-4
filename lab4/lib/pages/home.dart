import 'package:flutter/material.dart';
import 'package:lab4/services/agifyService.dart';

class Home extends StatefulWidget {
  final AgifyService _agifyService;

  const Home({Key? key})
      : _agifyService = const AgifyService(),
        super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _age;

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final generatedAge = await widget._agifyService.getAgeFromName(_name!);

      setState(() {
        _age = generatedAge;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agify'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    label: Text('Name'),
                    helperText: 'Enter Name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the Name";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  setState(() {
                    if (value != null) _name = value;
                  });
                },
              ),
            ),
            ElevatedButton(onPressed: onSubmit, child: const Text('Get Age')),
            if (_age != null)
              Center(
                child: Text(
                  'Age is ' + _age.toString(),
                  style: Theme.of(context).textTheme.headline3,
                ),
              )
          ],
        ),
      ),
    );
  }
}
