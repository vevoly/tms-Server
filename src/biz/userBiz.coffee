db = require('./../libs/db')

validUserExists = (req, res, next) ->
    body = req.body
    return next('请提交注册信息') if not body or not body.username or not body.password
    db.users.findOne({username: body.username}, (err, user) ->
        return next(err) if err
        if user
           return next('用户已注册，无法再次注册！')
        next()
    )

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

module.exports = {
        validUserExists : validUserExists
        register: register
}