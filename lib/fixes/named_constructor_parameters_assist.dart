import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class ConvertToNamedParametersAssist extends DartAssist {
  static const _message = 'Convert to named parameters';

  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    context.registry.addConstructorDeclaration((node) {
      if (!target.intersects(node.sourceRange)) return;

      final parameters = node.parameters.parameters;

      if (parameters.length <= 1 ||
          parameters.every((param) => !param.isPositional)) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: _message,
        priority: 1,
      );

      changeBuilder.addDartFileEdit((builder) {
        for (final param in parameters) {
          if (param.isPositional) {
            builder.addSimpleInsertion(param.offset, '{');
            builder.addSimpleInsertion(param.end, '}');
          }
        }
      });
    });
  }
}
