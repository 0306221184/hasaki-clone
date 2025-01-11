USE [hasaki_db]
GO

INSERT INTO [dbo].[categories] ([name], [description], [parent_id], [icon_url])
VALUES
(N'Chăm Sóc Da Mặt', N'Các sản phẩm chăm sóc da mặt chuyên sâu', NULL, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),
(N'Trang Điểm', N'Mỹ phẩm trang điểm và làm đẹp', NULL, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),
(N'Chăm Sóc Cơ Thể', N'Sản phẩm chăm sóc toàn thân', NULL, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),
(N'Chăm Sóc Tóc', N'Các sản phẩm dành cho tóc', NULL, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),
(N'Nước Hoa', N'Nước hoa và xịt thơm', NULL, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),

-- Danh mục con của Chăm Sóc Da Mặt
(N'Kem Dưỡng Da', N'Các loại kem dưỡng da mặt', 1, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),
(N'Sữa Rửa Mặt', N'Sản phẩm làm sạch da mặt', 1, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),
(N'Mặt Nạ', N'Các loại mặt nạ dưỡng da', 1, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),

-- Danh mục con của Trang Điểm
(N'Son Môi', N'Các loại son môi', 2, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),
(N'Phấn Nền', N'Kem nền và phấn nền', 2, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),
(N'Trang Điểm Mắt', N'Sản phẩm trang điểm mắt', 2, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),

-- Danh mục con của Chăm Sóc Cơ Thể
(N'Sữa Tắm', N'Các loại sữa tắm', 3, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),
(N'Kem Dưỡng Thể', N'Kem dưỡng da toàn thân', 3, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg'),
(N'Tẩy Tế Bào Chết Body', N'Sản phẩm tẩy da chết toàn thân', 3, 'https://innovativehub.com.vn/wp-content/uploads/2023/06/thuc-trang-nganh-my-pham-1200x888.jpg');
