db = require('./../libs/db')
jwt = require('jsonwebtoken')
config = require('./../config/config')

# 测试
test = (req, res, next) ->
    body = req.body
    res.send('没有参数信息！') if not body
    res.send(body.username) if body.username
    res.send(body.password) if body.password


# 验证用户是否存在
validUserExists = (req, res, next) ->
    body = req.body
    return next(new Error('请提交注册信息')) if not body or not body.username or not body.password
    db.users.findOne({username: body.username}, (err, user) ->
        return next(err) if err
        if user
           return next(new Error('用户已注册，无法再次注册！'))
        next()
    )

# 注册
register = (req, res, next) ->
    body = req.body

    postData = {
        username: body.username
        password: body.password
        token: ''
        expiredTime: Date.now()
    }

    #插入数据
    db.users.insert(postData, (err, user) ->
        return next(err) if err
        res.json(true)
    )

# 登录
login = (req, res, next) ->
    body = req.body
    #console.log(new Error('请输入账号和密码！'))
    return res.send(new Error('请输入账号和密码！')) if !body
    username = body.username
    password = body.password
    console.log('username = ' + username + ', password = ' + password)
    token = jwt.sign({username: username}, config.secret)
    expiredTime = Date.now() + 1000 * 60 * 60 * 24
    #console.log('token = ' + token)
    # 查记录
    db.users.findOne({username: username, password: password}, (err, user) ->
        return res.send(err) if err
        return res.send(new Error('无此用户，登陆失败，请重试！')) if !user

        db.users.update({_id:user._id}, {$set: {token:token, expiredTime: expiredTime}}, (err, numReplaced) ->
            return res.send(err) if err
            return res.send(new Error('登录失败，请重试！')) if numReplaced is 0
        )
        res.json({token:token})
    )

module.exports = {
        test: test
        validUserExists : validUserExists
        register: register
        login: login
}