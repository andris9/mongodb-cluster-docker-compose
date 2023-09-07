sh.enableSharding("wildduck");
// consider using mailbox:hashed for messages only with large shard chunk size
sh.shardCollection("wildduck.messages", { mailbox: 1, uid: 1 });
sh.shardCollection("wildduck.archived", { user: 1, _id: 1 });
sh.shardCollection("wildduck.threads", { user: "hashed" });
sh.shardCollection("wildduck.authlog", { user: "hashed" });

sh.enableSharding("attachments");
// attachment _id is a sha256 hash of attachment contents
sh.shardCollection("attachments.attachments.files", { _id: "hashed" });
sh.shardCollection("attachments.attachments.chunks", { files_id: "hashed" });

// storage _id is an ObjectId
sh.shardCollection("attachments.storage.files", { _id: "hashed" });
sh.shardCollection("attachments.storage.chunks", { files_id: "hashed" });
