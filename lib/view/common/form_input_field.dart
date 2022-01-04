import 'package:flutter/material.dart';

enum RequiredType {
  required,
  eitherRequired,
  none,
}

class FormInputField extends StatelessWidget {
  const FormInputField({
    this.label,
    this.inputWidget,
    this.requiredType = RequiredType.none,
  });

  final String? label;
  final Widget? inputWidget;
  final RequiredType? requiredType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLabel(requiredType!),
          const SizedBox(
            height: 2,
          ),
          inputWidget!,
        ],
      ),
    );
  }

  Widget _buildLabel(RequiredType requiredType) {
    if (requiredType != RequiredType.none) {
      return Row(
        children: [
          Text(
            label ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          _RequiredText(
            requiredType: requiredType,
          ),
        ],
      );
    }
    return Text(
      label ?? '',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.white
      ),
    );
  }
}

class _RequiredText extends StatelessWidget {
  const _RequiredText({
    this.requiredType,
  });

  final RequiredType? requiredType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.lightBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 1,
          horizontal: 5,
        ),
        child: Text(
          _getRequiredTypeText(
            context,
            requiredType!,
          ),
          style:
          TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.white
          )


        ),
      ),
    );
  }

  String _getRequiredTypeText(
    BuildContext context,
    RequiredType requiredType,
  ) {
    String _label;
    switch (requiredType) {
      case RequiredType.required:
        _label = 'Please input';
        break;
      case RequiredType.eitherRequired:
        _label = "";
        break;
      case RequiredType.none:
        _label = '';
        break;
    }
    return _label;
  }
}
