import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NamedParametersForConstructors extends DartLintRule {
  const NamedParametersForConstructors() : super(code: _code);

  static const _code = LintCode(
    name: 'named_parameters_for_constructors',
    problemMessage:
        'Constructors with more than one parameter should use named parameters.',
    correctionMessage: 'Convert all parameters to named parameters.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addConstructorDeclaration(
      (node) {
        final parameters = node.parameters.parameters;

        if (parameters.length > 1 &&
            parameters.any((param) => param.isPositional)) {
          reporter.atNode(node, _code);
        }
      },
    );
  }
}
