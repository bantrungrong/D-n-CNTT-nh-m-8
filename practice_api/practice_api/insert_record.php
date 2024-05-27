<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["TenDangNhap"]))
{
    $TenDangNhap=$_POST["TenDangNhap"];
}
else return;
if(isset($_POST["MatKhau"]))
{
    $MatKhau=$_POST["MatKhau"];
}
else return;
if(isset($_POST["Congty"]))
{
    $Congty=$_POST["Congty"];
}
else return;
if(isset($_POST["email"]))
{
    $email=$_POST["email"];
}
else return;

$query="INSERT INTO `nguoidung`(`TenDangNhap`, `MatKhau`, `Congty`, `email`) VALUES ('$TenDangNhap','$MatKhau','$Congty','$email')";
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

