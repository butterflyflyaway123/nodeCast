
const mysql=require('mysql');
const config=require('./config');

exports.query=function(){
    // console.log('db.query方法被调用了');
    //创建数据库连接资源
    const connection= mysql.createConnection(Object.assign(config.db,{})); // 合并对象--这样作的目的是为了后期添加数据的方便性
    //建立数据库连接
    connection.connect();
    //数据库相关操作
    connection.query(...arguments);  //...是用来展开数组，这样作的原因是query方法的参数不固定
    //关闭连接 释放资源
    connection.end();
}

