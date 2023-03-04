/*
Created		08/11/2022
Modified		09/11/2022
Project		
Model			
Company		
Author		
Version		
Database		MS SQL 2005 
*/


Create table [NGUOI_DUNG]
(
	[MaNguoiDung] Char(10) NOT NULL, UNIQUE ([MaNguoiDung]),
	[HoTen] Nvarchar(50) NOT NULL,
	[SoDienThoai] Char(10) NOT NULL Constraint [ck_DienThoai] Check (SoDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	[NgaySinh] Datetime NULL,
	[Email] Char(20) NULL,
	[C-point] Integer NULL,
	[DiemKHTT] Integer NULL,
	[VaiTro] Char(5) NOT NULL,
	[OTP] Integer NOT NULL,
	[NgayDangKy] Datetime NOT NULL,
Primary Key ([MaNguoiDung])
) 
go

Create table [SAN_PHAM]
(
	[MaSanPham] Char(10) NOT NULL, UNIQUE ([MaSanPham]),
	[TenSanPham] Nvarchar(50) NOT NULL,
	[MauSach] Nvarchar(10) NOT NULL,
	[KichCo] Char(3) NOT NULL,
	[GiaCu] Money NULL,
	[GiaMoi] Money NOT NULL,
	[TenChatLieu] Nvarchar(20) NOT NULL,
	[MoTa] Nvarchar(250) NOT NULL,
	[HuongDanSuDung] Nvarchar(300) NULL,
	[YeuThich] Bit Default 0 NOT NULL,
	[MaLoaiSanPham] Char(10) NOT NULL,
	[MaKhuyenMai] Char(10) NULL,
Primary Key ([MaSanPham])
) 
go

Create table [DON_HANG]
(
	[MaDonHang] Char(10) NOT NULL, UNIQUE ([MaDonHang]),
	[NgayDat] Datetime NOT NULL,
	[PhuongThucThanhToan] Nvarchar(20) NOT NULL,
	[DiaChiGiaoHang] Nvarchar(50) NOT NULL,
	[SoC-pont] Integer NULL,
	[MaNguoiDung] Char(10) NOT NULL,
Primary Key ([MaDonHang])
) 
go

Create table [LOAI_SAN_PHAM]
(
	[MaLoaiSanPham] Char(10) NOT NULL, UNIQUE ([MaLoaiSanPham]),
	[TenLoaiSanPham] Nvarchar(50) NOT NULL,
	[LoaiDoiTuong] Char(10) NOT NULL,
Primary Key ([MaLoaiSanPham])
) 
go

Create table [CUA_HANG]
(
	[MaCuaHang] Char(10) NOT NULL, UNIQUE ([MaCuaHang]),
	[TenCuaHang] Nvarchar(50) NOT NULL,
	[DiaChi] Nvarchar(50) NOT NULL,
	[SoDienThoai] Char(10) NOT NULL Check (ck_SoDienThoai),
	[GioMoCua] Datetime Default 7:00 NULL,
Primary Key ([MaCuaHang])
) 
go

Create table [VOUCHER]
(
	[MaVoucher] Char(10) NOT NULL, UNIQUE ([MaVoucher]),
	[TenVoucher] Nvarchar(20) NOT NULL,
	[SoLuong] Integer NOT NULL,
	[SoPhanTramGiam] Integer NULL,
Primary Key ([MaVoucher])
) 
go

Create table [KHUYEN_MAI]
(
	[MaKhuyenMai] Char(10) NOT NULL, UNIQUE ([MaKhuyenMai]),
	[TenKhuyenMai] Nvarchar(50) NOT NULL,
	[ThoiGianBatDau] Datetime NOT NULL,
	[ThoiGianKetThuc] Datetime NOT NULL,
	[SoPhanTramKM] Integer NOT NULL,
Primary Key ([MaKhuyenMai])
) 
go

Create table [TIN_TUC]
(
	[MaTinTuc] Char(10) NOT NULL, UNIQUE ([MaTinTuc]),
	[TieuDe] Nvarchar(50) NOT NULL,
	[NoiDung] Nvarchar(500) NOT NULL,
	[NgayDangTai] Datetime NOT NULL,
	[MaNguoiDung] Char(10) NOT NULL,
Primary Key ([MaTinTuc])
) 
go

Create table [HINH_ANH]
(
	[MaHinhAnh] Char(10) NOT NULL, UNIQUE ([MaHinhAnh]),
	[DuongDan] Nchar(100) NOT NULL,
	[MaSanPham] Char(10) NOT NULL,
	[MaTinTuc] Char(10) NOT NULL,
Primary Key ([MaHinhAnh])
) 
go

Create table [CHI_TIET_DON_HANG]
(
	[MaDonHang] Char(10) NOT NULL,
	[MaSanPham] Char(10) NOT NULL,
	[TrangThai] Nvarchar(20) NOT NULL,
	[DiemTichLuy] Integer NULL,
Primary Key ([MaDonHang],[MaSanPham])
) 
go

Create table [CUAHANG_SANPHAM]
(
	[MaSanPham] Char(10) NOT NULL,
	[MaCuaHang] Char(10) NOT NULL,
	[SoLuongSP] Integer NOT NULL,
Primary Key ([MaSanPham],[MaCuaHang])
) 
go

Create table [NGUOIDUNG_VOUCHER]
(
	[MaVoucher] Char(10) NOT NULL,
	[MaNguoiDung] Char(10) NOT NULL,
	[MaDonHang] Char(10) NULL,
Primary Key ([MaVoucher],[MaNguoiDung])
) 
go

Create table [GIO_HANG]
(
	[MaGioHang] Char(10) NOT NULL, UNIQUE ([MaGioHang]),
	[SoLuongMatHang] Integer NOT NULL,
	[MaNguoiDung] Char(10) NOT NULL,
Primary Key ([MaGioHang])
) 
go

Create table [GIOHANG_SANPHAM]
(
	[MaGioHang] Char(10) NOT NULL,
	[MaSanPham] Char(10) NOT NULL,
	[SoLuong] Integer NOT NULL Constraint [ck_SoLuong] Check (SoLuong >= 1),
Primary Key ([MaGioHang],[MaSanPham])
) 
go


Create Index [idHoTen] ON [NGUOI_DUNG] ([HoTen] ) 
go
Create Index [idTenCH] ON [CUA_HANG] ([TenCuaHang] ) 
go


Alter table [DON_HANG] add  foreign key([MaNguoiDung]) references [NGUOI_DUNG] ([MaNguoiDung])  on update no action on delete no action 
go
Alter table [NGUOIDUNG_VOUCHER] add  foreign key([MaNguoiDung]) references [NGUOI_DUNG] ([MaNguoiDung])  on update no action on delete no action 
go
Alter table [TIN_TUC] add  foreign key([MaNguoiDung]) references [NGUOI_DUNG] ([MaNguoiDung])  on update no action on delete no action 
go
Alter table [GIO_HANG] add  foreign key([MaNguoiDung]) references [NGUOI_DUNG] ([MaNguoiDung])  on update no action on delete no action 
go
Alter table [HINH_ANH] add  foreign key([MaSanPham]) references [SAN_PHAM] ([MaSanPham])  on update no action on delete no action 
go
Alter table [CHI_TIET_DON_HANG] add  foreign key([MaSanPham]) references [SAN_PHAM] ([MaSanPham])  on update no action on delete no action 
go
Alter table [CUAHANG_SANPHAM] add  foreign key([MaSanPham]) references [SAN_PHAM] ([MaSanPham])  on update no action on delete no action 
go
Alter table [GIOHANG_SANPHAM] add  foreign key([MaSanPham]) references [SAN_PHAM] ([MaSanPham])  on update no action on delete no action 
go
Alter table [CHI_TIET_DON_HANG] add  foreign key([MaDonHang]) references [DON_HANG] ([MaDonHang])  on update no action on delete no action 
go
Alter table [NGUOIDUNG_VOUCHER] add  foreign key([MaDonHang]) references [DON_HANG] ([MaDonHang])  on update no action on delete no action 
go
Alter table [SAN_PHAM] add  foreign key([MaLoaiSanPham]) references [LOAI_SAN_PHAM] ([MaLoaiSanPham])  on update no action on delete no action 
go
Alter table [CUAHANG_SANPHAM] add  foreign key([MaCuaHang]) references [CUA_HANG] ([MaCuaHang])  on update no action on delete no action 
go
Alter table [NGUOIDUNG_VOUCHER] add  foreign key([MaVoucher]) references [VOUCHER] ([MaVoucher])  on update no action on delete no action 
go
Alter table [SAN_PHAM] add  foreign key([MaKhuyenMai]) references [KHUYEN_MAI] ([MaKhuyenMai])  on update no action on delete no action 
go
Alter table [HINH_ANH] add  foreign key([MaTinTuc]) references [TIN_TUC] ([MaTinTuc])  on update no action on delete no action 
go
Alter table [GIOHANG_SANPHAM] add  foreign key([MaGioHang]) references [GIO_HANG] ([MaGioHang])  on update no action on delete no action 
go


Set quoted_identifier on
go


Set quoted_identifier off
go


