express = require('express')
router = express.Router()
userBiz = require('./../biz/userBiz')

# 测试接口
router.get('/user/test', (req, res) ->
    res.send('xxx')
)

router.post('/user/test2', userBiz.test)

# 注册接口
router.post(
    '/user/register'
    userBiz.validUserExists
    userBiz.register
)

###router.post('/user/register', (req, res, next) ->
    res.send('/user/register')
)###

# 登录接口
router.post(
    '/user/login'
    userBiz.login
)

module.exports = router