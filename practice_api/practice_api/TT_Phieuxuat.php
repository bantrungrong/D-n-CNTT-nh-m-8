<?php
include("dbconnection.php");
$con=dbconnection();

$query="SELECT `MaPhieu`, `MaDaiLy`, `TenNguoiNhan`, `NgayXuat`, `ChuKyViet`, `ChuKyNhan`, `ChuKyTruongDonVi`, `NgayCapMinistry`, `SoGiayChungNhan` FROM `phieuxuathang`";

$exe=mysqli_query($con,$query);
$arr=[];
while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}   
print(json_encode($arr))

?>