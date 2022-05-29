# 內容分三段 (3 + 1)

### [0. 環境架設](https://github.com/JulianLee310514065/Miscellaneous/blob/main/mmseg/README.md)

[1. Model 製作](https://github.com/JulianLee310514065/Miscellaneous/blob/main/mmseg/Model_with_dataset.md)
2. Train
3. Test

---
## Model的製作 (改現成的)


* **主要運作**: 把 主幹引入，再用**改dictionary的方式**微調
* **目的** : 跑 `!sh tools/dist_train.sh configs/swin/upernet_swin_base_patch4_window7_512x512_160k_ade20k_pretrain_224x224_1K.py 4`
* **思路** :
1. 想跑 `tools/dist_train.sh configs/swin/upernet_swin_base_patch4_window7_512x512_160k_ade20k_pretrain_224x224_1K.py`，發現是俄羅斯娃娃，裡面還有別的.py

![image](https://user-images.githubusercontent.com/101493861/170857368-fa7024fd-1f0a-42cf-ad12-c8c07dfa7695.png)

2. 解開套娃 `upernet_swin_tiny_patch4_window7_512x512_160k_ade20k_pretrain_224x224_1K.py`，結果裡面還有四隻娃

![image](https://user-images.githubusercontent.com/101493861/170857428-f275cbf3-0a1b-4a5e-abce-f785a5081133.png)

3. 一一拆解最後的東西
