<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["MaSanPham"]))
{
    $MaSanPham=$_POST["MaSanPham"];
}
else return;
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
if(isset($_POST["DungTich"]))
{
    $DungTich=$_POST["DungTich"];
}
else return;
if(isset($_POST["count_item"]))
{
    $count_item=$_POST["count_item"];
}
else return;
// if(isset($_POST["image_item"]))
// {
//     $image_item=$_POST["image_item"];
// }
// else return;

$query="INSERT INTO `sanpham`(`MaSanPham`, `TenSanPham`, `LoaiSanPham`, `DungTich`, `count_item`) VALUES ('$MaSanPham','$TenSanPham','$LoaiSanPham','$DungTich','$count_item')";
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