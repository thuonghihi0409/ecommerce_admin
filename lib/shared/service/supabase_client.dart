import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final embeddingModel = GenerativeModel(
  model: 'embedding-001',
  apiKey: dotenv.env['GEMINI_API_KEY']!,
);

Future<void> generateEmbeddings() async {
  final products = await supabase.from('Products').select();
  for (final product in products) {
    final reviews = await supabase
        .from('Reviews')
        .select('content')
        .eq('product_id', product['id']);
    final reviewText = reviews.map((r) => r['content']).join(", ");
    final text = '''
Sản phẩm: ${product['product_name']}
Giá: ${product['price']} VNĐ
Số lượng tồn: ${product['stock']}
Đánh giá trung bình: ${product['avg_rating']}
Nhận xét: $reviewText
''';

    // 4. Gọi Gemini để sinh embedding
    final result = await embeddingModel.embedContent(
      Content.text(text),
      taskType: TaskType.retrievalDocument,
    );

    final embedding = result.embedding; // List<double> (768 số)

    // 5. Lưu vào bảng knowledge_base
    await supabase.from('knowledge_base').insert({
      'content': text,
      'metadata': {
        'product_id': product['id'],
      },
      'embedding': embedding.values,
    });

    log("Đã thêm knowledge cho: ${product['name']}");
  }
}
