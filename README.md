#  Faminance

Familiy & Finance







## シンプルで共有できる家計簿アプリ
誰もが見てすぐ使える
使い方について説明は不要







## アナログな感覚で
銀行やキャッシュレス決済などとの連携機能は作りません。
カテゴリーは最小限
収支各（４種類＋その他）のみ






### 課題

□マイメニュー
　・自分の情報を表示させる
　・家計簿の一覧を表示する
　・新しい家計簿を追加するを作る

□ホーム
　・月ベースの合計目標のバーを設置
　・キャッシュトランザクションビュー作成
　・キャッシュトランザクションの編集画面作成
　・できたらキャッシュトランザクションの一覧を日付区切り
　
□口座・財布
　・総資産
　・口座毎のキャッシュトランザクション一覧

□履歴
　・全てのキャッシュトランザクション一覧を表示
　・検索機能

□設定
　・currentFaminanceの設定
　・メインカテゴリーの追加、編集、削除
　・サブカテゴリーの追加、編集、削除
　・口座・財布の追加、編集、削除


□Firebase
　・ログアウト画面
　・ログイン画面
　・新規家計簿作成画面
　　→できればテンプレから選ばせたい
　・MyAccount情報の保存場所
　・画像のcacheデータの保存
　・リアルタイムでデータが変更したさいのイベント



□未知の課題
・各カテゴリーを削除する際に紐付いているキャッシュトランザクションの動きをどうするか
　案１：別のカテゴリーに移すか削除するか選択できるように
　案２：全て削除
　案３：フローティング状態のキャッシュトランザクションとして扱う
　　　　（アーカイブ状態）※案１の三つ目の選択肢になるかな

・各家計簿の管理者権限について
・既存の家計簿にユーザーを追加する際の動き



□いつの日かできたらいいな機能
・データベースで高度なトランザクションを可能にするため
　リレーショナルDBにリプレース
・メモとは別にハッシュタグをつけて検索、ソート機能の充実
・デイレクトリで見れる画面を作って、ドラッグ＆ドロップでキャッシュトランザクションを移動ができるように
・LINEなどと紐づけてチャットボットがアドバイスをくれるように
