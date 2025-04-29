import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AddressProofUploadScreen extends StatefulWidget {
  final String vinid; 
  const AddressProofUploadScreen({super.key, required this.vinid});

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

  String? documentError;
  String? imageError;
  String? uploadError;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        imageError = null;
      });
    }
  }

  void showImagePickerOptions(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: Color(0xFF640101)),
                title: Text("Pick from Gallery"),
                onTap: () {
                  Navigator.pop(ctx);
                  pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Color(0xFF640101)),
                title: Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(ctx);
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

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

    try {
      var uri = Uri.parse("https://crediqure.com/appdevelopment/malavika/document_upload.php");
      var request = http.MultipartRequest("POST", uri);

      request.fields['loginid'] = widget.vinid;
      request.fields['docname'] = selectedDocument!;

      var stream = http.ByteStream(selectedImage!.openRead());
      var length = await selectedImage!.length();
      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: basename(selectedImage!.path),
      );

      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(ctx).showSnackBar(
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
    } catch (e) {
      setState(() {
        uploadError = "An error occurred: $e";
      });
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Upload Address Proof', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF640101),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Document Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                    documentError = null;
                  });
                },
              ),
              if (documentError != null)
                Text(documentError!, style: TextStyle(color: Colors.red)),

              SizedBox(height: 20),

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
                      label: Text("Select Document",style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF640101)),
                      onPressed: () => showImagePickerOptions(context),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF640101),
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
      ),
    );
  }
}
