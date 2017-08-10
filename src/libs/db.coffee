Datastore = require('nedb');
config = require('./../config/config');

db = {}
dbPath = config.dbFilePath;

db.users = new Datastore({filename:dbPath + 'users.db', autoload:true})

module.exports = db