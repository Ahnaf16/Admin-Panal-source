import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/provider.dart';
import '../../widgets/widget_export.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscureText = ref.watch(obscureTextProvider);
    return ScaffoldPage(
      content: Center(
        child: BaseBody(
          widthfactor: 3,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Login',
                style: FluentTheme.of(context).typography.title,
              ),
            ),
            TextBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              header: 'Email',
            ),
            const SizedBox(
              height: 20,
            ),
            TextBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              header: 'Password',
              obscureText: obscureText,
              suffix: IconButton(
                icon: Icon(
                  obscureText ? FluentIcons.hide3 : FluentIcons.view,
                  size: 20,
                ),
                onPressed: () {
                  ref.read(obscureTextProvider.state).state = !obscureText;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: FilledButton(
                child: const Text('Log In'),
                onPressed: () {
                  EasyLoading.showToast(
                    'Logging In...',
                    toastPosition: EasyLoadingToastPosition.bottom,
                  );
                },
                style: FluentTheme.of(context).buttonTheme.filledButtonStyle,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
