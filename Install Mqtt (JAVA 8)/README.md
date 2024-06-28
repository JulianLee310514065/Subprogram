##  1. 首先先安裝JAVA 8，然後要記住路徑
JAVA HOME之後會一直用到

## 2. 再來解壓縮兩個東西 
1. 04_apache-apollo-1.7.1-windows-distro -> 主要程式部分
2. 08_setting_apollo-20240614T094833Z-001 -> 輔助程式部分

## 3. 把04_apache-apollo-1.7.1-windows-distro放到C:\Program Files，然後跑08_setting_apollo-20240614T094833Z-001中的mqtt_db_create
會自己動，沒動就去對一下mqtt_db_create裡面的路徑

## 4. 移東西
1. 08_setting_apollo-20240614T094833Z-001內的apollo_mybroker_bin移到C:\Program Files\apache-apollo-1.7.1\bin\mybroker\bin
2. 08_setting_apollo-20240614T094833Z-001內的apollo_mybroker_etc移到C:\Program Files\apache-apollo-1.7.1\bin\mybroker\etc

## 5. 微調檔案
1. mybroker\etc\users中，添加admin=password
2. mybroker\etc\groups中，添加admins=wgnursing|admin

## 6. 試跑一次
在cmd中打`"C:\Program Files\apache-apollo-1.7.1\bin\mybroker\bin\apollo-broker"` run，如果沒有error，且還有port等資訊就是成功執行了