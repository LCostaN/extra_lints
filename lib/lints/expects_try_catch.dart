import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class ExpectsTryCatch extends DartLintRule {
  const ExpectsTryCatch() : super(code: _code);

  static const lintName = 'expects_try_catch';
  static const _code = LintCode(
    name: lintName,
    problemMessage: 'This method expects to be handled by a try/catch block',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      final annotation = node.metadata.indexWhere((annotation) =>
          annotation.name.name == 'expectTryCatch' &&
          annotation.element?.declaration?.librarySource?.fullName == 'your_package_name');

      if (annotation != -1) {
        if (!_isInsideTryCatch(node)) {
          reporter.atNode(node, code);
        }
      }
    });
  }

  bool _isInsideTryCatch(AstNode node) {
    AstNode? current = node.parent;

    while (current != null) {
      if (current is TryStatement) {
        return true;
      }
      current = current.parent;
    }
    return false;
  }
}
