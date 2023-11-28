import 'package:flutter_test/flutter_test.dart';

import 'package:luggage_organizer/main.dart';

void main() {
  testWidgets('Simple test', (WidgetTester tester) async {
    await tester.pumpWidget(const LuggageOrganizerApp());
  });
}
