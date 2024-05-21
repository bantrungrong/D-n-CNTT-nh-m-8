<?php
include("dbconnection.php");
$con=dbconnection();

$query="SELECT `Thang`, `Nam`, `SoLuongXuat`, `MaSanPham`, `DoanhThu` FROM `thongkehangthang`";

$exe=mysqli_query($con,$query);
$arr=[];
while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}   
print(json_encode($arr))

?>