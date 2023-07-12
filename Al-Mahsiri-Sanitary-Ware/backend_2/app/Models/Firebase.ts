import { BaseModel, column } from "@ioc:Adonis/Lucid/Orm";
import admin, { ServiceAccount } from 'firebase-admin';
import { DateTime } from 'luxon';
import User from './User';

const serviceAccount: ServiceAccount = require('../../al-mahsiri-sanitary-ware-firebase-adminsdk-8izfa-9f4ad58642.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://console.firebase.google.com/u/0/project/al-mahsiri-sanitary-ware/firestore/data/~2FUsers~2FoVTOK0uLJ4DYxtkhUtuo?view=panel-view&scopeType=collection&scopeName=%2FUsers&query='
});

class Firebase {
  db(): FirebaseFirestore.Firestore {
    return admin.firestore();
  }
}

export default Firebase;
