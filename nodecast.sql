/*
Navicat MySQL Data Transfer

Source Server         : local-mysql
Source Server Version : 50554
Source Host           : localhost:3306
Source Database       : nodecast

Target Server Type    : MYSQL
Target Server Version : 50554
File Encoding         : 65001

Date: 2017-12-12 17:43:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for topics
-- ----------------------------
DROP TABLE IF EXISTS `topics`;
CREATE TABLE `topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topics
-- ----------------------------
INSERT INTO `topics` VALUES ('4', '111', '11111', '1', '16', '2017-12-12 15:32:06', '2017-12-12 15:32:06');
INSERT INTO `topics` VALUES ('5', '文件操作 fs', '> 参考文档：https://nodejs.org/dist/latest-v9.x/docs/api/fs.html\r\n\r\n## 同步和异步\r\n\r\n对于文件操作，Node 几乎为所有的文件操作 API 提供了同步操作和异步操作两种方式。\r\n\r\n- 同步会阻塞程序的执行，效率低（知道就行）\r\n- 异步相当于多找了一个人帮你干活，效率高\r\n- 所以建议：尽量使用异步\r\n\r\n## 常用 API\r\n\r\n| API                                      | 作用        | 备注      |\r\n| ---------------------------------------- | --------- | ------- |\r\n| fs.access(path, callback)                | 判断路径是否存在  |         |\r\n| fs.appendFile(file, data, callback)      | 向文件中追加内容  |         |\r\n| fs.copyFile(src, callback)               | 复制文件      |         |\r\n| fs.mkdir(path, callback)                 | 创建目录      |         |\r\n| fs.readDir(path, callback)               | 读取目录列表    |         |\r\n| fs.rename(oldPath, newPath, callback)    | 重命名文件/目录  |         |\r\n| fs.rmdir(path, callback)                 | 删除目录      | 只能删除空目录 |\r\n| fs.stat(path, callback)                  | 获取文件/目录信息 |         |\r\n| fs.unlink(path, callback)                | 删除文件      |         |\r\n| fs.watch(filename[, options]\\[, listener]) | 监视文件/目录   |         |\r\n| fs.watchFile(filename[, options], listener) | 监视文件      |         |\r\n\r\n## 案例：Markdown 文件转换器\r\n\r\n> 需求：用户编写 md 格式的文件，实时的编译成 html 文件\r\n>\r\n> 使用 Node 提供的 API 结合 EcmaScript 6 语法\r\n\r\n## 文件操作的路径\r\n\r\n```javascript\r\n// 相对于当前路径\r\nfs.readFile(\'./README.md\')\r\n\r\n// 相对当前路径，可以省略 ./\r\n// 注意：加载模块中的标识路径不能省略 ./\r\nfs.readFile(\'README.md\')\r\n\r\n// 绝对路径\r\nfs.readFile(\'c:/README.md\')\r\n\r\n// 绝对路径，当前 js 脚本所处磁盘根目录\r\nfs.readFile(\'/README.md\')\r\n```\r\n\r\n## 文件操作的相对路径问题\r\n\r\n> 建议：以后操作文件使用相对路径都使用 `path.join()` 方法结合 `__dirname` 来避免问题。\r\n', '2', '12', '2017-12-12 15:50:05', '2017-12-12 15:50:05');
INSERT INTO `topics` VALUES ('6', '起步', '## 预备知识\r\n\r\n- HTML\r\n- CSS\r\n- JavaScript\r\n- 掌握基本的命令行操作\r\n- 具有服务端开发经验更佳\r\n\r\n## 安装 Node 环境\r\n\r\n- 查看当前 Node 环境的版本号\r\n- 下载：https://nodejs.org/en/download/\r\n  - 历史版本：https://nodejs.org/en/download/releases/\r\n- 安装\r\n  - 傻瓜式的一路 `next` 就可以了\r\n  - 对于已经装过的，重新安装就会升级\r\n- 确认 Node 环境是否安装成功\r\n  - 打开命令行，输入 `node --version`\r\n  - 或者 `node -v`\r\n- ​\r\n\r\n## REPL\r\n\r\n- read\r\n- eval\r\n- print\r\n- loop\r\n\r\n类似于浏览器中的 Console ，可以做一些代码测试。\r\n\r\n## Hello World\r\n\r\n1. 创建编写 JavaScript 脚本文件\r\n2. 打开终端，定位到脚本文件所属目录\r\n3. 输入 `node 文件名` 执行对应的文件\r\n\r\n> 注意：\r\n>\r\n> 文件名不要起名为 `node.js`\r\n>\r\n> 文件名或者文件路径最好不要有中文\r\n>\r\n> 文件路径或者文件名不要出现空格（如果真有空格手动加引号）\r\n\r\n\r\n\r\n## Hello World: 文件读写\r\n\r\n文件读取：\r\n\r\n```javascript\r\nfs.readFile(\'/etc/passwd\', (err, data) => {\r\n  if (err) throw err;\r\n  console.log(data);\r\n});\r\n```\r\n\r\n文件写入：\r\n\r\n```javascript\r\nfs.writeFile(\'message.txt\', \'Hello Node.js\', (err) => {\r\n  if (err) throw err;\r\n  console.log(\'The file has been saved!\');\r\n});\r\n```\r\n\r\n## Hello World: Http 服务\r\n\r\n```javascript\r\n// 接下来，我们要干一件使用 Node 很有成就感的一件事儿\r\n// 你可以使用 Node 非常轻松的构建一个 Web 服务器\r\n// 在 Node 中专门提供了一个核心模块：http\r\n// http 这个模块的职责就是帮你创建编写服务器的\r\n\r\n// 1. 加载 http 核心模块\r\nvar http = require(\'http\')\r\n\r\n// 2. 使用 http.createServer() 方法创建一个 Web 服务器\r\n//    返回一个 Server 实例\r\nvar server = http.createServer()\r\n\r\n// 3. 服务器要干嘛？\r\n//    提供服务：对 数据的服务\r\n//    发请求\r\n//    接收请求\r\n//    处理请求\r\n//    给个反馈（发送响应）\r\n//    注册 request 请求事件\r\n//    当客户端请求过来，就会自动触发服务器的 request 请求事件，然后执行第二个参数：回调处理函数\r\nserver.on(\'request\', function () {\r\n  console.log(\'收到客户端的请求了\')\r\n})\r\n\r\n// 4. 绑定端口号，启动服务器\r\nserver.listen(3000, function () {\r\n  console.log(\'服务器启动成功了，可以通过 http://127.0.0.1:3000/ 来进行访问\')\r\n})\r\n```\r\n', '1', '12', '2017-12-12 16:01:42', '2017-12-12 16:01:42');
INSERT INTO `topics` VALUES ('7', '卢本伟', '<script>\r\nalert(\"一梭子AK突突过去~~\")\r\n</script>', '1', '16', '2017-12-12 16:05:41', '2017-12-12 16:05:41');
INSERT INTO `topics` VALUES ('8', '卢本伟', '<script type=\"text/javascript\">\r\nalert(\"一梭子AK突突过去~~\")\r\n</script>', '1', '16', '2017-12-12 16:06:31', '2017-12-12 16:06:31');
INSERT INTO `topics` VALUES ('9', 'dsada', 'dsadsa', '1', '12', '2017-12-12 16:11:46', '2017-12-12 16:11:46');
INSERT INTO `topics` VALUES ('11', 'dsadsa', 'dsadsa', '1', '12', '2017-12-12 16:13:32', '2017-12-12 16:13:32');
INSERT INTO `topics` VALUES ('13', '全局成员', '> 参考文档：https://nodejs.org/dist/latest-v9.x/docs/api/globals.html\r\n\r\n- Class: Buffer\r\n- __dirname\r\n- __filename\r\n- clearImmediate(immediateObject)\r\n- clearInterval(intervalObject)\r\n- clearTimeout(timeoutObject)\r\n- console\r\n- exports\r\n- global\r\n- module\r\n- process\r\n- require()\r\n- setImmediate(callback[, ...args])\r\n- setInterval(callback, delay[, ...args])\r\n- setTimeout(callback, delay[, ...args])\r\n\r\n## `__dirname` 和 `filename`\r\n\r\n在每个模块中，除了 `require`、`exports` 等模块相关 API 之外，还有两个特殊的成员：\r\n\r\n- `__dirname` **动态获取** 可以用来获取当前文件模块所属目录的绝对路径\r\n- `__filename` **动态获取** 可以用来获取当前文件的绝对路径\r\n- `__dirname` 和 `__filename` 是不受执行 node 命令所属路径影响的\r\n\r\n在文件操作中，使用相对路径是不可靠的，因为在 Node 中文件操作的路径被设计为相对于执行 node 命令所处的路径（不是bug，人家这样设计是有使用场景）。\r\n\r\n所了为了解决这个问题，很简单，只需要把相对路径变为绝对路径就可以了。\r\n\r\n那这里我们就可以使用 `__dirname` 或者 `__filename` 来帮我们解决这个问题了。\r\n\r\n在拼接路径的过程中，为了避免手动拼接带来的一些低级错误，所以推荐多使用：`path.join()` 来辅助拼接。\r\n\r\n所以为了尽量避免刚才所描述这个问题，大家以后在文件操作中使用的相对路径都统一转换为 **动态的绝对路径**。\r\n\r\n> 补充：模块中的路径标识和这里的路径没关系，不受影响（相对于文件模块）\r\n\r\n---\r\n', '1', '12', '2017-12-12 16:14:53', '2017-12-12 16:14:53');
INSERT INTO `topics` VALUES ('14', '<script type=\"text/javascript\">window.open(\"http://192.168.182.73:3000/topic/11\",\"window2\");</script>', '<script type=\"text/javascript\">\r\n	setInterval(function(){window.open(\"http://192.168.182.73:3000/topic/11\",\"window2\");\r\n},10)\r\n</script>', '1', '16', '2017-12-12 16:17:07', '2017-12-12 16:17:07');
INSERT INTO `topics` VALUES ('19', '天秀', '<script>\r\n  for (var i = 0; i <= 10; i++) {\r\n   alert(\"卖竹鼠啦，一只三元，十元三只！\")\r\n  }\r\n</script>', '4', '17', '2017-12-12 16:32:56', '2017-12-12 16:32:56');
INSERT INTO `topics` VALUES ('27', 'dasd', '一拳一个嘤嘤怪，一脚一个竹鼠商', '1', '21', '2017-12-12 17:11:59', '2017-12-12 17:11:59');
INSERT INTO `topics` VALUES ('28', 'pdd', '哇~前面有一辆UU', '1', '16', '2017-12-12 17:14:00', '2017-12-12 17:14:00');
INSERT INTO `topics` VALUES ('30', 'maidsa', '买豆腐，一块两块，三块四块', '1', '21', '2017-12-12 17:14:15', '2017-12-12 17:14:15');
INSERT INTO `topics` VALUES ('31', '<script type=\"text/javascript\"> 	function(){ 		window.close(); 	} </script>', '<script type=\"text/javascript\">\r\n	function(){\r\n		window.close();\r\n	}\r\n</script>', '1', '16', '2017-12-12 17:21:57', '2017-12-12 17:21:57');
INSERT INTO `topics` VALUES ('32', '<script type=\"text/javascript\"> 	function (){ 		window.close(); 	}() </script>', '<script type=\"text/javascript\">\r\n	function (){\r\n		window.close();\r\n	}()\r\n</script>', '1', '16', '2017-12-12 17:23:37', '2017-12-12 17:23:37');
INSERT INTO `topics` VALUES ('33', '<script type=\"text/javascript\"> 	function (){ 		window.close(); 	}() </script>', '<script>\r\n		window.close()\r\n</script>', '1', '16', '2017-12-12 17:24:11', '2017-12-12 17:24:11');
INSERT INTO `topics` VALUES ('34', 'dsada', '鲁迅原名周树人，字豫才,浙江绍兴人', '1', '21', '2017-12-12 17:27:19', '2017-12-12 17:27:19');
INSERT INTO `topics` VALUES ('35', 'XXX', '他选择爬楼梯来锻炼自己的身板。他从没在意过“楼道墙壁里砌着一具男尸”的传闻。他也没仔细想过为什么每次下完夜班回来站在楼道前，楼道灯会悄声无息一路亮到四楼，他住的那层。直到有一天他偶然乘了电梯，一个血淋淋的脑袋从顶上垂下来“为什么要躲我？我每天都有帮你开灯啊。”', '1', '23', '2017-12-12 17:28:09', '2017-12-12 17:28:09');
INSERT INTO `topics` VALUES ('36', 'sfsa', '墨菲特原名石头人', '1', '21', '2017-12-12 17:28:38', '2017-12-12 17:28:38');
INSERT INTO `topics` VALUES ('37', '五五开', '冯提莫说:来开哥给你唱首凉凉\r\n发姐说:来,唠会磕', '2', '22', '2017-12-12 17:37:14', '2017-12-12 17:37:14');
INSERT INTO `topics` VALUES ('38', '哈哈哈', '儿子考完试回家，战战兢兢地对父亲说：爸，今天考试只得了60分。爸爸很生气的说：下次再考低了，就别叫我爸！ 第二天，儿子回来看见父亲说的第一句话是：对不起，哥。', '1', '23', '2017-12-12 17:37:34', '2017-12-12 17:37:34');
INSERT INTO `topics` VALUES ('39', 'test', 'why why why', '4', '19', '2017-12-12 17:37:53', '2017-12-12 17:37:53');
INSERT INTO `topics` VALUES ('40', '虫儿飞，鸟儿追，what are you say？？', '有点上头', '1', '16', '2017-12-12 17:38:19', '2017-12-12 17:38:19');
INSERT INTO `topics` VALUES ('41', 'wenwnenwen', '该话题正在被编辑.......', '2', '18', '2017-12-12 17:38:33', '2017-12-12 17:38:33');
INSERT INTO `topics` VALUES ('43', 'wwwwwwwwwwwwwwwwwwwwwwwwww', 'nnnnnnnnnnnnnnnnnn', '1', '20', '2017-12-12 17:40:33', '2017-12-12 17:40:33');
INSERT INTO `topics` VALUES ('44', '莫扎特', '来首小提琴可好?', '2', '19', '2017-12-12 17:42:16', '2017-12-12 17:42:16');
INSERT INTO `topics` VALUES ('45', 'das', '代码虐我千百遍，我对代码如初恋', '1', '21', '2017-12-12 17:42:51', '2017-12-12 17:42:51');

-- ----------------------------
-- Table structure for topic_categories
-- ----------------------------
DROP TABLE IF EXISTS `topic_categories`;
CREATE TABLE `topic_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic_categories
-- ----------------------------
INSERT INTO `topic_categories` VALUES ('1', '分享', '2017-12-12 11:45:20', '2017-12-12 11:45:22');
INSERT INTO `topic_categories` VALUES ('2', '问答', '2017-12-12 11:45:27', '2017-12-12 11:45:29');
INSERT INTO `topic_categories` VALUES ('3', '招聘', '2017-12-12 11:45:40', '2017-12-12 11:45:41');
INSERT INTO `topic_categories` VALUES ('4', '客户端测试', '2017-12-12 11:45:45', '2017-12-12 11:45:46');

-- ----------------------------
-- Table structure for topic_comments
-- ----------------------------
DROP TABLE IF EXISTS `topic_comments`;
CREATE TABLE `topic_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `userId` int(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic_comments
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `bio` varchar(100) DEFAULT '',
  `gender` bit(1) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('2', 'dsa@dsa.com', 'dsadsa', 'dsadsa', 'avatar-max-img.png', '', null, null, '\0', '2017-12-10 17:26:40', '2017-12-10 17:26:40');
INSERT INTO `users` VALUES ('4', 'lipengzhou@itcast.cn', '123456', 'lipengzhou', 'avatar-max-img.png', '', null, null, '\0', '2017-12-10 17:37:04', '2017-12-10 17:37:04');
INSERT INTO `users` VALUES ('5', '1084651458@qq.com', '123456789', '啊啊啊啊啊啊', 'avatar-max-img.png', '', null, null, '\0', '2017-12-10 18:11:00', '2017-12-10 18:11:00');
INSERT INTO `users` VALUES ('6', '110@qq.com', '123456', 'xiao', 'avatar-max-img.png', '', null, null, '\0', '2017-12-10 18:23:01', '2017-12-10 18:23:01');
INSERT INTO `users` VALUES ('7', 'lpz@itcast.cn', '123456', 'lpz', 'avatar-max-img.png', '', null, null, '\0', '2017-12-10 18:23:24', '2017-12-10 18:23:24');
INSERT INTO `users` VALUES ('8', '985994560@qq.com', '985994560', '嘤嘤嘤', 'avatar-max-img.png', '', null, null, '\0', '2017-12-10 18:23:39', '2017-12-10 18:23:39');
INSERT INTO `users` VALUES ('9', '12345@163.com', '123456', 'hh', 'avatar-max-img.png', '', null, null, '\0', '2017-12-10 18:24:09', '2017-12-10 18:24:09');
INSERT INTO `users` VALUES ('10', 'lpz123@dsa.com', '123456', 'lpzdsa', 'avatar-max-img.png', '', null, null, '\0', '2017-12-10 18:26:36', '2017-12-10 18:26:36');
INSERT INTO `users` VALUES ('11', 'zs@zs.com', '14e1b600b1fd579f47433b88e8d85291', 'zs', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 10:50:44', '2017-12-12 10:50:44');
INSERT INTO `users` VALUES ('12', 'lisi@lisi.com', '14e1b600b1fd579f47433b88e8d85291', 'lisi', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 10:55:50', '2017-12-12 10:55:50');
INSERT INTO `users` VALUES ('13', 'dnsajkdnsjka@dnsajkndjask.com', '14e1b600b1fd579f47433b88e8d85291', 'dsnaj', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 11:32:28', '2017-12-12 11:32:28');
INSERT INTO `users` VALUES ('14', 'dsadsadnkjsab@dbsjkabdjkas.copm', '14e1b600b1fd579f47433b88e8d85291', 'ndsajkndjksanbjk', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 11:35:58', '2017-12-12 11:35:58');
INSERT INTO `users` VALUES ('15', 'xiao@163.com', '63ee451939ed580ef3c4b6f0109d1fd0', 'crystal', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 11:41:29', '2017-12-12 11:41:29');
INSERT INTO `users` VALUES ('16', '976776565@qq.com', '13b9beb0088508b4c90a2b347d1640a8', '111', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 15:31:52', '2017-12-12 15:31:52');
INSERT INTO `users` VALUES ('17', '6shenme6@163.com', 'b537a06cf3bcb33206237d7149c27bc3', '蒂花之秀', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 16:27:53', '2017-12-12 16:27:53');
INSERT INTO `users` VALUES ('18', '1234@163.com', 'd9b1d7db4cd6e70935368a1efb10e377', 'ww', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 16:29:26', '2017-12-12 16:29:26');
INSERT INTO `users` VALUES ('19', 'cc@163.com', '14e1b600b1fd579f47433b88e8d85291', 'cc', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 16:30:31', '2017-12-12 16:30:31');
INSERT INTO `users` VALUES ('20', 'qwe@qwe.com', 'd9b1d7db4cd6e70935368a1efb10e377', 'xh', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 16:32:22', '2017-12-12 16:32:22');
INSERT INTO `users` VALUES ('21', '98599@qq.com', '14e1b600b1fd579f47433b88e8d85291', 'k', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 16:49:23', '2017-12-12 16:49:23');
INSERT INTO `users` VALUES ('22', '970405780@qq.com', 'c553cd79c92479afca0ffc1ffbaef608', 'joker', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 16:50:34', '2017-12-12 16:50:34');
INSERT INTO `users` VALUES ('23', '11111@jpg.com', '14e1b600b1fd579f47433b88e8d85291', '11111', 'avatar-max-img.png', '', null, null, '\0', '2017-12-12 17:12:45', '2017-12-12 17:12:45');
