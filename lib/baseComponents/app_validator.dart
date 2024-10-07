import 'package:flutter/material.dart';
  
class AppValidator<T> extends StatelessWidget {
  final Widget child;
  final String? Function(T? value)? validator;

  const AppValidator({
    super.key,
    required this.child,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: validator,
      builder: (FormFieldState<T> state) {
        return Column(
          key: ValueKey(state.hasError),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            if (state.hasError && state.errorText != null)
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                child: Text(
                  state.errorText!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}
