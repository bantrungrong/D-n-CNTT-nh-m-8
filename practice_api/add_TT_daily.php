<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["MaDaiLy"]))
{
    $MaDaiLy=$_POST["MaDaiLy"];
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
if(isset($_POST["DienThoai"]))
{
    $DienThoai=$_POST["DienThoai"];
}
else return;
if(isset($_POST["SoTienNo"]))
{
    $SoTienNo=$_POST["SoTienNo"];
}
else return;



$query="INSERT INTO `daily`(`MaDaiLy`, `TenDaiLy`, `DiaChi`, `DienThoai`, `SoTienNo`) VALUES ('$MaDaiLy','$TenDaiLy','$DiaChi','$DienThoai','$SoTienNo')";
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