# MMsegmentation 手把手教學 --> 從環境架設!!! 到 跑出accuracy
> All data come from [mmsegmentation github](https://github.com/open-mmlab/mmsegmentation)



# 內容分三段 (3 + 1)

### [0. 環境架設](https://github.com/JulianLee310514065/Miscellaneous/blob/main/mmseg/README.md)

1. Model 製作
2. Train
3. Test


---
## 簡介: 

CSDN或是[MMseg官網](https://mmsegmentation.readthedocs.io/en/latest/train.html)很多教學，而且[也有中文](https://github.com/open-mmlab/mmsegmentation/blob/master/README_zh-CN.md)，mmseg文本中文的不少，寫的人應該是中國人搞不好，跟paddlepaddle各有千秋，**但是**，網路上的教學課程，簡潔的教你如何使用內建的Code去改，[詳細的](https://blog.csdn.net/weixin_44044411/article/details/118196847)教你如何從零到有自己創custom dataset, custom model...，卻**沒有**人，或很少人教你如何架環境，那他瑪的是最麻煩的阿，我她瑪的卡超久

--- 

## 0. 環境架設 -> 信我一把，環境好了，之後的程序就是喝水

我們要依序解決兩個問題，**mmcv + torch + cuda** 問題，我這裡稱第一個問題，第二個問題，**cv2的問題**
 
### 🔰 第一個問題🔰 : torch 跟 cuda 跟 mmcv 對不上
* **首先**: 先確認 cuda版本
![image](https://user-images.githubusercontent.com/101493861/170855618-20d36152-684c-4193-8aec-daea79df7c56.png)

* **再來是**: 確認 支持該cuda的版本的 **mmcv**，沒錯根本還沒到mmsegmentation.
![image](https://user-images.githubusercontent.com/101493861/170856422-f49325da-766d-4b1e-b1e5-1e4eabdf0a81.png)


* **第三**: 最重要的，找符合的 torch，上面只有 torch 1.10 跟 torch 1.11 可以，所以你必須去找 torch 1.10.0 +cu113
![image](https://user-images.githubusercontent.com/101493861/170855848-9bc59abe-fe85-433b-a564-a7ead69a1527.png)

安裝完成後，請確認 `torch.__version__` 是 1.10.x+cu113 或是 1.11.x+cu113

### 以下組合都不行 (我都試過了)
1. cuda 11.6 或是 cuda 11.4，我是用TWCC做訓練，所以cuda版本可調，但是一般人裝在自己的電腦時，光是cuda + cudnn就要排列組合了，何來調，沒有就是沒有，又或者我用網路資源(AWS)給的是cuda 11.0，則表對下來 我只能用 torch 1.7.0，你可能會納悶，為啥cuda 10.2 可以用到 torch 1.11但我只能用 torch 1.7.0 ?，我也不知道。
2. torch 1.11.0+cu102，沒錯torch版本對了，但cuda不對，也她瑪不行
3. torch 1.9.0+9acxxxxx，我安裝下來是這樣，反正就是連torch的版本都不對了
4. torch 1.11.0 ，版本對了，沒+cu113，還是不行

順帶一提，你的常客有:
```
[MMSegmentation] ImportError: libtorch_cuda_cu.so: cannot open shared object file
or
libtorch_cuda_cu.so: cannot open shared object file
```

千試萬試後，終於找到完美的code

```
pip install torch==1.10.0+cu113 torchvision==0.11.1+cu113 torchaudio===0.10.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
```

這樣就是有了

![image](https://user-images.githubusercontent.com/101493861/170856298-f8cd1612-1d0e-4f82-b8d1-81458bc827da.png)

* **第四**: 安裝 mmcv，請找[對應的版本](https://github.com/open-mmlab/mmcv)，對我來說是

```
!pip install mmcv-full -f https://download.openmmlab.com/mmcv/dist/cu113/torch1.10.0/index.html
```

* **第五**: 跑 mmsegmentation/demo資料夾裡面的 inference_demo.ipynb.ipynb，或是執行以下指令
```
from mmseg.apis import init_segmentor, inference_segmentor, show_result_pyplot
from mmseg.core.evaluation import get_palette
```

沒 Error 就行，**但是你會發現有 Error**



---
### 🔰 第二個問題 🔰 : cv2問題
大致有

* **第一**: opencv-python跟 opencv-python-headless的問題

![image](https://user-images.githubusercontent.com/101493861/170856595-3beb1370-6ad5-4f02-9a54-f0be2e724236.png)

好比說

`cannot import name '_registerMatType' from 'cv2.cv2'`

解法是我也不知道，反正我照[stackoverflow](https://stackoverflow.com/questions/70537488/cannot-import-name-registermattype-from-cv2-cv2)用可以跑


* **第二**: lib問題，舉凡libsm6 libxrender1 libfontconfig1 ...等

舉例 `libSM.so.6: cannot open shared object file: No such file or directory`

解法就是把跟cv2有關的lib全部升級一次就對了，在terminal打

```
sudo apt update
sudo apt-get install libsm6 libxrender1 libfontconfig1 libgl1-mesa-glx
```

再來就跑，應該要能動
```
from mmseg.apis import init_segmentor, inference_segmentor, show_result_pyplot
from mmseg.core.evaluation import get_palette
```

