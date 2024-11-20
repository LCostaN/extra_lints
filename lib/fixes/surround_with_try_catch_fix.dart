import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class SurroundWithTryCatchFix extends DartAssist {
  static const _message = 'Surround with Try/Catch block';

  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    context.registry.addVariableDeclarationList((node) {
      if (!target.intersects(node.sourceRange)) return;

      final changeBuilder = reporter.createChangeBuilder(
        message: _message,
        priority: 2,
      );

      changeBuilder.addDartFileEdit((builder) {
        final nodeType = node.type;
        if (nodeType != null) {
          builder.addSimpleInsertion(nodeType.offset, 'try {\n');
          builder.addSimpleInsertion(nodeType.offset + nodeType.length, '\n} catch (e) {\n}');
        }
      });
    });
  }
}
