<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["MatKhau"]))
{
    $MatKhau=$_POST["MatKhau"];
}
else return;
if(isset($_POST["TenDangNhap"]))
{
    $TenDangNhap=$_POST["TenDangNhap"];
}
else return;
<<<<<<< HEAD
=======

>>>>>>> 937bad2e76a84ae544b47232a93e7e6aa0eb8cfe
    
$query="UPDATE `nguoidung` SET `MatKhau`='$MatKhau' WHERE `TenDangNhap`='$TenDangNhap'"; 
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