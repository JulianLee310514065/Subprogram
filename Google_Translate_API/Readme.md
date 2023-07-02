# Google_Translate_API
> 透過Google雲端提供的API資源翻譯爬蟲刮下來的英文新聞

## 步驟
1. [需先開通Google Cloud服務](https://console.cloud.google.com/freetrial/signup/tos?hl=zh-tw)
2. [Quickstart](https://cloud.google.com/translate/docs/quickstarts?hl=zh_TW)
3. 建立Project $\rightarrow$ 開通API
4. [建立服務帳戶及下載金鑰](https://support.google.com/a/answer/7378726?hl=zh-Hant)，應為.json檔
5. 設置環境變數
6. 透過Python使用Google Translate API

## 開通Google Cloud服務、Quickstart、建立Projec、開通API
基本上照上面的說明做就可以了，Google有給新加入的人300美金的免費試用會員。

## 下載金鑰、設置環境變數
步驟四之開通API之後，會需要把API的金鑰下載下來，應該會是一個.json檔，**如下圖:**

![image](https://user-images.githubusercontent.com/101493861/197342544-ab43d069-89e5-4d06-bc2d-c887ba5982e8.png)

步驟五之在Python中**設置環境變數**

![image](https://user-images.githubusercontent.com/101493861/197342606-4801d290-7a5a-468c-9be4-eb0dbf44da8d.png)


## 透過Python使用API
需先`pip install google-cloud-translate==2.0.1`，基本上一般翻譯的話Basic就夠用了，然後查詢[語言代碼](https://support.google.com/googleplay/android-developer/table/4419860?hl=zh-Hant)，最後使用程式呼叫，官方給的Example基本上夠用。

```
translate_client = translate.Client()

def translate_text(target, text):
    """Translates text into the target language.

    Target must be an ISO 639-1 language code.
    See https://g.co/cloud/translate/v2/translate-reference#supported_languages
    """    
    if isinstance(text, six.binary_type):
        text = text.decode("utf-8")

    # Text can also be a sequence of strings, in which case this method
    # will return a sequence of results for each text.
    result = translate_client.translate(text, target_language=target)
    return result["translatedText"]
 ```
 
 ## 運用結果
 
 原文:
 ```
 (2/6) 1. According to Apple's plan, the Indian company Tata Group may cooperate with Pegatron or Wistron in the future to develop the iPhone assembly business. More than 80% of the iPhones made in India (by Foxconn) are currently to meet domestic demand.	
 ```
 翻譯結果:
 ```
 (2/6) 1、根據蘋果的計劃，印度公司塔塔集團未來可能與和碩或緯創合作，發展iPhone組裝業務。目前，印度製造的 80% 以上的 iPhone（由富士康生產）是為了滿足國內需求。
 ```
