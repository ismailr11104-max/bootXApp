import 'package:bootx_app/core/utils/app_colors.dart';
import 'package:bootx_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title / Label Above Input
        Text(
          widget.labelText,
          textAlign: TextAlign.start,
          style: AppTextStyles.medium16.copyWith(
            color: AppColors.textLightPrimary,
          ),
        ),
        const SizedBox(height: 10),

        // Text Field Input Container
        TextFormField(
          textAlign: TextAlign.start,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _isObscured,
          validator: widget.validator,
          onChanged: widget.onChanged,
          style: AppTextStyles.regular14.copyWith(
            color: AppColors.textLightPrimary,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: const Color(0xFF1E232E).withOpacity(0.4),
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
            // Border Styles (Pill-shape / Fully Rounded)
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
            ),
            suffixIcon: widget.isPassword
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      icon: Icon(
                        _isObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFF1E232E),
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
