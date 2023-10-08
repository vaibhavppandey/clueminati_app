import "package:cloud_firestore/cloud_firestore.dart" show DocumentSnapshot;

class Team {
  final String uid;
  final String name;
  // final List<String> memberUids;
  final int score;

  Team({
    required this.uid,
    required this.name,
    // required this.memberUids,
    required this.score,
  });
  factory Team.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    // final members = List<String>.from(data['memberUids'] as List);
    return Team(
      uid: snapshot.id,
      name: (data['name'] as String?)!.trim(),
      // memberUids: members,
      score: (data['score'] as int?)!,
      // score: int.parse(data['score'] as String? ?? '0'),
    );
  }
}
