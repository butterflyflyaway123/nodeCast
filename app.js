
const express = require('express');   //加载express框架
const artTemplate = require('express-art-template');  //模板引擎
const config = require('./config');  //配置文件
const path = require('path');  //
const router=require('./router');  //加载路由配置文件
const  bodyParser = require('body-parser');
const session=require('express-session');


const app = express();  //获取express实例


// 开放静态资源
app.use('/public/', express.static(path.join(__dirname, './public/')));
app.use('/node_modules/', express.static(path.join(__dirname, './node_modules/')));

// 配置使用 art-template 模板引擎
app.engine('html', artTemplate);

//配置body-parser获取表单数据
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

//配置session插件
app.use(session({
  //配置加密字符串
  secret:'itcast',
  resave:false,
  saveUninitialized:true   //无论是否使用session,都会默认分配一把钥匙
}));

app.use(router); //加载router 使其生效，从而页面渲染

app.listen(config.port, () => {
  console.log(`App is running at port ${config.port}.`)
  console.log(`  Please visit http://127.0.0.1:${config.port}/`)
})
