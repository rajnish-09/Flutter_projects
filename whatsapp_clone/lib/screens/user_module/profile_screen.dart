import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/auth/auth_bloc.dart';
import 'package:whatsapp_clone/bloc/auth/auth_event.dart';
import 'package:whatsapp_clone/bloc/auth/auth_state.dart';
import 'package:whatsapp_clone/bloc/profile/profile_bloc.dart';
import 'package:whatsapp_clone/bloc/profile/profile_event.dart';
import 'package:whatsapp_clone/bloc/profile/profile_state.dart';
import 'package:whatsapp_clone/bloc/users/user_bloc.dart';
import 'package:whatsapp_clone/bloc/users/user_event.dart';
import 'package:whatsapp_clone/bloc/users/user_state.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/auth_module/login_screen.dart';
import 'package:whatsapp_clone/widgets/show_toast.dart';
import 'package:whatsapp_clone/widgets/submit_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile());
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();

  bool isTextFieldEnabled = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLogoutSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
            if (state is AccountDeleted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              showToastWidget('Account delete successfully.', Colors.green);
            }
          },
        ),

        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdated) {
              showToastWidget('Profile updated successfully', Colors.green);
            }
            if (state is ProfileError) {
              showToastWidget(state.msg, Colors.red);
            }
            if (state is LoadPersonalDetail) {
              final user = state.userData;
              nameController.text = user.name;
              emailController.text = user.email;
              phoneController.text = user.phone;
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is LoadPersonalDetail) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'edit') {
                                setState(() {
                                  isTextFieldEnabled = true;
                                });
                              }
                              if (value == 'delete') {
                                context.read<AuthBloc>().add(
                                  DeleteAccountEvent(),
                                );
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text("Edit"),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("Delete"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              'assets/images/default_profile.jpg',
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          "Personal details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        ProfileTextField(
                          controller: nameController,
                          label: 'Name',
                          isEnabled: isTextFieldEnabled,
                          validator: (value) {
                            if (nameController.text.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        ProfileTextField(
                          controller: emailController,
                          label: 'Email',
                          isEnabled: false,
                        ),
                        SizedBox(height: 15),
                        ProfileTextField(
                          controller: phoneController,
                          label: 'Phone',
                          isEnabled: isTextFieldEnabled,
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (phoneController.text.isEmpty) {
                              return 'Phone is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),

                        SizedBox(height: 30),
                        if (isTextFieldEnabled)
                          SubmitButton(
                            buttonText: 'Save',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final updatedUserData = UserModel(
                                  name: nameController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  email: emailController.text.trim(),
                                  // country: countryController.text.trim(),
                                  // province: provinceController.text.trim(),
                                  // city: cityController.text.trim(),
                                  // street: streetController.text.trim(),
                                );
                                context.read<ProfileBloc>().add(
                                  UpdateProfile(userData: updatedUserData),
                                );
                                setState(() {
                                  isTextFieldEnabled = false;
                                });
                              }
                              return;
                            },
                          ),
                        // SizedBox(height: 30),
                        if (!isTextFieldEnabled)
                          SubmitButton(
                            buttonText: 'Logout',
                            onPressed: () {
                              context.read<AuthBloc>().add(LogoutEvent());
                            },
                            backgroundColor: Color(0xffF83758),
                          ),
                      ],
                    ),
                  );
                }
                return Text("Error loading profile");
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.isEnabled,
    this.validator,
    this.textInputType,
  });

  final TextEditingController controller;
  final String label;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(height: 10),
          TextFormField(
            validator: validator,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: textInputType ?? TextInputType.text,
            enabled: isEnabled,
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              filled: true,
              fillColor: Colors.transparent,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
