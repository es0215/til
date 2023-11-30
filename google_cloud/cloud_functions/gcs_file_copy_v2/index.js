// Google Cloud Storageライブラリをインポートします
const {Storage} = require('@google-cloud/storage');
// Storageクライアントを初期化します
const storage = new Storage();
// この関数は、新しいファイルがアップロードされるたびにトリガーされます
exports.copyFileToAnotherBucket = async (event, context, callback) => {
    // トリガーされたバケットとファイル名を取得します
    const file = storage.bucket(event.bucket).file(event.name);
    
    // 環境変数からGoogle CloudプロジェクトのIDを取得します
    const projectId = process.env.GCLOUD_PROJECT;
    // Google Cloud Storageから全てのバケットを取得します
    const [buckets] = await storage.getBuckets();
    // バケット名がパターン「${projectId}-〇〇〇-if」に一致するバケットだけを選択します
    const destinationBuckets = buckets.filter(bucket => bucket.name.match(`^${projectId}-\\w*-if$`));
    // 各バケットに対してファイルをコピーします
    const copyPromises = destinationBuckets.map(destinationBucket => {
        return file.copy(destinationBucket.file(event.name))
            .then(() => console.log(`File ${event.name} has been copied to ${destinationBucket.name}`)) // コピーが成功したら、ログにメッセージを表示します
            .catch(err => console.error('ERROR:', err)); // エラーが発生した場合は、それをログに表示します
    });
    // 全てのコピー操作が完了するのを待ちます
    return Promise.all(copyPromises)
        .then(() => callback()) // 全ての操作が成功したら、コールバックを呼び出して成功を通知します
        .catch(err => callback(err)); // 何か問題が発生した場合は、エラーメッセージをログに記録し、エラーを通知します
};
