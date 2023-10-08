import "package:cloud_firestore/cloud_firestore.dart" show DocumentSnapshot;

class Player {
  final String uid;
  final String email;
  final String teamId;

  Player({
    required this.uid,
    required this.email,
    required this.teamId,
  });
  factory Player.fromSnapshot(DocumentSnapshot snapshot) {
    final docData = snapshot.data() as Map<String, dynamic>;
    return Player(
      uid: snapshot.id,
      email: (docData['email'] as String?)!.trim(),
      teamId: (docData['teamId'] as String?)!.trim(),
    );
  }
}
