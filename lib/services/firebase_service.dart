import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clueminati_app/data/models/team.dart';
// import 'package:clueminati_app/data/models/player.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:logger/logger.dart';

Logger _logger = Logger();

class FirebaseAppNotifier extends ChangeNotifier {
  FirebaseAppNotifier() {
    _initializeUserChangesListener();
    _startPeriodicFetch();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _initialized = false;
  bool get initialized => _initialized;

  bool _loggedIn = false;
  // Player? _player;
  Team? _team;

  int? _rank;
  List<Team>? _teams;

  bool get loggedIn => _loggedIn;
  // Player get player => _player!;
  Team get team => _team!;

  int get rank => _rank!;
  List<Team> get teams => _teams!;

  Timer? _periodicTimer; // Declare a Timer variable

  Future<void> _initializeUserChangesListener() async {
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
    _auth.userChanges().listen((User? user) async {
      _initialized = false;
      if (user != null) {
        _loggedIn = true;
        await _loadAppState(user);
        await _loadLeaderboardState();
        _initialized = true;
      } else {
        reset();
        _initialized = true;
      }
      notifyListeners();
    });
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        _loggedIn = true;
      }
    } catch (err) {
      _logger.d(err.toString());
      _loggedIn = false;
    } finally {
      _initialized = false;
      notifyListeners();
    }
  }

  Future<int> _fetchUserRank() async {
    DocumentSnapshot userTeam =
        await _firestore.collection('teams').doc(team.uid).get();
    int userScore = userTeam['score'] as int;
    QuerySnapshot teamsWithHigherScore = await _firestore
        .collection('teams')
        .where('score', isGreaterThan: userScore)
        .get();
    return teamsWithHigherScore.docs.length + 1;
  }

  Future<List<Team>> _fetchTeams() async {
    QuerySnapshot topTeamsSnapshot = await _firestore
        .collection('teams')
        .orderBy('score', descending: true)
        // .limit(5)
        .get();
    return topTeamsSnapshot.docs.map((doc) => Team.fromSnapshot(doc)).toList();
  }

  void deInitialize() {
    _initialized = false;
  }

  void signOut() {
    // _initialized = false;
    // notifyListeners();
    // await Future.delayed(const Duration(seconds: 2));
    _auth.signOut();
  }

  Future<void> _loadAppState(User user) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('teams').doc(user.uid).get();
    _logger.d(snapshot.data());
    _team = Team.fromSnapshot(snapshot);
    // _player = Player.fromSnapshot(snapshot);
    // snapshot = await _firestore.collection('teams').doc(_player?.teamId).get();
    // _logger.d(snapshot.data());
    // _team = Team.fromSnapshot(snapshot);
  }

  Future<void> _loadLeaderboardState() async {
    _rank = await _fetchUserRank();
    _teams = await _fetchTeams();
  }

  void _startPeriodicFetch() {
    _periodicTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) async {
        await _loadLeaderboardState();
      },
    );
  }

  @override
  void dispose() {
    _periodicTimer?.cancel();
    super.dispose();
  }

  void reset() {
    _loggedIn = false;
    // _player = null;
    _team = null;
    _rank = null;
    _teams = null;
  }
}
