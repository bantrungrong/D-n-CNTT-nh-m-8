<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["MaPhieuXuat"]))
{
    $MaPhieuXuat=$_POST["MaPhieuXuat"];
}
else return;
if(isset($_POST["MaSanPham"]))
{
    $MaSanPham=$_POST["MaSanPham"];
}
else return;
if(isset($_POST["MaDaiLy"]))
{
    $MaDaiLy=$_POST["MaDaiLy"];
}
else return;
if(isset($_POST["count_item"]))
{
    $count_item=$_POST["count_item"];
}
else return;
if(isset($_POST["NgayXuat"]))
{
    $NgayXuat=$_POST["NgayXuat"];
}
else return;
if(isset($_POST["DonGia"]))
{
    $DonGia=$_POST["DonGia"];
}
else return;
if(isset($_POST["TenSanPham"]))
{
    $TenSanPham=$_POST["TenSanPham"];
}
else return;
if(isset($_POST["TenDaiLy"]))
{
    $TenDaiLy=$_POST["TenDaiLy"];
}
else return;
if(isset($_POST["DiaChi"]))
{
    $DiaChi=$_POST["DiaChi"];
}
else return;
if(isset($_POST["SoDienThoai"]))
{
    $SoDienThoai=$_POST["SoDienThoai"];
}
else return;
if(isset($_POST["NguoiNhan"]))
{
    $NguoiNhan=$_POST["NguoiNhan"];
}
else return;
if(isset($_POST["TongTien"]))
{
    $TongTien=$_POST["TongTien"];
}
else return;
if(isset($_POST["TongSP"]))
{
    $TongSP=$_POST["TongSP"];
}
else return;

$query="INSERT INTO `phieuxuathang`(`MaPhieuXuat`, `MaSanPham`, `MaDaiLy`, `count_item`, `NgayXuat`, `DonGia`, `TenSanPham`, `TenDaiLy`, `DiaChi`, `SoDienThoai`, `NguoiNhan`,`TongTien`,`TongSP`) VALUES ('$MaPhieuXuat','$MaSanPham','$MaDaiLy','$count_item','$NgayXuat','$DonGia','$TenSanPham','$TenDaiLy','$DiaChi','$SoDienThoai','$NguoiNhan','$TongTien','$TongSP')";
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