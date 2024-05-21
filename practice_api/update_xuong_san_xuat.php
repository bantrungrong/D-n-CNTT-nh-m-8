<?php
include("dbconnection.php");
$con=dbconnection();

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
if(isset($_POST["MaPhanXuong"]))
{
    $MaPhanXuong=$_POST["MaPhanXuong"];
}
    
$query="UPDATE `xuongsanxuat` SET `TenPhanXuong`='$TenPhanXuong',`DiaChi`='$DiaChi' WHERE `MaPhanXuong`='$MaPhanXuong'"; 
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