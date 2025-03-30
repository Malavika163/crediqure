import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class AddressProofUploadScreen extends StatefulWidget {
  const AddressProofUploadScreen({super.key});

  @override
  _AddressProofUploadScreenState createState() => _AddressProofUploadScreenState();
}

class _AddressProofUploadScreenState extends State<AddressProofUploadScreen> {
  final List<String> documentTypes = [
    'Aadhaar Card',
    'PAN Card',
    'Passport',
    'Driving License',
    'Voter ID'
  ];

  String? selectedDocument;
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool isUploading = false;

  // Error messages
  String? documentError;
  String? imageError;
  String? uploadError;

  // Function to pick image from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        imageError = null; // Clear error when image is selected
      });
    }
  }

  // Function to show image selection options
  void showImagePickerOptions(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx, // ✅ Use the passed context
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: const Color.fromARGB(255, 100, 1, 1)),
                title: Text("Pick from Gallery"),
                onTap: () {
                  Navigator.pop(ctx); // ✅ Use passed context
                  pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: const Color.fromARGB(255, 100, 1, 1)),
                title: Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(ctx); // ✅ Use passed context
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to upload document to PHP API
  Future<void> uploadDocument(BuildContext ctx) async {
    setState(() {
      documentError = selectedDocument == null ? "Please select a document type" : null;
      imageError = selectedImage == null ? "Please select an image" : null;
      uploadError = null;
    });

    if (selectedDocument == null || selectedImage == null) return;

    setState(() {
      isUploading = true;
    });

    var uri = Uri.parse("https://yourdomain.com/upload.php"); // Change to your API URL
    var request = http.MultipartRequest("POST", uri);

    // Sample User ID (replace with actual user data)
    int userId = 1;

    request.fields['user_id'] = userId.toString();
    request.fields['document_type'] = selectedDocument!;

    var stream = http.ByteStream(selectedImage!.openRead());
    var length = await selectedImage!.length();
    var multipartFile = http.MultipartFile('file', stream, length, filename: basename(selectedImage!.path));

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(ctx).showSnackBar( // ✅ Use passed context
        SnackBar(content: Text("$selectedDocument uploaded successfully!")),
      );
      setState(() {
        selectedDocument = null;
        selectedImage = null;
      });
    } else {
      setState(() {
        uploadError = "Upload failed. Try again!";
      });
    }

    setState(() {
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context); 
    },
  ),

        title: Text('Upload Address Proof', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 100, 1, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Document Type
            Text("Select Document Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedDocument,
              hint: Text("Choose Document", style: TextStyle(color: Color(0xff111184))),
              items: documentTypes.map((String type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDocument = value;
                  documentError = null; // Clear error when user selects a document
                });
              },
            ),
            if (documentError != null)
              Text(documentError!, style: TextStyle(color: Colors.red)),

            SizedBox(height: 20),

            // Upload Section
            Center(
              child: Column(
                children: [
                  selectedImage == null
                      ? Text("No document selected", style: TextStyle(color: Colors.red))
                      : Image.file(selectedImage!, height: 150, width: 150, fit: BoxFit.cover),
                  if (imageError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(imageError!, style: TextStyle(color: Colors.red)),
                    ),
                  SizedBox(height: 10),
                  
                  ElevatedButton.icon(
                    icon: Icon(Icons.upload_file),
                    label: Text("Select Document"),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 100, 1, 1)),
                    onPressed: () => showImagePickerOptions(context),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Upload Button
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 100, 1, 1),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: isUploading ? null : () => uploadDocument(context),
                    child: isUploading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Upload Document"),
                  ),
                  if (uploadError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(uploadError!, style: TextStyle(color: Colors.red)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
