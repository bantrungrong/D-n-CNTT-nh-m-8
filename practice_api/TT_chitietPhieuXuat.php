<?php
include("dbconnection.php");
$con=dbconnection();

$query="SELECT `MaPhieu`, `MaDaiLy`, `MaSanPham`, `SoLuongXuat`, `DonGia`, `TongTien` FROM `chitietphieuxuathang`";

$exe=mysqli_query($con,$query);
$arr=[];
while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}   
print(json_encode($arr))

?>