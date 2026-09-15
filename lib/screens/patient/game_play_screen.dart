import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/primary_button.dart';
import '../../services/game_service.dart';

/// Interactive Game Play Screen hosting 3 playable cognitive games:
/// 1. Memory Match (6-8 cards with NER cultural symbols)
/// 2. Remember the Picture (Preview -> Recall from 4 options)
/// 3. Everyday Objects (Recognizing familiar everyday objects)
class GamePlayScreen extends StatefulWidget {
  final String gameId;
  final String gameTitle;

  const GamePlayScreen({
    super.key,
    required this.gameId,
    required this.gameTitle,
  });

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  late DateTime _startTime;
  bool _isFinished = false;

  // --- Game 1: Memory Match State ---
  late List<_CardItem> _cards;
  int? _firstFlippedIndex;
  bool _isProcessingMatch = false;
  int _matchAttempts = 0;
  int _matchesFound = 0;

  // --- Game 2: Remember Picture State ---
  int _pictureRound = 0;
  bool _isShowingTarget = true;
  int _pictureTimerSeconds = 4;
  Timer? _previewTimer;
  int _pictureScore = 0;
  String? _selectedPictureOption;
  bool _showPictureFeedback = false;

  // --- Game 3: Everyday Objects State ---
  int _objectRound = 0;
  int _objectScore = 0;
  String? _selectedObjectOption;
  bool _showObjectFeedback = false;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _initGame();
  }

  @override
  void dispose() {
    _previewTimer?.cancel();
    super.dispose();
  }

  void _initGame() {
    _startTime = DateTime.now();
    _isFinished = false;

    if (widget.gameId == 'memory_match') {
      _initMemoryMatch();
    } else if (widget.gameId == 'remember_picture') {
      _initRememberPicture();
    } else if (widget.gameId == 'everyday_objects') {
      _initEverydayObjects();
    }
  }

  // -------------------------------------------------------------
  // GAME 1: MEMORY MATCH INITIALIZATION & LOGIC
  // -------------------------------------------------------------
  void _initMemoryMatch() {
    _matchAttempts = 0;
    _matchesFound = 0;
    _firstFlippedIndex = null;
    _isProcessingMatch = false;

    // 4 pairs (8 cards) of North Eastern symbols
    final symbols = [
      AppConstants.nerCulturalSymbols[0], // Tea leaf
      AppConstants.nerCulturalSymbols[1], // Hornbill
      AppConstants.nerCulturalSymbols[2], // Orchid
      AppConstants.nerCulturalSymbols[3], // Bamboo
    ];

    List<_CardItem> cardList = [];
    for (int i = 0; i < symbols.length; i++) {
      cardList.add(
        _CardItem(
          id: symbols[i]['id'],
          name: symbols[i]['name'],
          icon: symbols[i]['icon'],
          color: symbols[i]['color'],
        ),
      );
      cardList.add(
        _CardItem(
          id: symbols[i]['id'],
          name: symbols[i]['name'],
          icon: symbols[i]['icon'],
          color: symbols[i]['color'],
        ),
      );
    }
    cardList.shuffle();
    _cards = cardList;
  }

  void _onCardTap(int index) {
    if (_isProcessingMatch ||
        _cards[index].isFaceUp ||
        _cards[index].isMatched) {
      return;
    }

    setState(() {
      _cards[index].isFaceUp = true;
    });

    if (_firstFlippedIndex == null) {
      _firstFlippedIndex = index;
    } else {
      _matchAttempts++;
      _isProcessingMatch = true;
      final first = _cards[_firstFlippedIndex!];
      final second = _cards[index];

      if (first.id == second.id) {
        // Matched!
        first.isMatched = true;
        second.isMatched = true;
        _matchesFound++;
        _firstFlippedIndex = null;
        _isProcessingMatch = false;

        if (_matchesFound == 4) {
          _completeGame(score: 4, totalPossible: 4);
        }
      } else {
        // No match - gently flip back after brief pause
        Future.delayed(const Duration(milliseconds: 900), () {
          if (mounted) {
            setState(() {
              first.isFaceUp = false;
              second.isFaceUp = false;
              _firstFlippedIndex = null;
              _isProcessingMatch = false;
            });
          }
        });
      }
    }
  }

  // -------------------------------------------------------------
  // GAME 2: REMEMBER THE PICTURE LOGIC
  // -------------------------------------------------------------
  final List<Map<String, dynamic>> _pictureRounds = [
    {
      'targetName': 'Blue Vanda Orchid',
      'targetIcon': Icons.local_florist,
      'targetColor': Color(0xFF7B1FA2),
      'options': [
        'Great Hornbill',
        'Blue Vanda Orchid',
        'Assam Tea Leaf',
        'Traditional Loom',
      ],
    },
    {
      'targetName': 'Great Hornbill',
      'targetIcon': Icons.flutter_dash,
      'targetColor': Color(0xFFF57C00),
      'options': [
        'Mizoram Bamboo',
        'Bihu Dhol Drum',
        'Great Hornbill',
        'Blue Vanda Orchid',
      ],
    },
    {
      'targetName': 'Assam Tea Leaf',
      'targetIcon': Icons.eco,
      'targetColor': Color(0xFF2E7D32),
      'options': [
        'Assam Tea Leaf',
        'Traditional Loom',
        'Bihu Dhol Drum',
        'Mizoram Bamboo',
      ],
    },
  ];

  void _initRememberPicture() {
    _pictureRound = 0;
    _pictureScore = 0;
    _startPictureRound();
  }

  void _startPictureRound() {
    _isShowingTarget = true;
    _pictureTimerSeconds = 3;
    _selectedPictureOption = null;
    _showPictureFeedback = false;

    _previewTimer?.cancel();
    _previewTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_pictureTimerSeconds > 1) {
        setState(() {
          _pictureTimerSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isShowingTarget = false;
        });
      }
    });
  }

  void _submitPictureAnswer(String chosen) {
    if (_showPictureFeedback) return;

    final target = _pictureRounds[_pictureRound]['targetName'];
    final isCorrect = chosen == target;

    setState(() {
      _selectedPictureOption = chosen;
      _showPictureFeedback = true;
      if (isCorrect) _pictureScore++;
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      if (_pictureRound < _pictureRounds.length - 1) {
        setState(() {
          _pictureRound++;
          _startPictureRound();
        });
      } else {
        _completeGame(
          score: _pictureScore,
          totalPossible: _pictureRounds.length,
        );
      }
    });
  }

  // -------------------------------------------------------------
  // GAME 3: EVERYDAY OBJECTS LOGIC
  // -------------------------------------------------------------
  final List<Map<String, dynamic>> _objectQuestions = [
    {
      'question': 'Which object do we use to drink a warm cup of tea?',
      'correct': 'Tea Cup',
      'options': [
        {
          'name': 'Tea Cup',
          'icon': Icons.coffee_rounded,
          'color': Color(0xFF8D6E63),
        },
        {
          'name': 'Wall Clock',
          'icon': Icons.access_time_filled_rounded,
          'color': Color(0xFF1976D2),
        },
        {
          'name': 'Comfortable Chair',
          'icon': Icons.chair_rounded,
          'color': Color(0xFF00796B),
        },
        {
          'name': 'Reading Book',
          'icon': Icons.menu_book_rounded,
          'color': Color(0xFFE65100),
        },
      ],
    },
    {
      'question': 'Which item helps us check what time it is?',
      'correct': 'Wall Clock',
      'options': [
        {
          'name': 'Fresh Apples',
          'icon': Icons.apple_rounded,
          'color': Color(0xFFC62828),
        },
        {
          'name': 'Wall Clock',
          'icon': Icons.access_time_filled_rounded,
          'color': Color(0xFF1976D2),
        },
        {
          'name': 'Water Bottle',
          'icon': Icons.water_drop_rounded,
          'color': Color(0xFF0288D1),
        },
        {
          'name': 'Umbrella',
          'icon': Icons.beach_access_rounded,
          'color': Color(0xFF6A1B9A),
        },
      ],
    },
    {
      'question': 'Where do we sit down to relax comfortably?',
      'correct': 'Comfortable Chair',
      'options': [
        {
          'name': 'Reading Book',
          'icon': Icons.menu_book_rounded,
          'color': Color(0xFFE65100),
        },
        {
          'name': 'Tea Cup',
          'icon': Icons.coffee_rounded,
          'color': Color(0xFF8D6E63),
        },
        {
          'name': 'Comfortable Chair',
          'icon': Icons.chair_rounded,
          'color': Color(0xFF00796B),
        },
        {
          'name': 'Fresh Apples',
          'icon': Icons.apple_rounded,
          'color': Color(0xFFC62828),
        },
      ],
    },
    {
      'question': 'Which one gives us stories and knowledge to read?',
      'correct': 'Reading Book',
      'options': [
        {
          'name': 'Reading Book',
          'icon': Icons.menu_book_rounded,
          'color': Color(0xFFE65100),
        },
        {
          'name': 'Water Bottle',
          'icon': Icons.water_drop_rounded,
          'color': Color(0xFF0288D1),
        },
        {
          'name': 'Wall Clock',
          'icon': Icons.access_time_filled_rounded,
          'color': Color(0xFF1976D2),
        },
        {
          'name': 'Tea Cup',
          'icon': Icons.coffee_rounded,
          'color': Color(0xFF8D6E63),
        },
      ],
    },
  ];

  void _initEverydayObjects() {
    _objectRound = 0;
    _objectScore = 0;
    _selectedObjectOption = null;
    _showObjectFeedback = false;
  }

  void _submitObjectAnswer(String chosen) {
    if (_showObjectFeedback) return;

    final correct = _objectQuestions[_objectRound]['correct'];
    final isCorrect = chosen == correct;

    setState(() {
      _selectedObjectOption = chosen;
      _showObjectFeedback = true;
      if (isCorrect) _objectScore++;
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      if (_objectRound < _objectQuestions.length - 1) {
        setState(() {
          _objectRound++;
          _selectedObjectOption = null;
          _showObjectFeedback = false;
        });
      } else {
        _completeGame(
          score: _objectScore,
          totalPossible: _objectQuestions.length,
        );
      }
    });
  }

  // -------------------------------------------------------------
  // COMPLETION HANDLER
  // -------------------------------------------------------------
  void _completeGame({required int score, required int totalPossible}) {
    final duration = DateTime.now().difference(_startTime).inSeconds;

    GameService().recordGameCompletion(
      gameId: widget.gameId,
      gameTitle: widget.gameTitle,
      score: score,
      totalPossible: totalPossible,
      durationSeconds: duration < 10 ? 30 : duration,
    );

    setState(() {
      _isFinished = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: Text(widget.gameTitle),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Restart Game',
            onPressed: () {
              setState(() {
                _initGame();
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _isFinished ? _buildCompletionView() : _buildActiveGameView(),
      ),
    );
  }

  Widget _buildActiveGameView() {
    if (widget.gameId == 'memory_match') {
      return _buildMemoryMatchGame();
    } else if (widget.gameId == 'remember_picture') {
      return _buildRememberPictureGame();
    } else {
      return _buildEverydayObjectsGame();
    }
  }

  // -------------------------------------------------------------
  // GAME 1 UI: MEMORY MATCH
  // -------------------------------------------------------------
  Widget _buildMemoryMatchGame() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        children: [
          // Gentle banner
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AppConstants.accentGreen,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Matches: $_matchesFound / 4',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Attempts: $_matchAttempts',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppConstants.neutralTextMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tap two cards to find matching North Eastern symbols.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppConstants.neutralTextDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          // 8-Card Grid (4 pairs)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.15,
            ),
            itemCount: _cards.length,
            itemBuilder: (context, index) {
              final card = _cards[index];
              final isRevealed = card.isFaceUp || card.isMatched;

              return InkWell(
                onTap: () => _onCardTap(index),
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isRevealed ? Colors.white : AppConstants.primaryTeal,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: card.isMatched
                          ? AppConstants.accentGreen
                          : (isRevealed
                                ? AppConstants.cardBorderColor
                                : AppConstants.primaryTealDark),
                      width: card.isMatched ? 3 : 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: isRevealed
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(card.icon, size: 40, color: card.color),
                              const SizedBox(height: 6),
                              Text(
                                card.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: card.color,
                                ),
                              ),
                            ],
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.touch_app_rounded,
                                size: 36,
                                color: Colors.white70,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Tap to open',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Take your time. No rush, no timer.',
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppConstants.neutralTextMuted,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // GAME 2 UI: REMEMBER THE PICTURE
  // -------------------------------------------------------------
  Widget _buildRememberPictureGame() {
    final currentRound = _pictureRounds[_pictureRound];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        children: [
          // Round indicator
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Round ${_pictureRound + 1} of ${_pictureRounds.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Score: $_pictureScore',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.accentGreen,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          if (_isShowingTarget) ...[
            const Text(
              'Look carefully and remember this picture:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppConstants.neutralTextDark,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: currentRound['targetColor'],
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (currentRound['targetColor'] as Color).withValues(
                      alpha: 0.2,
                    ),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentRound['targetIcon'],
                      size: 64,
                      color: currentRound['targetColor'],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentRound['targetName'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: currentRound['targetColor'],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Remembering in $_pictureTimerSeconds seconds...',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppConstants.primaryTeal,
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                _previewTimer?.cancel();
                setState(() => _isShowingTarget = false);
              },
              child: const Text("I'm ready to choose"),
            ),
          ] else ...[
            const Text(
              'Which picture did you see?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppConstants.neutralTextDark,
              ),
            ),
            const SizedBox(height: 24),

            // 4 Options
            ...(currentRound['options'] as List<String>).map((opt) {
              final isChosen = _selectedPictureOption == opt;
              final isCorrectTarget = opt == currentRound['targetName'];

              Color cardColor = Colors.white;
              Color borderColor = AppConstants.cardBorderColor;

              if (_showPictureFeedback) {
                if (isCorrectTarget) {
                  cardColor = AppConstants.accentGreenLight;
                  borderColor = AppConstants.accentGreen;
                } else if (isChosen && !isCorrectTarget) {
                  cardColor = const Color(0xFFFFEBEE);
                  borderColor = const Color(0xFFE57373);
                }
              }

              return AppCard(
                onTap: _showPictureFeedback
                    ? null
                    : () => _submitPictureAnswer(opt),
                margin: const EdgeInsets.only(bottom: 14),
                color: cardColor,
                borderColor: borderColor,
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppConstants.primaryTealLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.photo_rounded,
                        color: AppConstants.primaryTealDark,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        opt,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppConstants.neutralTextDark,
                        ),
                      ),
                    ),
                    if (_showPictureFeedback && isCorrectTarget)
                      const Icon(
                        Icons.check_circle_rounded,
                        color: AppConstants.accentGreen,
                        size: 28,
                      ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // GAME 3 UI: EVERYDAY OBJECTS
  // -------------------------------------------------------------
  Widget _buildEverydayObjectsGame() {
    final current = _objectQuestions[_objectRound];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        children: [
          // Round header
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item ${_objectRound + 1} of ${_objectQuestions.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Score: $_objectScore',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.accentGreen,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Question Prompt
          Text(
            current['question'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppConstants.neutralTextDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 24),

          // 4 Object Cards
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.0,
            ),
            itemCount: (current['options'] as List).length,
            itemBuilder: (context, idx) {
              final item = (current['options'] as List)[idx];
              final name = item['name'] as String;
              final icon = item['icon'] as IconData;
              final color = item['color'] as Color;

              final isChosen = _selectedObjectOption == name;
              final isCorrect = name == current['correct'];

              Color cardBg = Colors.white;
              Color border = AppConstants.cardBorderColor;

              if (_showObjectFeedback) {
                if (isCorrect) {
                  cardBg = AppConstants.accentGreenLight;
                  border = AppConstants.accentGreen;
                } else if (isChosen && !isCorrect) {
                  cardBg = const Color(0xFFFFEBEE);
                  border = const Color(0xFFE57373);
                }
              }

              return InkWell(
                onTap: _showObjectFeedback
                    ? null
                    : () => _submitObjectAnswer(name),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: border,
                      width: isChosen || isCorrect ? 2.5 : 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 40, color: color),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppConstants.neutralTextDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Tap the picture that best answers the question.',
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppConstants.neutralTextMuted,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // COMPLETION VIEW
  // -------------------------------------------------------------
  Widget _buildCompletionView() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                size: 64,
                color: Color(0xFFF57C00),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Wonderful Job, Meena!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: AppConstants.neutralTextDark,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You completed today’s gentle activity.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppConstants.neutralTextMuted,
              ),
            ),
            const SizedBox(height: 24),

            // Summary Card
            AppCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Column(
                        children: [
                          Icon(
                            Icons.stars_rounded,
                            color: Color(0xFFF57C00),
                            size: 28,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Completed',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Activity',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppConstants.neutralTextMuted,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 36,
                        width: 1,
                        color: AppConstants.cardBorderColor,
                      ),
                      const Column(
                        children: [
                          Icon(
                            Icons.favorite_rounded,
                            color: Color(0xFFE91E63),
                            size: 28,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '7 Days',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Daily Streak',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppConstants.neutralTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppConstants.secondaryCream,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '“Every moment of engagement nourishes your memory and brings joy.”',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: AppConstants.primaryTealDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            PrimaryButton(
              label: 'Play Again',
              icon: Icons.replay_rounded,
              isLarge: true,
              onPressed: () {
                setState(() {
                  _initGame();
                });
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.buttonRadius,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Back to Games',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardItem {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  bool isFaceUp = false;
  bool isMatched = false;

  _CardItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}
