# Run Verdaccio

這個專案利用 Verdaccio 專案架設私有 npm registry。預設可以創建一個使用者，知道該使者名稱與密碼的人可以將開發的 scoped package 發佈到這個 npm registry，且可以安裝這上面的套件。以此來達成團隊內部開發的套件的共享與簡單的權限管理工作。

<br>


## 啟動 Verdaccio container

```bash
$ bash run.bash
...
$ docker ps -a      # 檢查有沒有成功啟動
...
```

成功啟動後可以在瀏覽器訪問 http://localhost:4873 查看 Verdaccio 首頁。

<br>


## 創建使用者

若是初次啟動本專案的 verdaccio container，需要創建一個使用者。後續發布套件或安裝套件都需要使用者個使用者的身份。目前設置只允許創建一個使用者，因此這個使用者將作為團隊共用的管理者帳號。

若是已經在本專案的 verdaccio container 創建過使用者了，則不需要再執行這一步。

```bash
$ bash adduser.bash
```

<br>


## 使用者登入

假設該 verdaccio container 所在的主機 ip 為 xxx.xxx.xxx.xxx。

```bash
$ npm login --registry http://xxx.xxx.xxx.xxx:4873
```

<br>


## 設定 scoped packages 預設 registry

假設在該 registry 上有一個 scope 名為 @myorg，設定當發佈/安裝來自 @myorg 的套件時自動至指定的目標 registry 尋找。

```bash
$ npm config set @myorg:registry http://xxx.xxx.xxx:4873
```

<br>


## 如何創建一個 scoped package

```bash
$ mkdir mypackage && cd mypackage
mypackage$ npm init --scope myorg
...
npm publish
...
```

<br>


## 安裝來自該 registry 的套件

```bash
$ mkdir app && cd app
app$ npm init -y
...
app$ npm install @myorg/mypackage
...
```
