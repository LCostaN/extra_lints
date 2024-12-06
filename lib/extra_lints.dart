library extra_lints;

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:extra_lints/fixes/named_constructor_parameters_assist.dart';
import 'package:extra_lints/lints/named_constructor_parameters.dart';

import 'fixes/surround_with_try_catch_fix.dart';

import 'lints/expects_try_catch.dart';

PluginBase createPlugin() => _ExtraLinter();

class _ExtraLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        const ExpectsTryCatch(),
        const NamedParametersForConstructors(),
      ];

  @override
  List<Assist> getAssists() => [
        SurroundWithTryCatchFix(),
        ConvertToNamedParametersAssist(),
      ];
}
