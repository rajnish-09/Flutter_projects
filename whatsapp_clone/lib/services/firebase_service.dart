import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widgets/show_snackbar.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final whatsappUserCollection = FirebaseFirestore.instance.collection(
    'whatsappUser',
  );

  Future<void> 
  
}
