<?php
include("dbconnection.php");
$con=dbconnection();

$query="SELECT `MaPhieuNhap`, `MaSanPham`, `SoHieuXuong`, `TenNguoiGiaoHang`, `TenSanPham`, `DonGia`, `SoLuongNhap`, `ThanhTien`, `TongTien`, `ChuKyViet`, `ChuKyNhan`, `ChuKyTruongDonVi` FROM `phieunhaphang`";

$exe=mysqli_query($con,$query);
$arr=[];
while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}   
print(json_encode($arr))

?>