import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AadhaarUploadPage extends StatefulWidget {
  const AadhaarUploadPage({super.key});

  @override
  State<AadhaarUploadPage> createState() => _AadhaarUploadPageState();
}

class _AadhaarUploadPageState extends State<AadhaarUploadPage> {
  final _formKey = GlobalKey<FormState>();
  final _idNumberController = TextEditingController();

  File? _frontImage;
  File? _backImage;
  final _picker = ImagePicker();

  // ───────── helpers ─────────
  bool get _allFilled =>
      _frontImage != null &&
      _backImage != null &&
      _idNumberController.text.isNotEmpty;

  Future<void> _pickImage(bool isFront) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        if (isFront) {
          _frontImage = File(picked.path);
        } else {
          _backImage = File(picked.path);
        }
      });
    }
  }

  void _upload() {
    if (_formKey.currentState!.validate() && _allFilled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Uploading Aadhaar / PAN details...')),
      );
      // TODO: call your backend / Firebase upload here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete every field')),
      );
    }
  }

  // ───────── UI widgets ─────────
  Widget _uploadBox({
    required String label,
    required bool isFront,
    required File? file,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _pickImage(isFront),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(5),
            dashPattern: const [6, 4],
            color: Colors.blue.shade200,
            strokeWidth: 1.5,
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: file == null
                  ? Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.image,
                                color: Color.fromARGB(255, 51, 86, 100)),
                            const SizedBox(width: 6),
                            Text(
                              isFront ? 'Upload Front' : 'Upload Back',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 86, 100),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(file, fit: BoxFit.cover),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Aadhaar / Pan Card',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _uploadBox(
                  label: 'Aadhaar / Pan Card Front',
                  isFront: true,
                  file: _frontImage),
              const SizedBox(height: 20),
              _uploadBox(
                  label: 'Aadhaar / Pan Card Back',
                  isFront: false,
                  file: _backImage),
              const SizedBox(height: 20),
              const Text('Aadhaar / Pan number',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _idNumberController,
                decoration: InputDecoration(
                  hintText: 'Aadhaar / Pan number',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1)),
                ),
                validator: (value) {
                  final txt = value ?? '';
                  final aadhaar = RegExp(r'^\d{12}$');
                  final pan = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$',
                      caseSensitive: false);
                  if (txt.isEmpty) {
                    return 'Enter Aadhaar or PAN number';
                  }
                  if (!aadhaar.hasMatch(txt) && !pan.hasMatch(txt)) {
                    return 'Invalid Aadhaar (12‑digit) or PAN (ABCDE1234F)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: _upload,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _allFilled ? Colors.orange : Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Upload',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
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
