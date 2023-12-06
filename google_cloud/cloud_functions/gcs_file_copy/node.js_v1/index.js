// Google Cloud Storageライブラリをインポートします
const {Storage} = require('@google-cloud/storage');
// Storageクライアントを初期化します
const storage = new Storage();
// この関数は、新しいファイルがアップロードされるたびにトリガーされます
exports.copyFileToAnotherBucket = (event, context, callback) => {
    // トリガーされたバケットとファイル名を取得します
    const file = storage.bucket(event.bucket).file(event.name);
    // ファイルをコピーする先のバケットを指定します
    const destinationBucket = storage.bucket('your-destination-bucket-name');
    
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
