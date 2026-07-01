import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:Resilio/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Resilio/features/customer/games/game_hub/data/services/game_service.dart';

// ─── Story Data Model ─────────────────────────────────────────────────────────

enum Speaker { narrator, alex, maya, drChen, self_, inner }

class StoryNode {
  final String id;
  final Speaker speaker;
  final String text;
  final List<StoryChoice> choices; // empty → tap to continue
  final String? nextId;
  final _SceneMood mood;
  final int xpOnArrive;

  const StoryNode({
    required this.id,
    required this.speaker,
    required this.text,
    this.choices = const [],
    this.nextId,
    this.mood = _SceneMood.dusk,
    this.xpOnArrive = 0,
  });
}

class StoryChoice {
  final String text;
  final String nextId;
  final int xpBonus;
  final String? insight; // shown as therapy insight after choosing

  const StoryChoice({
    required this.text,
    required this.nextId,
    this.xpBonus = 0,
    this.insight,
  });
}

enum _SceneMood { dark, dusk, dawn, bright, warm }

// ─── Story Content ────────────────────────────────────────────────────────────

const _story = <String, StoryNode>{
  // ── CHAPTER 1: The Breaking Point ───────────────────────────────────────────
  'intro': StoryNode(
    id: 'intro',
    speaker: Speaker.narrator,
    mood: _SceneMood.dark,
    text:
        'Monday morning. 7:14 AM.\n\nAlex hasn\'t slept. Again.\nThree missed calls from work. A half-eaten bowl of cereal from two days ago still on the desk.',
    nextId: 'inner_1',
  ),
  'inner_1': StoryNode(
    id: 'inner_1',
    speaker: Speaker.inner,
    mood: _SceneMood.dark,
    text: '"I can\'t do this anymore."\n\nThe words form before Alex can stop them. They feel true in a way that\'s terrifying.',
    nextId: 'inner_2',
  ),
  'inner_2': StoryNode(
    id: 'inner_2',
    speaker: Speaker.inner,
    mood: _SceneMood.dark,
    text: 'When did everything get this heavy? It wasn\'t always like this.\nWas it?',
    nextId: 'choice_1',
  ),
  'choice_1': StoryNode(
    id: 'choice_1',
    speaker: Speaker.narrator,
    mood: _SceneMood.dark,
    text: 'The phone buzzes again. Maya. Alex stares at the ceiling.\n\nWhat do you do?',
    choices: [
      StoryChoice(
        text: '📵  Ignore it. Pull the covers over.',
        nextId: 'c1a_1',
        xpBonus: 5,
        insight: 'Avoidance is a natural response to overwhelm — but it often increases anxiety over time.',
      ),
      StoryChoice(
        text: '📞  Pick up.',
        nextId: 'c1b_1',
        xpBonus: 15,
        insight: 'Reaching out, even when it feels impossible, is one of the hardest and most healing acts.',
      ),
      StoryChoice(
        text: '✉️  Text back "not now".',
        nextId: 'c1c_1',
        xpBonus: 10,
        insight: 'Setting a small boundary is a start — you acknowledged someone cares.',
      ),
    ],
  ),

  // Branch A — ignore
  'c1a_1': StoryNode(
    id: 'c1a_1',
    speaker: Speaker.narrator,
    mood: _SceneMood.dark,
    text: 'Silence. The notification fades. The ceiling fan hums. An hour passes.',
    nextId: 'c1a_2',
  ),
  'c1a_2': StoryNode(
    id: 'c1a_2',
    speaker: Speaker.inner,
    mood: _SceneMood.dark,
    text: '"See? You can\'t even answer a phone. You\'re falling apart."\n\nAlex recognizes this voice — the critic that never sleeps.',
    nextId: 'maya_arrives',
  ),

  // Branch B — pick up
  'c1b_1': StoryNode(
    id: 'c1b_1',
    speaker: Speaker.alex,
    mood: _SceneMood.dusk,
    text: '"Hey..."',
    nextId: 'c1b_2',
  ),
  'c1b_2': StoryNode(
    id: 'c1b_2',
    speaker: Speaker.maya,
    mood: _SceneMood.dusk,
    text: '"Alex. I\'m outside your door with coffee. Can I come in?"',
    nextId: 'maya_arrives',
    xpOnArrive: 5,
  ),

  // Branch C — text back
  'c1c_1': StoryNode(
    id: 'c1c_1',
    speaker: Speaker.narrator,
    mood: _SceneMood.dark,
    text: 'Three dots appear instantly. Then:\n"I\'m coming over."',
    nextId: 'maya_arrives',
  ),

  // Convergence
  'maya_arrives': StoryNode(
    id: 'maya_arrives',
    speaker: Speaker.maya,
    mood: _SceneMood.dusk,
    text: 'Maya is standing in the doorway, coat still on, holding two cups.\n\n"You look terrible. And I say that with love."',
    nextId: 'alex_honest_choice',
  ),
  'alex_honest_choice': StoryNode(
    id: 'alex_honest_choice',
    speaker: Speaker.maya,
    mood: _SceneMood.dusk,
    text: '"Talk to me. What\'s going on?"',
    choices: [
      StoryChoice(
        text: '😶  "I\'m fine. Just tired."',
        nextId: 'maya_sees_through',
        xpBonus: 5,
        insight: '"I\'m fine" is often the loneliest thing we say.',
      ),
      StoryChoice(
        text: '💔  "I don\'t know where to start."',
        nextId: 'maya_gentle',
        xpBonus: 20,
        insight: 'Vulnerability is not weakness — it\'s the beginning of connection.',
      ),
      StoryChoice(
        text: '🌀  "Everything just feels... pointless."',
        nextId: 'maya_holds_space',
        xpBonus: 15,
        insight: 'Naming the feeling is the first step. You just did something hard.',
      ),
    ],
  ),

  'maya_sees_through': StoryNode(
    id: 'maya_sees_through',
    speaker: Speaker.maya,
    mood: _SceneMood.dusk,
    text: '"Alex. I\'ve known you for ten years. You\'re not fine."\n\nShe sits next to Alex and doesn\'t leave.',
    nextId: 'maya_suggestion',
  ),
  'maya_gentle': StoryNode(
    id: 'maya_gentle',
    speaker: Speaker.maya,
    mood: _SceneMood.dusk,
    text: '"That\'s okay. We don\'t have to figure it all out. I just needed you to know I\'m here."',
    nextId: 'maya_suggestion',
    xpOnArrive: 10,
  ),
  'maya_holds_space': StoryNode(
    id: 'maya_holds_space',
    speaker: Speaker.maya,
    mood: _SceneMood.dusk,
    text: 'Maya doesn\'t try to fix it. She just nods.\n\n"Yeah. Sometimes it feels that way."\n\nFor a moment, Alex doesn\'t feel so alone.',
    nextId: 'maya_suggestion',
    xpOnArrive: 10,
  ),
  'maya_suggestion': StoryNode(
    id: 'maya_suggestion',
    speaker: Speaker.maya,
    mood: _SceneMood.dusk,
    text: '"There\'s this therapist — Dr. Chen. She helped me after my dad\'s diagnosis. I think... it might be worth a call?"',
    nextId: 'ch1_end',
  ),
  'ch1_end': StoryNode(
    id: 'ch1_end',
    speaker: Speaker.narrator,
    mood: _SceneMood.dawn,
    text: 'Alex doesn\'t say yes immediately. But something shifts — a crack of light in a long-dark room.\n\n✨ Chapter 1 Complete',
    nextId: 'ch2_intro',
    xpOnArrive: 30,
  ),

  // ── CHAPTER 2: First Steps ────────────────────────────────────────────────
  'ch2_intro': StoryNode(
    id: 'ch2_intro',
    speaker: Speaker.narrator,
    mood: _SceneMood.dusk,
    text: 'Two weeks later.\n\nAlex is sitting in a small waiting room. Clean walls. A fern in the corner. The smell of chamomile tea.\n\nThe door opens.',
    nextId: 'chen_intro',
  ),
  'chen_intro': StoryNode(
    id: 'chen_intro',
    speaker: Speaker.drChen,
    mood: _SceneMood.dawn,
    text: '"Alex? I\'m Dr. Chen. Come on in."\n\nHer office is warm. No clipboard. Just two chairs facing each other.',
    nextId: 'chen_question',
  ),
  'chen_question': StoryNode(
    id: 'chen_question',
    speaker: Speaker.drChen,
    mood: _SceneMood.dawn,
    text: '"So. What brings you here today? And there are no wrong answers."',
    choices: [
      StoryChoice(
        text: '🤷  "My friend basically made me come."',
        nextId: 'chen_a1',
        xpBonus: 10,
        insight: 'Honesty in therapy — even about resistance — is itself a breakthrough.',
      ),
      StoryChoice(
        text: '😞  "I\'ve been struggling. A lot."',
        nextId: 'chen_b1',
        xpBonus: 20,
        insight: 'Naming the struggle is not defeat. It\'s the first act of taking care of yourself.',
      ),
      StoryChoice(
        text: '😤  "I don\'t really believe therapy works."',
        nextId: 'chen_c1',
        xpBonus: 15,
        insight: 'Skepticism is welcome in therapy. Curiosity is all that\'s required.',
      ),
    ],
  ),

  'chen_a1': StoryNode(
    id: 'chen_a1',
    speaker: Speaker.drChen,
    mood: _SceneMood.dawn,
    text: '"Good friends are rare. What made her worry about you?"',
    nextId: 'chen_core',
  ),
  'chen_b1': StoryNode(
    id: 'chen_b1',
    speaker: Speaker.drChen,
    mood: _SceneMood.dawn,
    text: '"Thank you for saying that. It takes courage to walk through that door."',
    nextId: 'chen_core',
    xpOnArrive: 5,
  ),
  'chen_c1': StoryNode(
    id: 'chen_c1',
    speaker: Speaker.drChen,
    mood: _SceneMood.dawn,
    text: '"That\'s fair. I don\'t ask for belief — just a willingness to explore. Can you do that?"',
    nextId: 'chen_core',
  ),

  'chen_core': StoryNode(
    id: 'chen_core',
    speaker: Speaker.drChen,
    mood: _SceneMood.dawn,
    text: '"Tell me — when did you last feel like yourself?"',
    nextId: 'alex_remembers',
  ),
  'alex_remembers': StoryNode(
    id: 'alex_remembers',
    speaker: Speaker.alex,
    mood: _SceneMood.dawn,
    text: 'Alex thinks for a long time.\n\n"...Maybe two years ago? Before the promotion. Before everything got... loud."',
    nextId: 'chen_tool',
  ),
  'chen_tool': StoryNode(
    id: 'chen_tool',
    speaker: Speaker.drChen,
    mood: _SceneMood.dawn,
    text: '"That\'s actually very useful. There was a \'before\'. Which means you have a self to return to."\n\nShe hands Alex a small card.\n\n"I want to teach you something called cognitive defusion. When the inner critic speaks, you learn to see the thought — not be the thought."',
    nextId: 'chen_homework',
  ),
  'chen_homework': StoryNode(
    id: 'chen_homework',
    speaker: Speaker.drChen,
    mood: _SceneMood.dawn,
    text: '"This week — whenever a harsh thought appears, try saying: \'I notice I\'m having the thought that...\'\n\nIt creates a tiny gap. That gap is where you live."',
    nextId: 'ch2_choice',
  ),
  'ch2_choice': StoryNode(
    id: 'ch2_choice',
    speaker: Speaker.narrator,
    mood: _SceneMood.dawn,
    text: 'Walking home, the familiar dread starts to rise.\n\n"I\'m a burden. People would be better without me."\n\nWhat does Alex do?',
    choices: [
      StoryChoice(
        text: '🌀  Let the thought take over.',
        nextId: 'ch2_struggle',
        xpBonus: 5,
        insight: 'Even recognizing when we\'re stuck is progress.',
      ),
      StoryChoice(
        text: '🔬  "I notice I\'m having the thought that..."',
        nextId: 'ch2_gap',
        xpBonus: 25,
        insight: 'Cognitive defusion — you just practiced a real CBT technique.',
      ),
      StoryChoice(
        text: '📞  Call Maya.',
        nextId: 'ch2_maya_call',
        xpBonus: 20,
        insight: 'Reaching out interrupts the spiral. Connection is a coping skill.',
      ),
    ],
  ),

  'ch2_struggle': StoryNode(
    id: 'ch2_struggle',
    speaker: Speaker.inner,
    mood: _SceneMood.dark,
    text: 'The thoughts flood in. The voice is loud.\n\nBut then — something Dr. Chen said surfaces: "Even when you\'re struggling, you\'re still choosing to try."',
    nextId: 'ch2_end',
  ),
  'ch2_gap': StoryNode(
    id: 'ch2_gap',
    speaker: Speaker.alex,
    mood: _SceneMood.dawn,
    text: '"I notice I\'m having the thought that I\'m a burden."\n\nSomething shifts. The thought is still there — but it feels smaller. Like a cloud, not a ceiling.',
    nextId: 'ch2_end',
    xpOnArrive: 10,
  ),
  'ch2_maya_call': StoryNode(
    id: 'ch2_maya_call',
    speaker: Speaker.maya,
    mood: _SceneMood.dawn,
    text: '"Hey! How\'d therapy go?"\n\nJust hearing her voice, the spiral slows.',
    nextId: 'ch2_end',
    xpOnArrive: 5,
  ),

  'ch2_end': StoryNode(
    id: 'ch2_end',
    speaker: Speaker.narrator,
    mood: _SceneMood.dawn,
    text: 'It\'s not fixed. It\'s not even close. But something is different.\n\nAlex is trying. And trying is enough.\n\n✨ Chapter 2 Complete',
    nextId: 'ch3_intro',
    xpOnArrive: 40,
  ),

  // ── CHAPTER 3: Sunrise ────────────────────────────────────────────────────
  'ch3_intro': StoryNode(
    id: 'ch3_intro',
    speaker: Speaker.narrator,
    mood: _SceneMood.warm,
    text: 'Six weeks later.\n\nAlex\'s apartment looks different. A plant on the windowsill. An actual made bed. A journal on the nightstand, half-full.',
    nextId: 'ch3_morning',
  ),
  'ch3_morning': StoryNode(
    id: 'ch3_morning',
    speaker: Speaker.inner,
    mood: _SceneMood.warm,
    text: '"I slept."\n\nNot perfectly. Not without the 3 AM thoughts. But slept.\n\nThat feels like a miracle.',
    nextId: 'ch3_crisis',
  ),
  'ch3_crisis': StoryNode(
    id: 'ch3_crisis',
    speaker: Speaker.narrator,
    mood: _SceneMood.dusk,
    text: 'Then — a text from the boss. The big presentation is moved up. Today. Two hours from now.\n\nThe old panic begins to rise.',
    nextId: 'ch3_choice',
  ),
  'ch3_choice': StoryNode(
    id: 'ch3_choice',
    speaker: Speaker.narrator,
    mood: _SceneMood.dusk,
    text: 'Alex feels the familiar dread. But this time — has a choice.',
    choices: [
      StoryChoice(
        text: '🫁  Box breathing (4-4-4-4)',
        nextId: 'ch3_breath',
        xpBonus: 25,
        insight: 'Controlled breathing activates the parasympathetic nervous system — your body\'s natural calm response.',
      ),
      StoryChoice(
        text: '📓  Write it out first.',
        nextId: 'ch3_journal',
        xpBonus: 20,
        insight: 'Expressive writing reduces anxiety by externalizing thoughts and giving them form.',
      ),
      StoryChoice(
        text: '☎️  Five-minute call with Dr. Chen\'s voicemail tip.',
        nextId: 'ch3_chen_tip',
        xpBonus: 20,
        insight: 'Using your support system proactively — not just in crisis — builds resilience.',
      ),
    ],
  ),

  'ch3_breath': StoryNode(
    id: 'ch3_breath',
    speaker: Speaker.alex,
    mood: _SceneMood.dawn,
    text: 'Inhale... 2... 3... 4.\nHold... 2... 3... 4.\nExhale... 2... 3... 4.\nHold... 2... 3... 4.\n\nThe panic doesn\'t vanish. But it becomes... workable.',
    nextId: 'ch3_presentation',
    xpOnArrive: 10,
  ),
  'ch3_journal': StoryNode(
    id: 'ch3_journal',
    speaker: Speaker.alex,
    mood: _SceneMood.dawn,
    text: '"I\'m scared. I might mess up. And that would be okay. I\'ve survived worse."\n\nSeeing the words on paper — they lose their power.',
    nextId: 'ch3_presentation',
    xpOnArrive: 10,
  ),
  'ch3_chen_tip': StoryNode(
    id: 'ch3_chen_tip',
    speaker: Speaker.drChen,
    mood: _SceneMood.dawn,
    text: '"What you\'re feeling is excitement in a different costume. Your body is ready — trust the preparation you\'ve done."',
    nextId: 'ch3_presentation',
    xpOnArrive: 10,
  ),

  'ch3_presentation': StoryNode(
    id: 'ch3_presentation',
    speaker: Speaker.narrator,
    mood: _SceneMood.warm,
    text: 'Alex walks into the room.\n\nVoice shaking slightly — but there.\nHands steady — well, steadier.\n\nThe presentation goes well. Not perfectly. Perfectly-well.',
    nextId: 'epilogue_1',
    xpOnArrive: 20,
  ),

  // ── Epilogue ──────────────────────────────────────────────────────────────
  'epilogue_1': StoryNode(
    id: 'epilogue_1',
    speaker: Speaker.narrator,
    mood: _SceneMood.bright,
    text: 'That evening, Alex sits by the window.\n\nThe same window. The same city. But seen through different eyes.',
    nextId: 'epilogue_2',
  ),
  'epilogue_2': StoryNode(
    id: 'epilogue_2',
    speaker: Speaker.inner,
    mood: _SceneMood.bright,
    text: '"I\'m not healed. I know that.\n\nBut I\'m not where I was.\n\nAnd the distance between those two things — that\'s mine."',
    nextId: 'epilogue_3',
  ),
  'epilogue_3': StoryNode(
    id: 'epilogue_3',
    speaker: Speaker.narrator,
    mood: _SceneMood.bright,
    text: 'Alex opens the journal and writes one line:\n\n"Today I chose myself. Even imperfectly. That counts."\n\n🌅 The Journey Continues.',
    nextId: 'finale',
    xpOnArrive: 50,
  ),
  'finale': StoryNode(
    id: 'finale',
    speaker: Speaker.narrator,
    mood: _SceneMood.bright,
    text: '',
    xpOnArrive: 0,
  ),
};

// ─── Screen ───────────────────────────────────────────────────────────────────

class StoryGameScreen extends StatefulWidget {
  final String userId;
  final String gameId;
  final Map<String, dynamic> gameConfig;

  const StoryGameScreen({
    super.key,
    required this.userId,
    required this.gameId,
    required this.gameConfig,
  });

  @override
  State<StoryGameScreen> createState() => _StoryGameScreenState();
}

class _StoryGameScreenState extends State<StoryGameScreen>
    with TickerProviderStateMixin {
  final GameService _gameService = GameService();
  final AudioPlayer _sfx = AudioPlayer();

  String _currentId = 'intro';
  int _totalXp = 0;
  bool _showChoice = false;
  bool _showInsight = false;
  String? _pendingInsight;
  String? _pendingNextId;

  // Typewriter
  String _displayedText = '';
  bool _typingDone = false;
  Timer? _typeTimer;

  // Animations
  late AnimationController _fadeCtrl;
  late AnimationController _slideCtrl;
  late AnimationController _choiceCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  static const _chapterBreaks = {'ch2_intro', 'ch3_intro', 'epilogue_1'};

  StoryNode get _current => _story[_currentId]!;

  @override
  void initState() {
    super.initState();

    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _slideCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _choiceCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));

    _enterNode(_currentId);
  }

  @override
  void dispose() {
    _typeTimer?.cancel();
    _fadeCtrl.dispose();
    _slideCtrl.dispose();
    _choiceCtrl.dispose();
    _sfx.dispose();
    super.dispose();
  }

  void _enterNode(String id) {
    final node = _story[id]!;
    setState(() {
      _currentId = id;
      _displayedText = '';
      _typingDone = false;
      _showChoice = false;
      _showInsight = false;
      _totalXp += node.xpOnArrive;
    });

    _fadeCtrl.forward(from: 0);
    _slideCtrl.forward(from: 0);
    _startTyping(node.text);

    if (_chapterBreaks.contains(id)) {
      _playSfx('audio/success_chime.mp3');
    }
    if (node.id == 'finale') {
      _onComplete();
    }
  }

  void _startTyping(String text) {
    _typeTimer?.cancel();
    if (text.isEmpty) {
      setState(() => _typingDone = true);
      return;
    }
    int i = 0;
    _typeTimer = Timer.periodic(const Duration(milliseconds: 22), (t) {
      if (!mounted) { t.cancel(); return; }
      if (i >= text.length) {
        t.cancel();
        setState(() => _typingDone = true);
        if (_current.choices.isEmpty) {
          // Auto-show tap hint
        } else {
          _choiceCtrl.forward(from: 0);
          setState(() => _showChoice = true);
        }
      } else {
        setState(() => _displayedText = text.substring(0, i + 1));
        i++;
      }
    });
  }

  void _skipTyping() {
    if (_typingDone) return;
    _typeTimer?.cancel();
    setState(() {
      _displayedText = _current.text;
      _typingDone = true;
    });
    if (_current.choices.isNotEmpty) {
      _choiceCtrl.forward(from: 0);
      setState(() => _showChoice = true);
    }
  }

  void _tapContinue() {
    if (!_typingDone) { _skipTyping(); return; }
    if (_showInsight) { _commitNext(); return; }
    if (_current.choices.isNotEmpty) return; // wait for choice tap
    final next = _current.nextId;
    if (next != null) {
      _enterNode(next);
    }
  }

  void _selectChoice(StoryChoice choice) {
    HapticFeedback.mediumImpact();
    _playSfx('audio/bell_ting.mp3');
    setState(() {
      _totalXp += choice.xpBonus;
      _showChoice = false;
      _pendingNextId = choice.nextId;
    });
    if (choice.insight != null) {
      setState(() {
        _showInsight = true;
        _pendingInsight = choice.insight;
      });
    } else {
      _enterNode(choice.nextId);
    }
  }

  void _commitNext() {
    setState(() { _showInsight = false; _pendingInsight = null; });
    if (_pendingNextId != null) {
      _enterNode(_pendingNextId!);
      _pendingNextId = null;
    }
  }

  Future<void> _playSfx(String path) async {
    try { await _sfx.play(AssetSource(path)); } catch (_) {}
  }

  Future<void> _onComplete() async {
    await _playSfx('audio/success_chime.mp3');
    try {
      await _gameService.saveGameSession(
        userId: widget.userId,
        gameId: widget.gameId,
        score: _totalXp,
        streak: 1,
        duration: const Duration(minutes: 10),
      );
    } catch (_) {}
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final node = _current;
    if (node.id == 'finale') return _buildFinale();

    return Scaffold(
      body: GestureDetector(
        onTap: _tapContinue,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: _gradientFor(node.mood),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(child: _buildSceneArea(node)),
                if (_showInsight) _buildInsightBanner(),
                if (!_showInsight) _buildDialogueBox(node),
                if (_showChoice && !_showInsight) _buildChoices(node),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _showExitDialog(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close_rounded,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome_rounded,
                    color: const Color(0xFFFBBF24), size: 14.sp),
                SizedBox(width: 4.w),
                Text(
                  '$_totalXp XP',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSceneArea(StoryNode node) {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnim,
        child: _buildCharacterAvatar(node.speaker),
      ),
    );
  }

  Widget _buildCharacterAvatar(Speaker speaker) {
    final info = _speakerInfo(speaker);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 90.w,
          height: 90.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.15),
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.3), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(info.$1, style: TextStyle(fontSize: 42.sp)),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            info.$2,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.9),
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogueBox(StoryNode node) {
    return SlideTransition(
      position: _slideAnim,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Container(
          margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
          padding: EdgeInsets.all(18.w),
          constraints: BoxConstraints(minHeight: 120.h, maxHeight: 220.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.2), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _displayedText,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15.sp,
                    color: Colors.white,
                    height: 1.6,
                    fontStyle: node.speaker == Speaker.inner
                        ? FontStyle.italic
                        : FontStyle.normal,
                  ),
                ),
                if (_typingDone && node.choices.isEmpty && node.nextId != null)
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Tap to continue',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                            color: Colors.white.withValues(alpha: 0.5),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.arrow_forward_ios_rounded,
                            size: 10.sp,
                            color: Colors.white.withValues(alpha: 0.5)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoices(StoryNode node) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _choiceCtrl, curve: Curves.easeOut),
      child: Column(
        children: node.choices.map((c) {
          return GestureDetector(
            onTap: () => _selectChoice(c),
            child: Container(
              width: double.infinity,
              margin:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      c.text,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (c.xpBonus > 0)
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBBF24).withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '+${c.xpBonus}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFBBF24),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInsightBanner() {
    return GestureDetector(
      onTap: _commitNext,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0D9488), Color(0xFF0F766E)],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0D9488).withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('💡', style: TextStyle(fontSize: 20.sp)),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Therapy Insight',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.7),
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    _pendingInsight ?? '',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Tap to continue →',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinale() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('🌅', style: TextStyle(fontSize: 72.sp)),
                SizedBox(height: 24.h),
                Text(
                  'The Journey Continues',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'You walked with Alex through the hardest chapter.\nNow write yours.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 32.h),
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _XpStat(emoji: '⭐', label: 'XP Earned', value: '$_totalXp'),
                      _XpStat(emoji: '📖', label: 'Chapters', value: '3'),
                      _XpStat(emoji: '💡', label: 'Insights', value: '9'),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D9488),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r)),
                      elevation: 0,
                    ),
                    child: Text(
                      'Back to Wellness Hub',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text(
          'Leave Alex\'s story?',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        content: Text(
          'Your progress won\'t be saved.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.sp,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.gmStay,
                style: TextStyle(
                    fontFamily: 'Poppins', color: const Color(0xFF0D9488))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.gmLeave,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white.withValues(alpha: 0.5))),
          ),
        ],
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  List<Color> _gradientFor(_SceneMood mood) {
    switch (mood) {
      case _SceneMood.dark:
        return [const Color(0xFF0F0F23), const Color(0xFF1A1035)];
      case _SceneMood.dusk:
        return [const Color(0xFF1F1535), const Color(0xFF2D1B4E)];
      case _SceneMood.dawn:
        return [const Color(0xFF1B2F4E), const Color(0xFF1E3A5F)];
      case _SceneMood.warm:
        return [const Color(0xFF1A2E1A), const Color(0xFF0D3025)];
      case _SceneMood.bright:
        return [const Color(0xFF0D2B3E), const Color(0xFF0D4F4A)];
    }
  }

  (String, String) _speakerInfo(Speaker s) {
    switch (s) {
      case Speaker.narrator:
        return ('📖', 'NARRATOR');
      case Speaker.alex:
        return ('🧑', 'ALEX');
      case Speaker.maya:
        return ('👩', 'MAYA');
      case Speaker.drChen:
        return ('👩‍⚕️', 'DR. CHEN');
      case Speaker.self_:
        return ('🧑', 'YOU');
      case Speaker.inner:
        return ('💭', 'INNER VOICE');
    }
  }
}

class _XpStat extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;

  const _XpStat(
      {required this.emoji, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: TextStyle(fontSize: 22.sp)),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10.sp,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
