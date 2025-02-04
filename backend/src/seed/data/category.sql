USE [hasaki_db]
GO

-- Chèn dữ liệu vào bảng categories
INSERT INTO [dbo].[categories] ([name], [description], [parent_id], [icon_url])
VALUES
(N'Chăm Sóc Da Mặt', N'Các sản phẩm chăm sóc da mặt chuyên sâu', NULL, 'https://s3-ap-southeast-1.amazonaws.com/lixibox-production-uploads/blogs/pictures/18444/original_1692762588.jpg'),
(N'Trang Điểm', N'Mỹ phẩm trang điểm và làm đẹp', NULL, 'https://lh5.googleusercontent.com/8I3fpFEtdG6qkhKuPQODXiE_5brV7EB_8WBjK4N_pPpc9sUL6EOlEw12OLYGxECm3vdBHARTgnFJBhUjZa8ckuL09LlgMRMQ4yPqGFkwh9OiKzFO9X7fYcRmDFdgc7YMyCxKbRfSTQ7KilMdTWSBZA'),
(N'Chăm Sóc Cơ Thể', N'Sản phẩm chăm sóc toàn thân', NULL, 'https://shynhbeauty.vn/wp-content/uploads/2020/06/ch%C4%83m-s%C3%B3c-c%C6%A1-th%E1%BB%83.jpg'),
(N'Chăm Sóc Tóc', N'Các sản phẩm dành cho tóc', NULL, 'https://cdn.tgdd.vn/Files/2019/05/06/1165213/pantene_760x367.jpg'),
(N'Nước Hoa', N'Nước hoa và xịt thơm', NULL, 'https://laluz.vn/wp-content/uploads/2024/06/gia-cac-hang-nuoc-hoa-noi-tieng-tren-the-gioi.jpg'),

-- Danh mục con của Chăm Sóc Da Mặt
(N'Kem Dưỡng Da', N'Các loại kem dưỡng da mặt', 1, 'https://adminbeauty.hvnet.vn/Upload/Files/z6003189595707_ba1e87f90e523062d674599d4f3d4c4d-05112024093130.jpg?width=350&height=391&v=15042020'),
(N'Sữa Rửa Mặt', N'Sản phẩm làm sạch da mặt', 1, 'https://bizweb.dktcdn.net/thumb/large/100/494/726/products/a1-d84079d4-1b94-4c09-9095-442209b7145a.png?v=1732244904557'),
(N'Mặt Nạ', N'Các loại mặt nạ dưỡng da', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO1muEls1V4vV92ct4hTHJHk_cvxI_pSEVgw&s'),

-- Danh mục con của Trang Điểm
(N'Son Môi', N'Các loại son môi',2 , 'https://chyaki.vn/wp-content/uploads/202-2.jpg'),
(N'Phấn Nền', N'Kem nền và phấn nền',2 , 'https://file.hstatic.net/1000006063/file/140.8_535d5fe08a094afca12d04ba5310f31a_1024x1024.jpg'),
(N'Trang Điểm Mắt', N'Sản phẩm trang điểm mắt', 2, 'https://cocolux.com/storage/upload_image/images/san-pham/da-ke-mat-dearmay-crunchie-pop-slim-pen-eyeliner-black.jpg'),

-- Danh mục con của Chăm Sóc Cơ Thể
(N'Sữa Tắm', N'Các loại sữa tắm',3, 'https://cdn.medigoapp.com/product/412fc2df8e546d26640832cfada63d56_8dee8ca828.jpg'),
(N'Kem Dưỡng Thể', N'Kem dưỡng da toàn thân', 3, 'https://images.depxinh.net/products/item.11_2016/2607/source/sua-duong-the-hazeline-tinh-chat-nho-den.jpg'),
(N'Tẩy Tế Bào Chết Body', N'Sản phẩm tẩy da chết toàn thân', 3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5zIqwee1-3jtdNGRf1TNR8vnk-6dboRmM7g&s'),

-- Danh mục con của Chăm Sóc Tóc
(N'Dầu gội', N'Các loại dầu gội',4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3RV5HwlEabWvyBOWMZrTnnyKgehjpdCIYxg&s'),
(N'Dầu xả', N'Các loại dầu xả', 4, 'https://cdn.thegioididong.com/Products/Images/2484/129859/dau-xa-thai-duong-7-chai-200ml-hinh-2.jpg'),
(N'Dầu dưỡng tóc', N'Các loại dầu dưỡng tóc', 4, 'https://image.cocoonvietnam.com/uploads/Avatar_Website_Nuoc_duong_toc_tinh_dau_buoi_140ml_Cai_tien_moi_240629_7819f9ba98.jpg'),

-- Danh mục con của Nước Hoa
(N'Nước hoa nữ', N'Các loại nước hoa nữ', 5, 'https://cocolux.com/storage/upload_image/images/Bao_bi_moi/Thay-sp/6085010094151.jpg'),
(N'Nước hoa nam', N'Các loại nước hoa nam', 5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz9n_fBl3ZsdU56352lWvraLkAozo3dceGwQ&s');

