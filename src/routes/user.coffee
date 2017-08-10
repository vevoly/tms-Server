express = require('express')
router = express.Router()
userBiz = require('./../biz/userBiz')

router.get('/user/test', (req, res) ->
    res.send('xxx')
)

router.post('/user/login', (req, res) ->
    res.send('/user/login')
)

# 注册接口
router.post(
    '/user/register'
    userBiz.validUserExists
    userBiz.register
)

module.exports = router