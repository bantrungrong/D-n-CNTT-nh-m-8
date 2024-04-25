<?php
include("dbconnection.php");
$con=dbconnection();

$query="SELECT `id_item`, `name_item`, `type_item`, `count_item`, `pice_item`, `status_item`, `image_item` FROM `product`";
$exe=mysqli_query($con,$query);
$arr=[];
while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}
print(json_encode($arr))
?>