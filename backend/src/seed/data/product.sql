USE [hasaki_db]
GO

INSERT INTO [dbo].[products] ([name], [description], [price], [discount_price], [category_id], [rating], [image_url], [variants])
VALUES
(N'Kem Dưỡng Da Ban Đêm', N'Kem dưỡng da chuyên sâu làm trắng và phục hồi da ban đêm', 450000.00, 399000.00, 1, 4.5, 'https://magicskin.vn/wp-content/uploads/2024/06/post-5.png', N'{"size": "50ml"}'),
(N'Sữa Rửa Mặt Trà Xanh', N'Sữa rửa mặt chiết xuất từ trà xanh, làm sạch sâu', 180000.00, 150000.00, 1, 4.8, 'https://thenaturebook.vn/mediacenter/media/2640/files/SUA%20RUA%20MAT%20THUAN%20CHAY%20NATURE%20BOOK%20(1).jpg', N'{"size": "100ml"}'),
(N'Serum Vitamin C', N'Serum dưỡng sáng da với vitamin C nguyên chất', 550000.00, 499000.00, 2, 4.7, 'https://spicyfoodstudio.com/wp-content/uploads/2023/12/chup-anh-my-pham-01.jpg', N'{"size": "30ml"}'),
(N'Mặt Nạ Dưỡng Ẩm', N'Mặt nạ cung cấp độ ẩm chuyên sâu', 25000.00, 20000.00, 3, 4.3, 'https://naidecor.vn/wp-content/uploads/2020/07/BST-MP-09.jpg', N'{"type": "sheet mask"}'),
(N'Kem Chống Nắng SPF50', N'Kem chống nắng bảo vệ da khỏi tia UV', 320000.00, 289000.00, 1, 4.9, 'https://img.pikbest.com/ai/illus_our/20230427/4a50cb35d3ad2e65a00290cd9d2d6d64.jpg!bwr800', N'{"size": "50ml"}'),
(N'Tẩy Tế Bào Chết', N'Sản phẩm tẩy da chết dịu nhẹ', 220000.00, 189000.00, 2, 4.4, 'https://studiochupanhdep.com/Upload/Images/Album/anh-my-pham-15.jpg', N'{"size": "100ml"}'),
(N'Nước Hoa Hồng', N'Nước hoa hồng không cồn dưỡng ẩm', 280000.00, 250000.00, 1, 4.6, 'https://bota.vn/wp-content/uploads/2019/07/mypham-3.jpg', N'{"size": "200ml"}'),
(N'Kem Dưỡng Mắt', N'Kem dưỡng vùng mắt chống lão hóa', 420000.00, 379000.00, 3, 4.7, 'https://bota.vn/wp-content/uploads/2019/07/mypham-4-1024x683.jpg', N'{"size": "15ml"}'),
(N'Xịt Khoáng', N'Xịt khoáng làm dịu da tức thì', 180000.00, 150000.00, 2, 4.5, 'https://bota.vn/wp-content/uploads/2019/07/mypham-5-1024x535.png', N'{"size": "300ml"}'),
(N'Gel Rửa Mặt', N'Gel rửa mặt dành cho da dầu mụn', 200000.00, 179000.00, 1, 4.8, 'https://bota.vn/wp-content/uploads/2019/07/mypham-6.jpg', N'{"size": "150ml"}'),
(N'Kem BB Cream', N'Kem nền trang điểm dưỡng da', 350000.00, 299000.00, 3, 4.6, 'https://www.chuphinhsanpham.vn/wp-content/uploads/2019/07/studio-chup-anh-my-pham-tphcm-1.jpg', N'{"shade": "natural"}'),
(N'Mặt Nạ Đất Sét', N'Mặt nạ đất sét thanh lọc da', 280000.00, 250000.00, 2, 4.4, 'https://chuphinhquangcao.net/wp-content/uploads/2023/08/chup-anh-my-pham-chuyen-nghiep-huong-dan-chon-goc-gam-mau-va-tieu-chuan-danh-gia-anh-san-pham-my-pham-64e5c8048adc8.webp', N'{"size": "100g"}'),
(N'Tinh Chất Dưỡng', N'Tinh chất dưỡng da chống lão hóa', 650000.00, 599000.00, 1, 4.9, 'https://chuphinhquangcao.net/wp-content/uploads/2023/08/chup-anh-my-pham-chuyen-nghiep-huong-dan-chon-goc-gam-mau-va-tieu-chuan-danh-gia-anh-san-pham-my-pham-64e5c804e0b25.webp', N'{"size": "50ml"}'),
(N'Sữa Tắm Dưỡng Thể', N'Sữa tắm dưỡng ẩm toàn thân', 220000.00, 189000.00, 3, 4.7, 'https://www.chuphinhsanpham.vn/wp-content/uploads/2019/06/chup-anh-my-pham-dep-2.jpg', N'{"size": "500ml"}'),
(N'Dầu Dưỡng Tóc', N'Dầu dưỡng tóc phục hồi hư tổn', 380000.00, 350000.00, 2, 4.5, 'https://www.chuphinhsanpham.vn/wp-content/uploads/2019/03/chup-anh-my-pham-chuyen-nghiep_2022.jpg', N'{"size": "100ml"}'),
(N'Kem Dưỡng Body', N'Kem dưỡng thể trắng da', 320000.00, 289000.00, 1, 4.6, 'https://www.chuphinhsanpham.vn/wp-content/uploads/2019/01/concept-chup-anh-my-pham_2021.jpg', N'{"size": "200ml"}'),
(N'Son Dưỡng Môi', N'Son dưỡng môi chống nắng', 150000.00, 129000.00, 3, 4.8, 'https://www.chuphinhsanpham.vn/wp-content/uploads/2018/03/chup-hinh-my-pham-c-photo-2018-1.jpg', N'{"type": "stick"}'),
(N'Nước Tẩy Trang', N'Nước tẩy trang dịu nhẹ', 250000.00, 229000.00, 2, 4.7, 'https://www.chuphinhsanpham.vn/wp-content/uploads/2017/12/chup-hinh-my-pham-long-phung-khang.jpg', N'{"size": "400ml"}'),
(N'Kem Chống Nẻ', N'Kem chống nẻ mùa đông', 180000.00, 159000.00, 1, 4.5, 'https://www.chuphinhsanpham.vn/wp-content/uploads/2017/11/chup-hinh-qua-tang-cong-ty-agb-0001.jpg', N'{"size": "75ml"}'),
(N'Xà Phòng Handmade', N'Xà phòng thiên nhiên handmade', 120000.00, 99000.00, 3, 4.4, 'https://www.chuphinhsanpham.vn/wp-content/uploads/2017/08/chup-hinh-my-pham-gia-re-8.jpg', N'{"weight": "100g"}');

-- Thêm dữ liệu cho bảng product_images
INSERT INTO [dbo].[product_images] ([product_id], [image_url])
SELECT id, 'https://magicskin.vn/wp-content/uploads/2024/06/post-5.png'
FROM [dbo].[products]
UNION ALL
SELECT id, 'https://thenaturebook.vn/mediacenter/media/2640/files/SUA%20RUA%20MAT%20THUAN%20CHAY%20NATURE%20BOOK%20(1).jpg'
FROM [dbo].[products]
UNION ALL
SELECT id, 'https://spicyfoodstudio.com/wp-content/uploads/2023/12/chup-anh-my-pham-01.jpg'
FROM [dbo].[products]
UNION ALL
SELECT id, 'https://naidecor.vn/wp-content/uploads/2020/07/BST-MP-09.jpg'
FROM [dbo].[products]