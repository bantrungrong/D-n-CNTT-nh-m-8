<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["TenSanPham"]))
{
    $TenSanPham=$_POST["TenSanPham"];
}
else return;
if(isset($_POST["LoaiSanPham"]))
{
    $LoaiSanPham=$_POST["LoaiSanPham"];
}
else return;

if(isset($_POST["DonGia"]))
{
    $DonGia=$_POST["DonGia"];
}
else return;
if(isset($_POST["MaSanPham"]))
{
    $MaSanPham=$_POST["MaSanPham"];
}
else return;
    
$query="UPDATE `sanpham` SET `TenSanPham`='$TenSanPham',`LoaiSanPham`='$LoaiSanPham',`DonGia`='$DonGia' WHERE `MaSanPham`='$MaSanPham'"; 
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