# README

|user||
| ---- | ---- |
|id||
|name|string|
|email|string|
password_digest|string|

|task||
| ---- | ---- |
|id||
|user_id||
|title|string|
|end_limit|integer|
|priority|string|
|status|string|


|task_label||
| ---- | ---- |
|id||
|task_id(FK)||
|label_id(FK)||

|label||
| ---- | ---- |
|id||
|category|string|


メモ：
user
  id                    #タスクテーブルとアソシエーション
    name:string         #ユーザーの名前
    email:string        #ユーザーの連絡先
    password_digest:string  #ユーザーのパスワード


task
  id
  user_id(FK)           #ユーザーテーブルとアソシエーション
    title:string　      #タスクのタイトル
    end_limit:integer　 #タスクの終了期日
    priority：string    #タスクの優先度
    status:string       #タスクのステータス（未着手、着手、完了）

task_label（中間テーブル）
  id
  task_id(FK)           #中間テーブルとタスクテーブルのアソシエーション
  label_id(FK)           #中間テーブルとラベルテーブルのアソシエーション

label
  id                    #ラベルテーブルと中間テーブルとアソシエーション
  category              #labelの種類
