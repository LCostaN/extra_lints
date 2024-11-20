library extra_lints;

import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'fixes/surround_with_try_catch_fix.dart';

import 'lints/expects_try_catch.dart';

PluginBase createPlugin() => _ExtraLinter();

class _ExtraLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        const ExpectsTryCatch(),
      ];

  @override
  List<Assist> getAssists() => [SurroundWithTryCatchFix()];
}
