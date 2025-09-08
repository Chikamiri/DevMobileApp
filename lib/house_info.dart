import 'package:flutter/material.dart';

class HouseInfo extends StatelessWidget {
  const HouseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3FA),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 320,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      ),
                      child: Image.asset('assets/image.png', fit: BoxFit.cover),
                    ),
                  ),

                  Positioned(
                    left: 16,
                    top: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 16,
                    top: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Museum',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.star, color: Colors.orange, size: 18),
                              SizedBox(width: 4),
                              Text(
                                '4.0',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '727, Wysi Str., Rue Saint-Jacques, Montréal, Manchester United, Vietnam, 696969',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _feature(Icons.bed_outlined, '3'),
                          const SizedBox(width: 18),
                          _feature(Icons.bathtub_outlined, '3'),
                          const SizedBox(width: 18),
                          _feature(Icons.balcony, '2'),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Price
                      Text(
                        '\$ 727/month',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // About
                      const Text(
                        'About House',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Một ngôi miếu cổ kính toạ lạc giữa lòng Hà Lội, được bao bọc bởi hàng cây cổ thụ xanh mát quanh năm. Kiến trúc mang đậm dấu ấn truyền thống với mái ngói cong, những cột gỗ chạm khắc tinh xảo và sân lát gạch đỏ sạch sẽ. Bên trong, chính điện rộng rãi, thoáng đãng, có bàn thờ trang nghiêm cùng hương khói trầm mặc. Không gian phụ xung quanh được bố trí hài hòa, thuận tiện cho việc tổ chức các hoạt động tâm linh, lễ hội hay sự kiện văn hóa.',
                        textAlign: TextAlign.left,
                      ),

                      const SizedBox(height: 20),

                      // Listing agent
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              'https://scontent.fhan15-2.fna.fbcdn.net/v/t39.30808-6/455070906_7807370106058215_1025026447290910479_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeHEcv72f59MGTU_dl5XXSGfI_nDDZwgbEIj-cMNnCBsQpSE6vLi2nqCO2-9AbN9YTho41K6V-oLfgw2-OffBWVC&_nc_ohc=31YVNd76lpsQ7kNvwFq4yZ-&_nc_oc=Admhgkg9mUQcsO4rIM0O-44AShIVHhTb45vjrCUkwKxXA0hVEYoc3ctTCfbEDRLpbznwQTzNYO5doY5lTFF2ZZC8&_nc_zt=23&_nc_ht=scontent.fhan15-2.fna&_nc_gid=seJbe568toII2sb0JeSENw&oh=00_AfZOF2KoKH8I6qbm3ZghgkjumV8_SN6FG8Wxe_gCwDciXA&oe=68C374AB',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Nguyễn Đức Hải (DevGame Trùm Thế Giới)',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Owner',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),

                          Row(
                            children: [
                              _roundIconButton(Icons.call),
                              const SizedBox(width: 8),
                              _roundIconButton(Icons.message_outlined),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: SizedBox(
          height: 56,
          width: screenW - 32,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _feature(IconData icon, String number) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Colors.grey[800]),
        const SizedBox(width: 6),
        Text(number, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  static Widget _roundIconButton(IconData icon) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 44,
        height: 44,
        child: IconButton(
          onPressed: () {},
          icon: Icon(icon, size: 20, color: Colors.grey[800]),
        ),
      ),
    );
  }
}
