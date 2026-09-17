import 'package:flutter_test/flutter_test.dart';
import 'package:ner_memorycare/app.dart';

void main() {
  testWidgets('Full navigation flow test - Caregiver and Elderly', (WidgetTester tester) async {
    await tester.pumpWidget(const MemoryCareApp());
    await tester.pumpAndSettle();

    // 1. Welcome Screen
    expect(find.text('NER MEMORY CARE'), findsWidgets);
    final getStartedFinder = find.textContaining('Get Started');
    await tester.ensureVisible(getStartedFinder.first);
    await tester.tap(getStartedFinder.first);
    await tester.pumpAndSettle();

    // 2. Mode Selection Screen
    expect(find.text('Elderly User'), findsOneWidget);
    expect(find.text('Caregiver'), findsOneWidget);

    // 3. Test Caregiver Dashboard & Bottom Navigation
    await tester.tap(find.text('Caregiver'));
    await tester.pumpAndSettle();
    expect(find.text("Today's Care Overview"), findsOneWidget);

    // Bottom nav: Progress
    await tester.tap(find.text('Progress').last);
    await tester.pumpAndSettle();
    expect(find.text('Activity Progress'), findsOneWidget);

    // Bottom nav: Reminders
    await tester.tap(find.text('Reminders').last);
    await tester.pumpAndSettle();
    expect(find.text('Care Reminders & Routines'), findsOneWidget);

    // Bottom nav: Profile
    await tester.tap(find.text('Profile').last);
    await tester.pumpAndSettle();
    expect(find.text('Caregiver & Patient Profile'), findsOneWidget);

    // Switch to Elderly View from Profile button
    await tester.tap(find.text('Switch'));
    await tester.pumpAndSettle();

    // 4. Test Elderly Home Screen & Games
    expect(find.text('Hello, Meena'), findsOneWidget);
    expect(find.text('Play a Game'), findsOneWidget);

    // Tap "Play a Game"
    await tester.tap(find.text('Play a Game'));
    await tester.pumpAndSettle();

    // Cognitive games screen
    expect(find.text("Let's Play & Remember"), findsOneWidget);
    expect(find.text('Memory Match'), findsOneWidget);

    // Launch Memory Match game
    await tester.tap(find.text('Memory Match'));
    await tester.pumpAndSettle();
    expect(find.text('Matches: 0 / 4'), findsOneWidget);

    // Tap cards
    await tester.tap(find.text('Tap to open').first);
    await tester.pumpAndSettle();
  });
}
