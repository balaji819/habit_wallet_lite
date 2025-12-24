import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/auth/presentation/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _pinController = TextEditingController();

  bool rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  /// 🔁 Retry handler for error boundary
  void _retryLogin() {
    ref.invalidate(authControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6C63FF),
              Color(0xFF00C896),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  /// LOGO
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 38,
                      color: Color(0xFF6C63FF),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Habit Wallet',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Track money. Build habits.',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// LOGIN CARD
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 30,
                          offset: Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        children: [
                          /// EMAIL
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              filled: true,
                              fillColor: const Color(0xFFF4F6FB),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          /// PIN
                          TextField(
                            controller: _pinController,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'PIN',
                              prefixIcon: const Icon(Icons.lock_outline),
                              filled: true,
                              fillColor: const Color(0xFFF4F6FB),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// REMEMBER ME
                          CheckboxListTile(
                            value: rememberMe,
                            onChanged: (v) =>
                                setState(() => rememberMe = v ?? true),
                            title: const Text('Remember me'),
                            controlAffinity:
                            ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                          ),

                          ///  ERROR BOUNDARY (Snackbar + Retry)
                          if (authState.hasError)
                            Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF1F0),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFFF4D4F),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Color(0xFFFF4D4F),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      authState.error.toString(),
                                      style: const TextStyle(
                                        color: Color(0xFFFF4D4F),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: _retryLogin,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            ),

                          const SizedBox(height: 12),

                          /// LOGIN BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                backgroundColor:
                                const Color(0xFF6C63FF),
                              ),
                              onPressed: authState.isLoading
                                  ? null
                                  : () async {
                                if (_emailController.text.isEmpty ||
                                    _pinController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please enter email and PIN',
                                      ),
                                      behavior:
                                      SnackBarBehavior.floating,
                                    ),
                                  );
                                  return;
                                }

                                await ref
                                    .read(authControllerProvider.notifier)
                                    .login(
                                  _emailController.text.trim(),
                                  _pinController.text.trim(),
                                  rememberMe,
                                );
                              },
                              child: authState.isLoading
                                  ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                                  : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Secure • Offline-first • Private',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
