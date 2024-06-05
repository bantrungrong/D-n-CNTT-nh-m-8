<?php
include("dbconnection.php");
$con=dbconnection();

$query="SELECT `MaSanPham`, `TenSanPham`, `LoaiSanPham`, `SoLuongTon`, `DonGia`, `HinhAnh` FROM `sanpham`";

$exe=mysqli_query($con,$query);
$arr=[];
while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}   
print(json_encode($arr))

?>