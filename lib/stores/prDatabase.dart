import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:timetable_2_flutter_admin/functions/findTime.dart';

class PRDatabase {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  /*late*/ Stream<List<Map<String, dynamic>>> assignStream;
  /*late*/ Stream<List<Map<String, dynamic>>> quizStream;
  /*late*/ Stream<List<Map<String, dynamic>>> classStream;
  /*late*/ Stream<List<Map<String, dynamic>>> vivaStream;
  /*late*/ Stream<List<Map<String, dynamic>>> labStream;

  /*late*/ Stream<List<List<Map<String, dynamic>>>> combinedStream;
  PRDatabase() {
    Stream<List<Map<String, dynamic>>> assignStream = streamTransform(
        _db
            .collection('Timetable')
            .doc('B.Tech')
            .collection('First Year')
            .doc('Semester 1')
            .collection('CSE')
            .doc('Group 1')
            .collection('Assignment')
            .where('Status', isEqualTo: 'Pending')
            .snapshots(),
        "Assignment");
    Stream<List<Map<String, dynamic>>> quizStream = streamTransform(
        FirebaseFirestore.instance
            .collection('Timetable')
            .doc('B.Tech')
            .collection('First Year')
            .doc('Semester 1')
            .collection('CSE')
            .doc('Group 1')
            .collection('Quiz')
            .where('Status', isEqualTo: 'Pending')
            .snapshots(),
        "Quiz");
    Stream<List<Map<String, dynamic>>> classStream = streamTransform(
        _db
            .collection('Timetable')
            .doc('B.Tech')
            .collection('First Year')
            .doc('Semester 1')
            .collection('CSE')
            .doc('Group 1')
            .collection('Class')
            .where('Status', isEqualTo: 'Pending')
            .snapshots(),
        "Class");
    Stream<List<Map<String, dynamic>>> vivaStream = streamTransform(
        _db
            .collection('Timetable')
            .doc('B.Tech')
            .collection('First Year')
            .doc('Semester 1')
            .collection('CSE')
            .doc('Group 1')
            .collection('Viva')
            .where('Status', isEqualTo: 'Pending')
            .snapshots(),
        "Viva");
    Stream<List<Map<String, dynamic>>> labStream = streamTransform(
        _db
            .collection('Timetable')
            .doc('B.Tech')
            .collection('First Year')
            .doc('Semester 1')
            .collection('CSE')
            .doc('Group 1')
            .collection('Lab')
            .where('Status', isEqualTo: 'Pending')
            .snapshots(),
        "Lab");
    combinedStream = classStream
        .combineLatestAll([assignStream, quizStream, labStream, vivaStream]);
  }

  Stream<List<Map<String, dynamic>>> streamTransform(
      Stream<QuerySnapshot/*<Map<String, dynamic>>*/ > source,
      String type) async* {
    await for (QuerySnapshot snapshot in source) {
      List<Map<String, dynamic>> list = [];
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        if (doc.data() != null) {
          Map<String, dynamic> map = doc.data(); //as Map<String, dynamic>;
          map['Platform'] ??= " ";
          map['User'] ??= " ";
          map['User'] ??= "Unknown User";
          map['Date Added'] ??= "Today";
          map['Type'] = type;
          map['ID'] = doc.id;
          if (type == "Class" || type == "Lab") {
            map['Time'] = classTime(map['Slots']);
          } else if (type == "Assignment") {
            map['Time'] = findTime(map['Deadline']);
            map['Duration'] = map['Deadline'];
          } else {
            map['Time'] = findTime(map['Time']);
          }
          list.add(map);
        }
      }
      yield list;
    }
  }

  void approveChange(String docID, String type) {
    _db
        .collection('Timetable')
        .doc('B.Tech')
        .collection('First Year')
        .doc('Semester 1')
        .collection('CSE')
        .doc('Group 1')
        .collection(type)
        .doc(docID)
        .update({'Status': 'Approved'});
  }

  void rejectChange(String docID, String type) {
    _db
        .collection('Timetable')
        .doc('B.Tech')
        .collection('First Year')
        .doc('Semester 1')
        .collection('CSE')
        .doc('Group 1')
        .collection(type)
        .doc(docID)
        .update({'Status': 'Rejected'});
  }

  void printTest() {
    print("Printing from DB");
  }
}
