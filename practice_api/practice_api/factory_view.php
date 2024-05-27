<?php
include("dbconnection.php");
$con=dbconnection();

$query="SELECT `MaNSX`, `TenNSX`, `DiaChi`, `SoDienThoai` FROM `nhasanxuat`";

$exe=mysqli_query($con,$query);
$arr=[];
while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}   
print(json_encode($arr))

?>