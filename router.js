//0.加载express
const express = require('express');
//加载校验插件
const validator = require('validator');
//加载数据库
const db = require('./db-helper');
const md5 = require('blueimp-md5');
const marked = require('marked');
// db.query();
//1.调用express.Router()方法得到一个路由器
const router = express.Router();

//2.为路由器容器添加路由

//首页
router.get('/', (req, res) => {
    res.render('index.html', {
        user: req.session.user
    });
})

//登录页
router.get('/login', (req, res) => {
    res.render('login.html');
})

//注册页
router.get('/register', (req, res) => {
    res.render('register.html');
})

//注册页--表单提交
router.post('/register', (req, res) => {
    // 1. 获取表单数据
    //    配置 body-parser 来帮我们解析表单请求体数据
    const body = req.body;
    console.log(body);
    // 2. 验证客户端数据 -  基本的数据验证 使用一个第三方包：validator 辅助验证
    //-没有eamil || email为空 || email格式不正确
    if (!body.email || validator.isEmpty(body.email) || !validator.isEmail(body.email)) {
        //采用异步交互的方式提示用户
        return res.json({
            code: 400,  //客户端错误
            message: '邮箱无效'
        })
    }
    if (!body.nickname || validator.isEmpty(body.nickname)) {
        //采用异步交互的方式提示用户
        return res.json({
            code: 400,  //客户端错误
            message: '昵称无效'
        })
    }
    if (!body.password || validator.isEmpty(body.password)) {
        //采用异步交互的方式提示用户
        return res.json({
            code: 400,  //客户端错误
            message: '密码错误'
        })
    }

    //    基本的业务验证
    //      邮箱是否重复
    db.query('select *  from users where email=?', [body.email], function (err, data) {
        if (err) {
            return console.log('数据操作失败');
        }
        //表示已经存在该邮箱--如果邮箱可用就返回空数组
        if (data[0]) {
            return res.json({
                code: 1,
                message: '邮箱已存在'
            })
        }

        //      昵称是否重复
        db.query('select *  from users where nickname=?', [body.nickname], function (err, data) {
            if (err) {
                return console.log('数据操作失败');
            }
            //表示已经存在该邮箱--如果邮箱可用就返回空数组
            if (data[0]) {
                return res.json({
                    code: 2,
                    message: '昵称已存在'
                })
            }

            // 3. 存储到数据库
            //业务数据校验通过，创建用户
            db.query('insert into users set ?', {
                email: body.email,
                password: md5(body.password), //为了安全起见，也可双层md5处理
                nickname: body.nickname,
                avatar: 'avatar-max-img.png',
                createdAt: new Date,
                updatedAt: new Date
            }, function (err, data) {
                if (err) {
                    return res.json({
                        code: 500,
                        message: `server error ,${err.message}`
                    })
                }
                // 4. 发送响应
                //登录成功之前，在session中存储用户的 登录状态，注册成功，把用户的完整信息存储到session中
                //   console.log(data);
                db.query('select * from users where id=?', [data.insertId], function (err, ret) {
                    if (err) {
                        return res.json({
                            code: 500,
                            message: `server error ,${err.message}`
                        });
                    }
                    req.session.user = ret[0];
                    res.json({
                        code: 0,
                        message: 'ok'
                    });
                });


            });

        });
    });
}); //end post

//退出登录
router.get('/logout', (req, res) => {
    //清空session数据，
    //跳转到登录页面
    delete req.session.user;
    res.redirect('/login')
});

//登录处理
router.post('/login', (req, res) => {
    //1.接收表单数据
    const body = req.body;
    // 2.验证
    //基本数据验证
    if (!body.email || validator.isEmpty(body.email) || !validator.isEmail(body.email)) {
        return res.json({
            code: 400,
            message: '邮箱无效'
        });
    }
    if (!body.password || validator.isEmpty(body.password)) {
        return res.json({
            code: 400,
            message: '密码错误'
        });
    }
    //业务数据校验
    //发送响应，校验通过，就登录，校验失败，告诉用户
    const sqlStr = 'select * from users where email =? and password=?';
    db.query(sqlStr, [body.email, md5(body.password)], function (err, ret) {
        if (err) {
            return res.json({
                code: 500,
                message: err.message
            });
        }
        const user = ret[0];
        if (!user) {
            return res.json({
                code: 404,
                message: 'login falied'
            });
        }
        //校验成功，记录登录状态
        req.session.user = user;
        //    console.log(user);RowDataPacket {
        /*  id: 21,
         email: 'sunshine@qq.com',
         password: '202cb962ac59075b964b07152d234b70',
         nickname: 'sunshine',
         avatar: 'avatar-max-img.png',s
         bio: '',
         gender: null,[]
         birthday: null,
         isDeleted: <Buffer 00>,
         createdAt: 2017-12-12T12:21:38.000Z,
         updatedAt: 2017-12-12T12:21:38.000Z } */
        res.json({
            code: 0,
            message: 'ok'
        });
    });
});

//发布话题
//渲染发布话题页面
router.get('/topic/new', (req, res) => {
    //访问该页面必须是登录状态
    if (!req.session.user) {
        return res.redirect('/login');
    }
    //查询话题分类
    const sqlStr = 'select * from `topic_categories`';
    db.query(sqlStr, (err, ret) => {
        if (err) {
            return res.json({
                code: 500,
                message: err.message
            });
        }
        //处于登录状态 ，渲染发布话题页面
        res.render('topic/new.html', {
            topicCategories: ret
        });
    });

});

// 处理发布话题请求页面
router.post('/topic/new', (req, res) => {
    //1.接收表单数据
    const body = req.body;
    Object.assign(body, {
        userId: req.session.user.id,
        createdAt: new Date,
        updatedAt: new Date
    });
    //3.保存数据
    const sqlStr = 'insert into topics set?';
    db.query(sqlStr, body, function (err, ret) {
        if (err) {
            return res.json({
                code: 500,
                message: err.message
            });
        }
        //4。发送响应
        res.json({
            code: 0,
            message: 'ok',
            topicId: ret.insertId   //?????将创建的话题id发送给客户端，根据该id跳转到话题详情页面
        });
    });


});

//展示话题详情页面
router.get('/topic/:topicId', (req, res) => {
    const sqlStr = 'select * from topics where id=?';
    db.query(sqlStr, [req.params.topicId], function (err, ret) {
        if (err) {
            return res.json({
                code: 500,
                message: err.message
            });
        }
        const topic = ret[0];
        if (topic) {
            topic.content = marked(topic.content);   //将话题的marked格式转为html格式
        }
        res.render('topic/show.html', {
            topic,
            user: req.session.user
        });
    });
});

//删除话题
router.get('/topic/:topicId/delete', (req, res) => {
    //只有登录状态的用户才可以具有删除权限，而且删除的文章的作者必须是当前登录用户
    const user = req.session.user;   //保存当前登录用户的相关信息
    const topicId = req.params.topicId;
    if (!user) {
        return res.json({
            code: 400,
            message: 'no authorize'
        });
    }
    console.log(1);
    //查询要删除的文章是否存在
    db.query('select * from topics where id=?', [topicId], (err, ret) => {
        if (err) {
            return res.json({
                code: 500,
                message: err.message
            });
        }
        const topic = ret[0];
        //如果要删除的文章已经不存在
        if (!topic) {
            return res.json({
                code: 404,
                message: 'topic not exists'
            });
        }
        //如果文章存在，判断该文章是否属于当前登录用户
        if (topic.userId !== user.id) {  //不为当前用户
            return res.json({
                code: 400,
                message: 'no authorize'
            });
        }
        //验证通过执行删除操作
        // res.send('req.params.topicId');
        const sqlStr = "delete from topics where id=?";
        db.query(sqlStr, [req.params.topicId], (err, ret) => {
            if (err) {
                return res.json({
                    code: 500,
                    message: err.message
                });
            }
            res.redirect('/');
        });
    });



});

//编辑话题
router.get('/topic/:topicId/edit',(req,res)=>{
    // res.send(req.params.topicId);
    //查询板块信息
    db.query('select * from topic_categories',(err,categories)=>{
        if(err){  //查询操作执行失败
            return res.json({
                code:500,
                message:err.message
            });
        }

        //判断要编辑的话题是否存在
    db.query('select * from topics where id=?',[req.params.topicId],(err,ret)=>{
        if(err){  //查询操作执行失败
            return res.json({
                code:500,
                message:err.message
            });
        }
        //执行成功,渲染页面
       
        res.render('topic/edit.html',{
             user:req.session.user,  //在session中保存当前登录用户的信息
            topic:ret[0],
            categories
        });


    });
    
    });


});

//提交编辑后的话题
router.post('/topic/:topicId/edit',(req,res)=>{
   //1.
   const body = req.body;
   Object.assign(body, {
       userId: req.session.user.id,
       createdAt: new Date,
       updatedAt: new Date
   });
   //2.保存数据
   const sqlStr="update into topics set?";
   db.query(sqlStr,body,function(err,ret){
    if (err) {
        return res.json({
          code: 500,
          message: err.message
        })
      }
      res.json({
        code:0,
        message:'ok',
        topicId:ret.insertId
      });
   });
});


//3.导出路由容器对象
module.exports = router;