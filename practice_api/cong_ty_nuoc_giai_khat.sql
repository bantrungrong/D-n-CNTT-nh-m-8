-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 14, 2024 lúc 06:58 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `cong_ty_nuoc_giai_khat`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `daily`
--

CREATE TABLE `daily` (
  `MaDaiLy` int(11) NOT NULL,
  `TenDaiLy` varchar(255) DEFAULT NULL,
  `DiaChi` varchar(255) DEFAULT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `daily`
--

INSERT INTO `daily` (`MaDaiLy`, `TenDaiLy`, `DiaChi`, `SoDienThoai`, `Email`) VALUES
(1, 'Dai Ly 1', '123 Nguyen Trai, Hanoi', '0123456780', 'daily1@example.com'),
(2, 'Dai Ly 2', '456 Tran Hung Dao, Ho Chi Minh City', '0987654320', 'daily2@example.com'),
(3, 'Dai Ly 3', '789 Le Loi, Da Nang', '0234567801', 'daily3@example.com'),
(4, 'Đại lý ABC', '123 Đường ABC, Thành phố A', '0123456789', 'dailyabc@example.com'),
(5, 'Đại lý XYZ', '456 Đường XYZ, Thành phố B', '0987654321', 'dailyxyz@example.com'),
(6, 'Đại lý DEF', '789 Đường DEF, Thành phố C', '0123456789', 'dailydef@example.com'),
(7, 'Đại lý GHI', '101 Đường GHI, Thành phố D', '0987654321', 'dailyghi@example.com'),
(8, 'Đại lý JKL', '234 Đường JKL, Thành phố E', '0123456789', 'dailyjkl@example.com'),
(9, 'Đại lý MNO', '567 Đường MNO, Thành phố F', '0987654321', 'dailymno@example.com'),
(10, 'Đại lý PQR', '890 Đường PQR, Thành phố G', '0123456789', 'dailypqr@example.com'),
(11, 'Đại lý STU', '111 Đường STU, Thành phố H', '0987654321', 'dailystu@example.com'),
(12, 'Đại lý VWX', '222 Đường VWX, Thành phố I', '0123456789', 'dailyvwx@example.com'),
(13, 'Đại lý YZ', '333 Đường YZ, Thành phố J', '0987654321', 'dailyyz@example.com');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhapkho`
--

CREATE TABLE `nhapkho` (
  `MaPhieuNhap` int(11) NOT NULL,
  `MaSanPham` int(11) DEFAULT NULL,
  `count_item` int(11) DEFAULT NULL,
  `NgayNhap` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhasanxuat`
--

CREATE TABLE `nhasanxuat` (
  `MaNSX` int(11) NOT NULL,
  `TenNSX` varchar(255) DEFAULT NULL,
  `DiaChi` varchar(255) DEFAULT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `nhasanxuat`
--

INSERT INTO `nhasanxuat` (`MaNSX`, `TenNSX`, `DiaChi`, `SoDienThoai`) VALUES
(1, 'Coca-Cola Company', '123 Coca Cola St, Atlanta, GA', '0123456789'),
(2, 'PepsiCo', '456 Pepsi Rd, Purchase, NY', '0987654321'),
(3, 'Nestle', '789 Nestle Ave, Vevey, VD', '0234567890'),
(4, 'Red Bull GmbH', '123 Red Bull Dr, Fuschl am See', '0345678901'),
(5, 'Coca-Cola Company', 'Atlanta, Georgia, USA', '0123456789'),
(6, 'PepsiCo', 'Purchase, New York, USA', '0987654321'),
(7, 'Coca-Cola Company', 'Atlanta, Georgia, USA', '0123456789'),
(8, 'Nestlé', 'Vevey, Switzerland', '0987654321'),
(9, 'Vinasoy', 'Ho Chi Minh City, Vietnam', '0123456789'),
(10, 'Heineken', 'Amsterdam, Netherlands', '0987654321'),
(11, 'Vinamilk', 'Ho Chi Minh City, Vietnam', '0123456789'),
(12, 'PepsiCo', 'Purchase, New York, USA', '0987654321'),
(13, 'PepsiCo', 'Purchase, New York, USA', '0123456789'),
(14, 'Red Bull GmbH', 'Fuschl am See, Austria', '0987654321');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phieunhaphang`
--

CREATE TABLE `phieunhaphang` (
  `MaPhieuNhap` int(11) NOT NULL,
  `MaSanPham` int(11) DEFAULT NULL,
  `MaNSX` int(11) DEFAULT NULL,
  `MaDaiLy` int(11) DEFAULT NULL,
  `count_item` int(11) DEFAULT NULL,
  `NgayNhap` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phieuxuathang`
--

CREATE TABLE `phieuxuathang` (
  `MaPhieuXuat` int(11) NOT NULL,
  `MaSanPham` int(11) DEFAULT NULL,
  `MaDaiLy` int(11) DEFAULT NULL,
  `count_item` int(11) DEFAULT NULL,
  `NgayXuat` date DEFAULT NULL,
  `DonGia` int(11) DEFAULT NULL,
  `TenSanPham` varchar(111) DEFAULT NULL,
  `TenDaiLy` varchar(222) DEFAULT NULL,
  `DiaChi` varchar(111) DEFAULT NULL,
  `SoDienThoai` int(11) DEFAULT NULL,
  `NguoiNhan` varchar(222) DEFAULT NULL,
  `TongTien` int(22) DEFAULT NULL,
  `TongSP` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `phieuxuathang`
--

INSERT INTO `phieuxuathang` (`MaPhieuXuat`, `MaSanPham`, `MaDaiLy`, `count_item`, `NgayXuat`, `DonGia`, `TenSanPham`, `TenDaiLy`, `DiaChi`, `SoDienThoai`, `NguoiNhan`, `TongTien`, `TongSP`) VALUES
(1, 1, 6, 1, '2023-09-09', 12, 'adadad qeqeqe', 'def', 'VN', 123123, 'ĐSSS', 2222, NULL),
(2, 1, 6, 1, '2024-05-14', 22, 'coca cola', 'Đại lý DEF', '789 Đường DEF, Thành phố C', 123456789, 'huyh hugg', 2400150, 300),
(3, 1, 6, 1, '2024-05-14', 22, '[\"coca cola\"]', 'Đại lý DEF', '789 Đường DEF, Thành phố C', 123456789, 'huyh hugg', 2400150, 300),
(5, 1, 3, 1, '2024-07-19', 22, '[\"Nước suối Lavie\"]', 'Dai Ly 3', '789 Le Loi, Da Nang', 234567801, 'Hải Nam', 823, 510);

--
-- Bẫy `phieuxuathang`
--
DELIMITER $$
CREATE TRIGGER `Before_Insert_PhieuXuatHang` BEFORE INSERT ON `phieuxuathang` FOR EACH ROW BEGIN
    DECLARE remaining_count INT;

    -- Tính toán số lượng còn lại của sản phẩm
    SELECT (count_item - NEW.count_item) INTO remaining_count
    FROM SanPham
    WHERE MaSanPham = NEW.MaSanPham;

    -- Nếu số lượng còn lại ít hơn 2/3
    IF remaining_count < (2 * NEW.count_item / 3) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không thể tạo phiếu xuất hàng vì số lượng sản phẩm còn lại quá ít!';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

CREATE TABLE `sanpham` (
  `MaSanPham` int(11) NOT NULL,
  `TenSanPham` varchar(255) DEFAULT NULL,
  `LoaiSanPham` varchar(255) DEFAULT NULL,
  `DungTich` decimal(5,2) DEFAULT NULL,
  `DonGia` decimal(10,2) DEFAULT NULL,
  `count_item` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`MaSanPham`, `TenSanPham`, `LoaiSanPham`, `DungTich`, `DonGia`, `count_item`) VALUES
(1, 'coca cola', 'gas có đường', 330.00, 12000.00, 200),
(2, 'Pepsi', 'Nước ngọt', 330.00, 9500.00, 0),
(3, 'Aquafina', 'Nước khoáng', 500.00, 8000.00, 0),
(4, 'Sting', 'Nước tăng lực', 330.00, 11000.00, 0),
(5, 'Red Bull', 'Nước tăng lực', 250.00, 15000.00, 0),
(6, 'Nước ngọt Coca-Cola', 'Nước ngọt', 330.00, 1.50, 100),
(7, 'Nước ngọt Pepsi', 'Nước ngọt', 330.00, 1.40, 120),
(8, 'Nước ngọt Fanta', 'Nước ngọt', 330.00, 1.30, 80),
(9, 'Nước suối Lavie', 'Nước uống', 500.00, 0.50, 150),
(10, 'Sữa đậu nành Vinasoy', 'Đồ uống', 250.00, 2.00, 70),
(11, 'Bia Heineken', 'Bia', 330.00, 2.50, 200),
(12, 'Sữa tươi Vinamilk', 'Đồ uống', 180.00, 1.20, 90),
(13, 'Nước cam Tropicana', 'Nước trái cây', 350.00, 2.00, 110),
(14, 'Nước lọc Aquafina', 'Nước uống', 500.00, 0.70, 180),
(15, 'Nước tăng lực Red Bull', 'Nước tăng lực', 250.00, 2.00, 100),
(17, 'etus', 'hồi máu', 330.00, 9999999.00, 0),
(22, 'nước thánh ', 'hồi máu', 330.00, 99999.00, 200);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_table`
--

CREATE TABLE `user_table` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  `user_company` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user_table`
--

INSERT INTO `user_table` (`user_id`, `user_name`, `user_email`, `user_password`, `user_company`) VALUES
(1, 'bang', 'ban@gmail.com', '1', 'Hàng Hải VN');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `xuatkho`
--

CREATE TABLE `xuatkho` (
  `MaPhieuXuat` int(11) NOT NULL,
  `MaSanPham` int(11) DEFAULT NULL,
  `count_item` int(11) DEFAULT NULL,
  `NgayXuat` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `daily`
--
ALTER TABLE `daily`
  ADD PRIMARY KEY (`MaDaiLy`);

--
-- Chỉ mục cho bảng `nhapkho`
--
ALTER TABLE `nhapkho`
  ADD PRIMARY KEY (`MaPhieuNhap`),
  ADD KEY `MaSanPham` (`MaSanPham`);

--
-- Chỉ mục cho bảng `nhasanxuat`
--
ALTER TABLE `nhasanxuat`
  ADD PRIMARY KEY (`MaNSX`);

--
-- Chỉ mục cho bảng `phieunhaphang`
--
ALTER TABLE `phieunhaphang`
  ADD PRIMARY KEY (`MaPhieuNhap`),
  ADD KEY `MaSanPham` (`MaSanPham`),
  ADD KEY `MaNSX` (`MaNSX`),
  ADD KEY `MaDaiLy` (`MaDaiLy`);

--
-- Chỉ mục cho bảng `phieuxuathang`
--
ALTER TABLE `phieuxuathang`
  ADD PRIMARY KEY (`MaPhieuXuat`),
  ADD KEY `MaSanPham` (`MaSanPham`),
  ADD KEY `MaDaiLy` (`MaDaiLy`);

--
-- Chỉ mục cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`MaSanPham`);

--
-- Chỉ mục cho bảng `user_table`
--
ALTER TABLE `user_table`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`);

--
-- Chỉ mục cho bảng `xuatkho`
--
ALTER TABLE `xuatkho`
  ADD PRIMARY KEY (`MaPhieuXuat`),
  ADD KEY `MaSanPham` (`MaSanPham`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `daily`
--
ALTER TABLE `daily`
  MODIFY `MaDaiLy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `nhasanxuat`
--
ALTER TABLE `nhasanxuat`
  MODIFY `MaNSX` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `phieunhaphang`
--
ALTER TABLE `phieunhaphang`
  MODIFY `MaPhieuNhap` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `phieuxuathang`
--
ALTER TABLE `phieuxuathang`
  MODIFY `MaPhieuXuat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `MaSanPham` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT cho bảng `user_table`
--
ALTER TABLE `user_table`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `nhapkho`
--
ALTER TABLE `nhapkho`
  ADD CONSTRAINT `nhapkho_ibfk_1` FOREIGN KEY (`MaPhieuNhap`) REFERENCES `phieunhaphang` (`MaPhieuNhap`),
  ADD CONSTRAINT `nhapkho_ibfk_2` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`);

--
-- Các ràng buộc cho bảng `phieunhaphang`
--
ALTER TABLE `phieunhaphang`
  ADD CONSTRAINT `phieunhaphang_ibfk_1` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`),
  ADD CONSTRAINT `phieunhaphang_ibfk_2` FOREIGN KEY (`MaNSX`) REFERENCES `nhasanxuat` (`MaNSX`),
  ADD CONSTRAINT `phieunhaphang_ibfk_3` FOREIGN KEY (`MaDaiLy`) REFERENCES `daily` (`MaDaiLy`);

--
-- Các ràng buộc cho bảng `phieuxuathang`
--
ALTER TABLE `phieuxuathang`
  ADD CONSTRAINT `phieuxuathang_ibfk_1` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`),
  ADD CONSTRAINT `phieuxuathang_ibfk_2` FOREIGN KEY (`MaDaiLy`) REFERENCES `daily` (`MaDaiLy`);

--
-- Các ràng buộc cho bảng `xuatkho`
--
ALTER TABLE `xuatkho`
  ADD CONSTRAINT `xuatkho_ibfk_1` FOREIGN KEY (`MaPhieuXuat`) REFERENCES `phieuxuathang` (`MaPhieuXuat`),
  ADD CONSTRAINT `xuatkho_ibfk_2` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
