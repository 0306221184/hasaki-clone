-- Insert sample products
INSERT INTO [dbo].[products] 
    ([name], [description], [price], [discount_price], [sku], 
    [quantity_in_stock], [category_id], [rating], [image_url], 
    [variants], [tags])
VALUES
    (N'Sữa Rửa Mặt Cerave', 
    N'Sữa Rửa Mặt Cerave Dành Cho Da Thường Đến Da Khô Hydrating Cleanser 236ml',
    250000, 
    225000,
    'CRV-SRM-001',
    100,
    1, -- Assuming category_id 1 exists
    4.5,
    'https://product.hstatic.net/1000006063/product/sua-rua-mat-cerave-hydrating-cleanser_33e0c4013f4d47dbac13746cf41f6850_1024x1024.jpg',
    N'["236ml", "355ml"]',
    N'["Sữa rửa mặt", "Cerave", "Da khô"]'),

    (N'Kem Chống Nắng La Roche-Posay',
    N'Kem Chống Nắng La Roche-Posay Anthelios UV Mune 400 Invisible Fluid SPF50+ 50ml',
    450000,
    405000,
    'LRP-KCN-001',
    150,
    2,
    4.8,
    'https://product.hstatic.net/1000006063/product/6935_kem_chong_nang_la_roche_posay_anthelios_uvmune_400_invisible_fluid_spf50__50ml_1_7d4dfcd58ca14d7e9f3a62e0db515c47_1024x1024.jpg',
    N'["50ml"]',
    N'["Kem chống nắng", "La Roche-Posay", "SPF50+"]'),

    (N'Nước Tẩy Trang Bioderma', 
    N'Nước Tẩy Trang Bioderma Sensibio H2O Dành Cho Da Nhạy Cảm',
    420000, 
    378000,
    'BIO-NTT-001',
    200,
    1,
    4.7,
    'https://product.hstatic.net/1000006063/product/nuoc-tay-trang-bioderma-sensibio-h2o_4e4c33d30be34d0f9753f27673683c94.jpg',
    N'["250ml", "500ml"]',
    N'["Tẩy trang", "Bioderma", "Da nhạy cảm"]'),

    (N'Serum The Ordinary Niacinamide',
    N'Serum The Ordinary Niacinamide 10% + Zinc 1% Giảm Mụn, Se Khít Lỗ Chân Lông',
    280000,
    252000,
    'ORD-SRM-001',
    150,
    3,
    4.6,
    'https://product.hstatic.net/1000006063/product/serum-the-ordinary-niacinamide-10-zinc-1_4136600cd9814a6586a3ea977464f3a4.jpg',
    N'["30ml", "60ml"]',
    N'["Serum", "The Ordinary", "Niacinamide"]'),

    (N'Kem Dưỡng Ẩm Neutrogena',
    N'Kem Dưỡng Ẩm Neutrogena Hydro Boost Water Gel',
    289000,
    260000,
    'NTG-KDA-001',
    120,
    4,
    4.4,
    'https://product.hstatic.net/1000006063/product/kem-duong-am-neutrogena-hydro-boost_7f8f9c4f35ab4f4c9160cf4181ac4a3c.jpg',
    N'["50g"]',
    N'["Kem dưỡng ẩm", "Neutrogena", "Gel"]'),

    (N'Mặt Nạ Innisfree',
    N'Mặt Nạ Giấy Innisfree My Real Squeeze Mask',
    22000,
    20000,
    'INF-MN-001',
    500,
    5,
    4.3,
    'https://product.hstatic.net/1000006063/product/mat-na-giay-innisfree-my-real-squeeze_7d4c9c8f12234c4c9c4c4c4c4c4c4c4c.jpg',
    N'["20ml"]',
    N'["Mặt nạ", "Innisfree", "Dưỡng ẩm"]'),

    (N'Son Môi 3CE',
    N'Son Thỏi 3CE Mood Recipe Matte Lip Color',
    320000,
    288000,
    '3CE-SM-001',
    80,
    6,
    4.8,
    'https://product.hstatic.net/1000006063/product/son-thoi-3ce-mood-recipe_9c4c4c4c4c4c4c4c9c4c4c4c4c4c4c4c.jpg',
    N'["3.5g"]',
    N'["Son môi", "3CE", "Màu đỏ"]'),

    (N'Sữa Chống Nắng Anessa',
    N'Sữa Chống Nắng Anessa Perfect UV Sunscreen Skincare Milk',
    435000,
    391500,
    'ANS-CN-001',
    100,
    2,
    4.9,
    'https://product.hstatic.net/1000006063/product/sua-chong-nang-anessa_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["60ml"]',
    N'["Chống nắng", "Anessa", "SPF50+"]'),

    (N'Tẩy Tế Bào Chết Paula Choice',
    N'Tẩy Tế Bào Chết Paula Choice 2% BHA Liquid Exfoliant',
    850000,
    765000,
    'PC-TBC-001',
    60,
    7,
    4.7,
    'https://product.hstatic.net/1000006063/product/tay-te-bao-chet-paula-choice_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["118ml"]',
    N'["Tẩy tế bào chết", "Paula Choice", "BHA"]'),

    (N'Gel Rửa Mặt Cosrx',
    N'Gel Rửa Mặt Cosrx Low pH Good Morning Gel Cleanser',
    220000,
    198000,
    'CSX-RM-001',
    150,
    1,
    4.5,
    'https://product.hstatic.net/1000006063/product/gel-rua-mat-cosrx_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["150ml"]',
    N'["Gel rửa mặt", "Cosrx", "pH thấp"]'),

    (N'Tinh Chất Klairs',
    N'Tinh Chất Klairs Freshly Juiced Vitamin Drop',
    320000,
    288000,
    'KL-TC-001',
    90,
    3,
    4.6,
    'https://product.hstatic.net/1000006063/product/tinh-chat-klairs_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["35ml"]',
    N'["Tinh chất", "Klairs", "Vitamin C"]'),

    (N'Kem Dưỡng Laneige',
    N'Kem Dưỡng Ẩm Laneige Water Bank Blue Hyaluronic Cream',
    750000,
    675000,
    'LNG-KDA-001',
    80,
    4,
    4.7,
    'https://product.hstatic.net/1000006063/product/kem-duong-laneige_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["50ml"]',
    N'["Kem dưỡng ẩm", "Laneige", "Hyaluronic"]'),

    (N'Xịt Khoáng Avene',
    N'Xịt Khoáng Avene Thermal Spring Water',
    350000,
    315000,
    'AVE-XK-001',
    200,
    8,
    4.5,
    'https://product.hstatic.net/1000006063/product/xit-khoang-avene_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["300ml", "150ml"]',
    N'["Xịt khoáng", "Avene", "Làm dịu"]'),

    (N'Mặt Nạ Ngủ Sulwhasoo',
    N'Mặt Nạ Ngủ Sulwhasoo Overnight Vitalizing Mask',
    980000,
    882000,
    'SWS-MN-001',
    50,
    5,
    4.9,
    'https://product.hstatic.net/1000006063/product/mat-na-ngu-sulwhasoo_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["120ml"]',
    N'["Mặt nạ ngủ", "Sulwhasoo", "Dưỡng ẩm"]'),

    (N'Serum Vitamin C Melano CC',
    N'Serum Vitamin C Melano CC Anti-Spot Essence',
    280000,
    252000,
    'MCC-VC-001',
    150,
    3,
    4.6,
    'https://product.hstatic.net/1000006063/product/serum-melano-cc_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["20ml"]',
    N'["Serum", "Melano CC", "Vitamin C"]'),

    (N'Sữa Rửa Mặt Hada Labo',
    N'Sữa Rửa Mặt Hada Labo Gokujyun Hyaluronic Acid Cleansing Foam',
    150000,
    135000,
    'HLB-SRM-001',
    300,
    1,
    4.4,
    'https://product.hstatic.net/1000006063/product/sua-rua-mat-hada-labo_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["100g"]',
    N'["Sữa rửa mặt", "Hada Labo", "Hyaluronic Acid"]'),

    (N'Kem Chống Nắng Biore',
    N'Kem Chống Nắng Biore UV Aqua Rich Watery Essence SPF50+',
    245000,
    220500,
    'BIO-KCN-001',
    250,
    2,
    4.7,
    'https://product.hstatic.net/1000006063/product/kem-chong-nang-biore_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["50g"]',
    N'["Kem chống nắng", "Biore", "SPF50+"]'),

    (N'Toner Some By Mi',
    N'Toner Some By Mi AHA-BHA-PHA 30 Days Miracle',
    280000,
    252000,
    'SBM-TN-001',
    180,
    9,
    4.8,
    'https://product.hstatic.net/1000006063/product/toner-some-by-mi_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["150ml"]',
    N'["Toner", "Some By Mi", "AHA BHA PHA"]'),

    (N'Kem Dưỡng Illiyoon',
    N'Kem Dưỡng Ẩm Illiyoon Ceramide Ato Concentrate Cream',
    320000,
    288000,
    'ILY-KDA-001',
    200,
    4,
    4.6,
    'https://product.hstatic.net/1000006063/product/kem-duong-illiyoon_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["200ml"]',
    N'["Kem dưỡng ẩm", "Illiyoon", "Ceramide"]'),

    (N'Mặt Nạ Mediheal',
    N'Mặt Nạ Giấy Mediheal N.M.F Aquaring Ampoule Mask',
    25000,
    22500,
    'MHL-MN-001',
    1000,
    5,
    4.5,
    'https://product.hstatic.net/1000006063/product/mat-na-mediheal_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["25ml"]',
    N'["Mặt nạ", "Mediheal", "NMF"]'),

    (N'Son Môi Rom&nd',
    N'Son Kem Rom&nd Juicy Lasting Tint',
    250000,
    225000,
    'RND-SM-001',
    150,
    6,
    4.8,
    'https://product.hstatic.net/1000006063/product/son-romand_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg',
    N'["5.5g"]',
    N'["Son môi", "Rom&nd", "Tint"]');

-- Insert product images
INSERT INTO [dbo].[product_images]
    ([product_id], [image_url])
VALUES
    (1, 'https://product.hstatic.net/1000006063/product/sua-rua-mat-cerave-hydrating-cleanser_33e0c4013f4d47dbac13746cf41f6850_1024x1024.jpg'),
    (1, 'https://product.hstatic.net/1000006063/product/sua-rua-mat-cerave-hydrating-cleanser-236ml_4c2d5b0d4301463c801c1853c51eb0c2_1024x1024.jpg'),
    (2, 'https://product.hstatic.net/1000006063/product/6935_kem_chong_nang_la_roche_posay_anthelios_uvmune_400_invisible_fluid_spf50__50ml_1_7d4dfcd58ca14d7e9f3a62e0db515c47_1024x1024.jpg'),
    (2, 'https://product.hstatic.net/1000006063/product/6935_kem_chong_nang_la_roche_posay_anthelios_uvmune_400_invisible_fluid_spf50__50ml_2_1024x1024.jpg'),
    (3, 'https://product.hstatic.net/1000006063/product/nuoc-tay-trang-bioderma-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (3, 'https://product.hstatic.net/1000006063/product/nuoc-tay-trang-bioderma-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (4, 'https://product.hstatic.net/1000006063/product/serum-the-ordinary-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (4, 'https://product.hstatic.net/1000006063/product/serum-the-ordinary-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (5, 'https://product.hstatic.net/1000006063/product/neutrogena-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (5, 'https://product.hstatic.net/1000006063/product/neutrogena-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (6, 'https://product.hstatic.net/1000006063/product/innisfree-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (6, 'https://product.hstatic.net/1000006063/product/innisfree-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (7, 'https://product.hstatic.net/1000006063/product/3ce-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (7, 'https://product.hstatic.net/1000006063/product/3ce-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (8, 'https://product.hstatic.net/1000006063/product/anessa-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (8, 'https://product.hstatic.net/1000006063/product/anessa-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (9, 'https://product.hstatic.net/1000006063/product/paula-choice-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (9, 'https://product.hstatic.net/1000006063/product/paula-choice-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (10, 'https://product.hstatic.net/1000006063/product/cosrx-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (10, 'https://product.hstatic.net/1000006063/product/cosrx-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (11, 'https://product.hstatic.net/1000006063/product/kem-duong-laneige-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (11, 'https://product.hstatic.net/1000006063/product/kem-duong-laneige-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (12, 'https://product.hstatic.net/1000006063/product/xit-khoang-avene-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (12, 'https://product.hstatic.net/1000006063/product/xit-khoang-avene-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (13, 'https://product.hstatic.net/1000006063/product/mat-na-ngu-sulwhasoo-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (13, 'https://product.hstatic.net/1000006063/product/mat-na-ngu-sulwhasoo-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (14, 'https://product.hstatic.net/1000006063/product/serum-melano-cc-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (14, 'https://product.hstatic.net/1000006063/product/serum-melano-cc-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (15, 'https://product.hstatic.net/1000006063/product/sua-rua-mat-hada-labo-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (15, 'https://product.hstatic.net/1000006063/product/sua-rua-mat-hada-labo-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (16, 'https://product.hstatic.net/1000006063/product/kem-chong-nang-biore-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (16, 'https://product.hstatic.net/1000006063/product/kem-chong-nang-biore-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (17, 'https://product.hstatic.net/1000006063/product/toner-some-by-mi-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (17, 'https://product.hstatic.net/1000006063/product/toner-some-by-mi-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (18, 'https://product.hstatic.net/1000006063/product/kem-duong-illiyoon-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (18, 'https://product.hstatic.net/1000006063/product/kem-duong-illiyoon-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (19, 'https://product.hstatic.net/1000006063/product/mat-na-mediheal-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (19, 'https://product.hstatic.net/1000006063/product/mat-na-mediheal-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (20, 'https://product.hstatic.net/1000006063/product/son-romand-1_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg'),
    (20, 'https://product.hstatic.net/1000006063/product/son-romand-2_4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c.jpg');
