// Google Cloud Storageライブラリをインポートします
const { Storage } = require('@google-cloud/storage');
// Cloud Loggingライブラリをインポートします
const { Logging } = require('@google-cloud/logging');
// StorageクライアントとLoggingクライアントを初期化します
const storage = new Storage();
const logging = new Logging();

// この関数は、新しいファイルがアップロードされるたびにトリガーされます
exports.copyFileToAnotherBucket = async (event, context) => {
    // ファイルがアップロードされたバケットの名前を取得します
    const sourceBucketName = event.bucket;
    // 環境変数からGoogle CloudプロジェクトのIDを取得します
    const projectId = process.env.GCLOUD_PROJECT;
    
    // バケット名がパターン「${projectId}-〇〇〇-if」に一致するか確認します
    if (!sourceBucketName.match(`^${projectId}-\\w*-if$`)) {
        console.error(`Bucket ${sourceBucketName} does not match the pattern. Exiting.`);
        return;
    }

    // トリガーされたバケットとファイル名を取得します
    const file = storage.bucket(sourceBucketName).file(event.name);
    // ファイルをコピーする先のバケットを指定します
    const destinationBucket = storage.bucket('destination-bucket-name');

    try {
        // ファイルを新しいバケットに非同期でコピーします
        await file.copy(destinationBucket.file(event.name));
        // コピーが成功したら、ログにメッセージを表示します
        console.log(`File ${event.name} has been copied to ${destinationBucket.name}`);
    } catch (err) {
        // エラーが発生した場合は、それをログに表示します
        console.error('ERROR:', err);
        // エラーログをCloud Loggingに書き込みます
        await logError(err);
    }
};

// エラーログをCloud Loggingに書き込む関数
async function logError(error) {
    const log = logging.log('errors');
    const entry = log.entry({
        severity: 'error',
        message: error.message,
        // 他にもエラーに関する情報を追加できます
    });

    await log.write(entry);
}
