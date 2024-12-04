// Google Cloud Storageライブラリをインポートします
const {Storage} = require('@google-cloud/storage');
const _ = require('lodash');
// Storageクライアントを初期化します
const storage = new Storage();
// この関数は、新しいファイルがアップロードされるたびにトリガーされます
exports.copyFileToAnotherBucket = async (event, context, callback) => {
    // ファイルがアップロードされたバケットの名前を取得します
    const sourceBucketName = event.bucket;
    // 環境変数からGoogle CloudプロジェクトのIDを取得します
    const projectId = _.escapeRegExp(process.env.GCLOUD_PROJECT);
    // バケット名がパターン「${projectId}-〇〇〇-if」に一致するか確認します
    if (!sourceBucketName.match(`^${projectId}-\\w*-if$`)) {
        console.log(`Bucket ${sourceBucketName} does not match the pattern. Exiting.`);
        callback();
        return;
    }
    // トリガーされたバケットとファイル名を取得します
    const file = storage.bucket(sourceBucketName).file(event.name);
    // ファイルをコピーする先のバケットを指定します
    const destinationBucket = storage.bucket('destination-bucket-name');
    // ファイルを新しいバケットにコピーします
    return file.copy(destinationBucket.file(event.name))
        .then(() => {
            // コピーが成功したら、ログにメッセージを表示します
            console.log(`File ${event.name} has been copied to ${destinationBucket.name}`);
            // コールバックを呼び出して、成功したことをCloud Functionsに通知します
            callback();
        })
        .catch(err => {
            // エラーが発生した場合は、それをログに表示します
            console.error('ERROR:', err);
            // エラーをコールバックに渡して、エラーが発生したことをCloud Functionsに通知します
            callback(err);
        });
};
