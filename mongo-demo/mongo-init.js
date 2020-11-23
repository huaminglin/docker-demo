db.auth('dbadmin', 'example')

db = db.getSiblingDB('mydemo')

db.createUser({
  user: 'testu1',
  pwd: '123456',
  roles: [
    {
      role: 'readWrite',
      db: 'mydemo',
    },
  ],
});
