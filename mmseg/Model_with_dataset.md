# 內容分三段 (3 + 1)

### [0. 環境架設](https://github.com/JulianLee310514065/Miscellaneous/blob/main/mmseg/README.md)

[1. Model 製作](https://github.com/JulianLee310514065/Miscellaneous/blob/main/mmseg/Model_with_dataset.md)

2. Train
3. 
4. Test

---
## Model的製作 (改現成的)


* **主要運作**: 把**通用檔案**引入，再用**改dictionary的方式**微調
* **目的** : 想跑`!sh tools/dist_train.sh configs/swin/upernet_swin_base_patch4_window7_512x512_160k_ade20k_pretrain_224x224_1K.py 4`
* **思路** :
1. 想跑 `tools/dist_train.sh configs/swin/upernet_swin_base_patch4_window7_512x512_160k_ade20k_pretrain_224x224_1K.py`，發現是俄羅斯娃娃，裡面還有別的.py

![image](https://user-images.githubusercontent.com/101493861/170857368-fa7024fd-1f0a-42cf-ad12-c8c07dfa7695.png)

2. 解開套娃 `upernet_swin_tiny_patch4_window7_512x512_160k_ade20k_pretrain_224x224_1K.py`，結果裡面還有四隻娃

![image](https://user-images.githubusercontent.com/101493861/170857428-f275cbf3-0a1b-4a5e-abce-f785a5081133.png)

3. 逐步拆解最後的東西

#### 最後的東西(四套娃) : 
* [主Model](https://github.com/JulianLee310514065/Miscellaneous/blob/main/mmseg/upernet_swin.py) : `upernet_swin.py` -> 不太需要改，要注意單核時`SyncBN`需變`BN`，還有`num_classes= 你的層數`

```
變動: 
1. SyncBN or BN
2. num_classes = 你的層數
```

![image](https://user-images.githubusercontent.com/101493861/170878873-5c2414a9-dc7d-4b79-8860-61c9add074cf.png)

* [dataset](https://github.com/JulianLee310514065/Miscellaneous/blob/main/mmseg/stare.py) : `stare.py ` -> 很重要，**選自己需要的**，看你的資料型態(分類數、normalize的參數...)，我的data兩類，且也是醫學影像，所以選用stare dataset

```
變動:
transform: 
  img_scale = (800, 800)
  crop_size = (800, 800)
data: 
  samples_per_gpu=4,
  workers_per_gpu=4,
  img_dir='Train_Images',
  ann_dir='Train_Annotations_rgb'
```

![image](https://user-images.githubusercontent.com/101493861/170879081-d1754a12-3ca0-4f95-94e6-da05aed9048a.png)

* [dataset - stare](https://github.com/JulianLee310514065/Miscellaneous/blob/main/mmseg/dataset_stare.py) : `dataset_stare.py` -> 這邊要改**你的mask的顏色**，還比說你要切割貓狗，可能就要把貓的mask用成綠色，狗的用成藍色，**記住還要背景**。

```
變動: 
CLASSES = ('background', 'vessel')
PALETTE = [[0, 0, 0], [255, 255, 255]]
img_suffix='.jpg',
seg_map_suffix='.png',
```

![image](https://user-images.githubusercontent.com/101493861/170879454-df7b8440-28f4-4bd4-812d-f960664aac20.png)

* [runtime](https://github.com/JulianLee310514065/Miscellaneous/blob/main/mmseg/default_runtime.py) : `default_runtime.py` -> 不太需要動，主要是改interval，就是多久跟你說一次結果

```
變動: 
無
```

![image](https://user-images.githubusercontent.com/101493861/170879566-df667dd3-1cc9-4ac2-b38a-566c5b0781db.png)

* [lr_schedule](https://github.com/JulianLee310514065/Miscellaneous/blob/main/mmseg/schedule_160k.py) : `schedule_160k.py` -> 可以選要訓練多久，幾個epoch，不同時長有不同的eval & checkpoint，然後預設是SGD，且沒有warm up，這部分一班來說都會改寫。

```
變動
1. lr_config
2. optimizer、optimizer_config
```

![image](https://user-images.githubusercontent.com/101493861/170879729-870fb81b-3949-49df-bf6b-098729747ecd.png)

改寫

![image](https://user-images.githubusercontent.com/101493861/170879747-65df038f-b351-43fd-83b1-54535d193008.png)
