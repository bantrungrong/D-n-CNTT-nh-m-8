<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["MaPhanXuong"]))
{
    $MaPhanXuong=$_POST["MaPhanXuong"];
}
else return;
if(isset($_POST["TenPhanXuong"]))
{
    $TenPhanXuong=$_POST["TenPhanXuong"];
}
else return;
if(isset($_POST["DiaChi"]))
{
    $DiaChi=$_POST["DiaChi"];
}
else return;
if(isset($_POST["MaSanPham"]))
{
    $MaSanPham=$_POST["MaSanPham"];
}
else return;



$query="INSERT INTO `xuongsanxuat`(`MaPhanXuong`, `TenPhanXuong`, `DiaChi`, `MaSanPham`) VALUES ('$MaPhanXuong','$TenPhanXuong','$DiaChi','$MaSanPham')";
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