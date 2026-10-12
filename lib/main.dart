import 'package:flutter/material.dart';

// Bước 1: class Student với các trường nullable
class Student {
  final String name;
  final String? email;
  final String? phone;

  Student({required this.name, this.email, this.phone});
}

// Bước 2: danh sách 5 sinh viên, có người thiếu email hoặc SĐT (null)
final List<Student> students = [
  Student(name: 'Nguyễn Văn An', email: 'an@sv.edu.vn', phone: '0901 234 567'),
  Student(name: 'Trần Thị Bình', email: null, phone: '0912 888 999'),
  Student(name: 'Lê Minh Chi', email: 'chi@sv.edu.vn', phone: null),
  Student(name: 'Phạm Quốc Dũng', email: null, phone: null),
  Student(name: 'Võ Thanh Em', email: 'em@sv.edu.vn', phone: '0933 111 222'),
];

const Color navy = Color(0xFF2B4478);
const Color red = Color(0xFFC0392B);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  // Một dòng thông tin: "Email: ..." hoặc "SĐT: ..."
  // Bước 4: dùng ?? để thay null bằng "Chưa cập nhật"
  Widget _infoRow(String label, String? value) {
    final bool isMissing = value == null;
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
        Text(
          value ?? 'Chưa cập nhật',
          style: TextStyle(
            fontSize: 13,
            color: isMissing ? red : Colors.black54,
            fontStyle: isMissing ? FontStyle.italic : FontStyle.normal,
          ),
        ),
      ],
    );
  }

  // Thẻ của một sinh viên
  Widget _buildStudentCard(Student s) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          _infoRow('Email', s.email),
          const SizedBox(height: 2),
          _infoRow('SĐT', s.phone),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Bước 5: dùng for để đếm số sinh viên thiếu email
    int missingEmail = 0;
    for (final s in students) {
      if (s.email == null) {
        missingEmail++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: const Text(
          'Danh sách sinh viên',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFF2F4F8),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Bước 3: dùng for để tạo các thẻ sinh viên
            for (final s in students) _buildStudentCard(s),

            const SizedBox(height: 4),

            // Thanh tổng kết ở cuối danh sách
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFE6EBF5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Tổng: '),
                      Text(
                        '${students.length} sinh viên',
                        style: const TextStyle(
                          color: navy,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Thiếu email: '),
                      Text(
                        '$missingEmail',
                        style: const TextStyle(
                          color: red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}