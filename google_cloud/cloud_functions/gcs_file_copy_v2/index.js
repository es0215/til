const { Storage } = require('@google-cloud/storage');

// Cloud Functions からトリガーされるメインの関数
exports.copyFileToAnotherBucket = async (event, context, callback) => {
  // ファイルがアップロードされたバケットの名前を取得
  let sourceBucketName = (event && event.bucket) || (event && event.data && JSON.parse(Buffer.from(event.data, 'base64').toString()).bucket);

  if (!sourceBucketName) {
    console.log('Bucket name is undefined. Trying to retrieve from context.');
    const contextBucketName = (context && context.resource && context.resource.name) || '';
    console.log('Context resource name:', contextBucketName);
    
    // ファイル名の部分を除外してバケット名だけを抽出
    const lastSlashIndex = contextBucketName.lastIndexOf('/');
    if (lastSlashIndex !== -1) {
      sourceBucketName = contextBucketName.substring(0, lastSlashIndex);
      console.log(`Bucket name retrieved from context: ${sourceBucketName}`);
    } else {
      console.log('Bucket name is still undefined. Exiting.');
      callback();
      return;
    }
  }

  // 環境変数からGoogle CloudプロジェクトのIDを取得
  const projectId = process.env.GCLOUD_PROJECT || (context && context.resource && context.resource.projectId);

  if (!projectId) {
    console.error('Failed to retrieve project ID from environment variables or context.');
    callback();
    return;
  }

  // バケット名がパターン「${projectId}-〇〇〇-if」に一致するか確認
  if (!sourceBucketName.match(`^${projectId}-\\w*-if$`)) {
    console.log(`Bucket ${sourceBucketName} does not match the pattern. Exiting.`);
    callback();
    return;
  }

  // トリガーされたバケットとファイル名を取得します
  const fileName = (event && event.name) || (event && event.data && JSON.parse(Buffer.from(event.data, 'base64').toString()).name);
  const file = new Storage().bucket(sourceBucketName).file(fileName);

  // ファイルをコピーする先のバケットを指定します
  const destinationBucket = new Storage().bucket('destination-bucket-name');

  try {
    // ファイルを新しいバケットに非同期でコピー
    await file.copy(destinationBucket.file(fileName));
    // コピーが成功したら、ログにメッセージを表示します
    console.log(`File ${fileName} has been copied to ${destinationBucket.name}`);
    callback();
  } catch (err) {
    // エラーが発生した場合は、それをログに表示します
    console.error('ERROR:', err);
    // エラーをコールバックに渡して、エラーが発生したことをCloud Functionsに通知します
    callback(err);
  }
};
