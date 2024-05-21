<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["MaPhieuNhap"]))
{
    $MaPhieuNhap=$_POST["MaPhieuNhap"];
}
else return;
if(isset($_POST["MaSanPham"]))
{
    $MaSanPham=$_POST["MaSanPham"];
}
else return;
if(isset($_POST["SoHieuXuong"]))
{
    $SoHieuXuong=$_POST["SoHieuXuong"];
}
else return;
if(isset($_POST["TenNguoiGiaoHang"]))
{
    $TenNguoiGiaoHang=$_POST["TenNguoiGiaoHang"];
}
else return;
if(isset($_POST["TenSanPham"]))
{
    $TenSanPham=$_POST["TenSanPham"];
}
else return;
if(isset($_POST["DonGia"]))
{
    $DonGia=$_POST["DonGia"];
}
else return;
if(isset($_POST["SoLuongNhap"]))
{
    $SoLuongNhap=$_POST["SoLuongNhap"];
}
else return;
if(isset($_POST["ThanhTien"]))
{
    $ThanhTien=$_POST["ThanhTien"];
}
else return;
if(isset($_POST["TongTien"]))
{
    $TongTien=$_POST["TongTien"];
}
else return;
if(isset($_POST["ChuKyViet"]))
{
    $ChuKyViet=$_POST["ChuKyViet"];
}
else return;
if(isset($_POST["ChuKyNhan"]))
{
    $ChuKyNhan=$_POST["ChuKyNhan"];
}
else return;
if(isset($_POST["ChuKyTruongDonVi"]))
{
    $ChuKyTruongDonVi=$_POST["ChuKyTruongDonVi"];
}
else return;



$query="INSERT INTO `phieunhaphang`(`MaPhieuNhap`, `MaSanPham`, `SoHieuXuong`, `TenNguoiGiaoHang`, `TenSanPham`, `DonGia`, `SoLuongNhap`, `ThanhTien`, `TongTien`, `ChuKyViet`, `ChuKyNhan`, `ChuKyTruongDonVi`) VALUES ('$MaPhieuNhap','$MaSanPham','$SoHieuXuong','$TenNguoiGiaoHang','$TenSanPham','$DonGia','$SoLuongNhap','$ThanhTien','$TongTien','$ChuKyViet','$ChuKyNhan','$ChuKyTruongDonVi')";
$exe=mysqli_query($con,$query);
$arr=[];
if($exe)
{
    $arr["success"]="true";
}
else
{
    $arr["success"]="false";
}
print(json_encode($arr));
?>  