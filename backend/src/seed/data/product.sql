USE [hasaki_db]
GO

INSERT INTO [dbo].[products] ([name], [description], [price], [discount_price], [category_id], [rating], [image_url], [variants])
VALUES
(N'Kem Dưỡng Da Ban Đêm', N'Kem dưỡng da chuyên sâu làm trắng và phục hồi da ban đêm', 450000.00, 399000.00, 1, 4.5, 'https://kenh14cdn.com/203336854389633024/2023/11/20/photo-6-1700449162562769261386.png', N'{"size": "50ml"}'),
(N'Sữa Rửa Mặt Trà Xanh', N'Sữa rửa mặt chiết xuất từ trà xanh, làm sạch sâu', 180000.00, 150000.00, 1, 4.8, 'https://ananshop.com.vn/wp-content/uploads/2024/04/SUA-RUA-MAT-TRA-XANH-SICA-WHITE-1.png', N'{"size": "100ml"}'),
(N'Serum Vitamin C', N'Serum dưỡng sáng da với vitamin C nguyên chất', 550000.00, 499000.00, 2, 4.7, 'https://bsnguyenngoc.vn/wp-content/uploads/review-serum-vitamin-c-1.jpg', N'{"size": "30ml"}'),
(N'Mặt Nạ Dưỡng Ẩm', N'Mặt nạ cung cấp độ ẩm chuyên sâu', 25000.00, 20000.00, 3, 4.3, 'https://product.hstatic.net/200000385117/product/mask_b_cover_33343d14ff954e3891b3f3638788f21c_master.jpg', N'{"type": "sheet mask"}'),
(N'Kem Chống Nắng SPF50', N'Kem chống nắng bảo vệ da khỏi tia UV', 320000.00, 289000.00, 1, 4.9, 'https://product.hstatic.net/200000781415/product/thumbnail_web_-_pink-22_a11625b1338b4bff9ff6896647c843b6.png', N'{"size": "50ml"}'),
(N'Tẩy Tế Bào Chết', N'Sản phẩm tẩy da chết dịu nhẹ', 220000.00, 189000.00, 2, 4.4, 'https://bizweb.dktcdn.net/100/426/039/products/tay-da-chet-mat-cocoon-tay-te-bao-chet-mat-tu-ca-phe-dak-lak-150ml.jpg?v=1667124521193', N'{"size": "100ml"}'),
(N'Nước Hoa Hồng', N'Nước hoa hồng không cồn dưỡng ẩm', 280000.00, 250000.00, 1, 4.6, 'https://laco.vn/wp-content/uploads/2021/08/Tonner-3-scaled.jpg', N'{"size": "200ml"}'),
(N'Kem Dưỡng Mắt', N'Kem dưỡng vùng mắt chống lão hóa', 420000.00, 379000.00, 3, 4.7, 'https://zomedical.vn/wp-content/uploads/2020/01/kem-duong-sang-da-mat-zo-skin-health-eye-brightening-creme.jpg', N'{"size": "15ml"}'),
(N'Xịt Khoáng', N'Xịt khoáng làm dịu da tức thì', 180000.00, 150000.00, 2, 4.5, 'https://laskin.vn/wp-content/uploads/2022/10/facebook-dynamic-xit-khoang-evol-1.jpg', N'{"size": "300ml"}'),
(N'Gel Rửa Mặt', N'Gel rửa mặt dành cho da dầu mụn', 200000.00, 179000.00, 1, 4.8, 'https://bizweb.dktcdn.net/100/141/194/products/cerave-01.png?v=1663590773857', N'{"size": "150ml"}'),
(N'Kem BB Cream', N'Kem nền trang điểm dưỡng da', 350000.00, 299000.00, 3, 4.6, 'https://vn-live-01.slatic.net/p/cbe5ec6509b60892d16f5a4990317c33.jpg', N'{"shade": "natural"}'),
(N'Mặt Nạ Đất Sét', N'Mặt nạ đất sét thanh lọc da', 280000.00, 250000.00, 2, 4.4, 'https://product.hstatic.net/200000853999/product/z5687863171354_90abdd60ae56487cbf72a49a2e5c2ba1_cb09f8999cf44d58b84913113fca9bcf_master.jpg', N'{"size": "100g"}'),
(N'Tinh Chất Dưỡng', N'Tinh chất dưỡng da chống lão hóa', 650000.00, 599000.00, 1, 4.9, 'https://klairsvietnam.vn/wp-content/uploads/2020/07/tinh-chat-duong-da-klairs.jpg', N'{"size": "50ml"}'),
(N'Sữa Tắm Dưỡng Thể', N'Sữa tắm dưỡng ẩm toàn thân', 220000.00, 189000.00, 3, 4.7, 'https://www.lottemart.vn/media/catalog/product/cache/0x0/8/9/8934868168119_1.jpg.webp', N'{"size": "500ml"}'),
(N'Dầu Dưỡng Tóc', N'Dầu dưỡng tóc phục hồi hư tổn', 380000.00, 350000.00, 2, 4.5, 'https://myphamxachtayduc.vn/wp-content/uploads/2020/08/dau-duong-toc-balea-professional-oil-repair-intensiv-haarol-100-ml-2.jpg', N'{"size": "100ml"}'),
(N'Kem Dưỡng Body', N'Kem dưỡng thể trắng da', 320000.00, 289000.00, 1, 4.9, 'https://product.hstatic.net/1000006063/product/3570273ab9e9093d77cca585ee365693_647f92524e1e46259f19ea97c0a4837c_1024x1024.jpeg', N'{"size": "200ml"}'),
(N'Dầu gội PANTENE', N'Dầu gội PANTENE', 180000.00, 150000.00, 4, 4.8, 'https://lh3.googleusercontent.com/Lbc4JV8DB5frXKvbUUh-9eU0qVvxmCn_mgrxZxPltN5oROldKkIlCPbUsvgD9X4p5WojVEeLh8TY70zULtTLx-J-0oC7iG2KIw', N'{"size": "200ml"}'),
(N'Dầu xả DOVE', N'Dầu xả DOVE', 150000.00, 130000.00, 4, 4.7, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHT2_26SU7VlFUcSQ_xUoTUCdGI0feuFJUSA&s', N'{"size": "200ml"}'),
(N'Dầu dưỡng tóc COCOON', N'Dầu dưỡng tóc COCOON', 220000.00, 200000.00, 4, 4.9, 'https://image.cocoonvietnam.com/uploads/Avatar_Website_Nuoc_duong_toc_tinh_dau_buoi_140ml_Cai_tien_moi_240629_7819f9ba98.jpg', N'{"size": "140ml"}'),
(N'Dầu gội SUNSILK', N'Dầu gội SUNSILK', 130000.00, 110000.00, 4, 4.6, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/294/269/products/dau-goi-sunsilk-1-4l.jpg?v=1541061572687', N'{"size": "1.4L"}'),
(N'Kem xả DOVE', N'Kem xả DOVE', 180000.00, 160000.00, 4, 4.7, 'https://prod-cdn.pharmacity.io/e-com/images/ecommerce/P03395_1_l.webp', N'{"size": "200ml"}'),
(N'Nước hoa Dior Rose', N'Nước hoa cao cấp hương hoa hồng', 180000.00, 160000.00, 5, 4.7, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTEBV9LwAEkxtXcLmiuZx8kx33VmQOOYCcTQ&s', N'{"size": "50ml"}'),
(N'Nước hoa nam Channel Bleu De', N'Nước hoa nam thanh lịch và mạnh mẽ', 180000.00, 160000.00, 5, 4.7, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY86K-S04qLFIYWbC8l6AnjL7TzhLYyJi1TQ&s', N'{"size": "50ml"}'),
(N'Nước hoa nữ Armaf', N'Nước hoa quyến rũ với hương hoa và trái cây', 180000.00, 160000.00, 5, 4.7, 'https://cocolux.com/storage/upload_image/images/Bao_bi_moi/Thay-sp/6085010094151.jpg', N'{"size": "50ml"}'),
(N'Nước hoa nam Versace', N'Nước hoa nam phong cách hiện đại', 180000.00, 160000.00, 5, 4.7, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz9n_fBl3ZsdU56352lWvraLkAozo3dceGwQ&s', N'{"size": "50ml"}'),
(N'Nước hoa nữ Narciso Cristal', N'Nước hoa với hương thơm dịu nhẹ, tinh tế', 180000.00, 160000.00, 5, 4.7, 'https://product.hstatic.net/1000339918/product/narciso-cristal-edp_66ffb123ad714a1d8e2cfc86a26c8ec9_master.jpg', N'{"size": "50ml"}');
INSERT INTO [dbo].[product_images] ([product_id], [image_url])
SELECT id, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'
FROM [dbo].[products];
