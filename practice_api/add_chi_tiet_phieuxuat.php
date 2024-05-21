<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["MaPhieu"]))
{
    $MaPhieu=$_POST["MaPhieu"];
}
else return;
if(isset($_POST["MaDaiLy"]))
{
    $MaDaiLy=$_POST["MaDaiLy"];
}
else return;
if(isset($_POST["MaSanPham"]))
{
    $MaSanPham=$_POST["MaSanPham"];
}
else return;
if(isset($_POST["SoLuongXuat"]))
{
    $SoLuongXuat=$_POST["SoLuongXuat"];
}
else return;
if(isset($_POST["DonGia"]))
{
    $DonGia=$_POST["DonGia"];
}
else return;
if(isset($_POST["TongTien"]))
{
    $TongTien=$_POST["TongTien"];
}
else return;


$query="INSERT INTO `chitietphieuxuathang`(`MaPhieu`, `MaDaiLy`, `MaSanPham`, `SoLuongXuat`, `DonGia`, `TongTien`) VALUES ('$MaPhieu','$MaDaiLy','$MaSanPham','$SoLuongXuat','$DonGia','$TongTien')";
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