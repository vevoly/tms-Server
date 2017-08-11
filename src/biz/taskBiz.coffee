db = require('./../libs/db')
jwt = require('jsonwebtoken')
config = require('./../config/config')

# 添加任务
addTask = (req, res, next) ->
    body = req.body
    data = {
        taskName: body.taskName
        creator: 'admin'
        creatorDate: Date.now()
        updateDate: Date.now()
        status: 'InProgress'
        deleted: false
    }

    db.tasks.insert(data, (err, task) ->
        return next('创建任务失败，请重试！') if err
        return next('创建任务失败，请重试！') if !task
        return res.json(true)
    )

# 修改任务
updateTask = (req, res, next) ->
    body = req.body
    db.tasks.findOne(_id: body._id, (err, task) ->
        return next(err) if err
        return next('未找到要跟新的task') if !task
        db.tasks.update({_id: task_id}, {$set: {
            taskName : body.taskName
            updateDate : Date.now()
            status : body.status
            deleted: body.deleted || false
        }}, (err, numReplaced) ->
            return next(err) if err
            return next('更新失败，请重试') if numReplaced is 0
            res.json(true)
        )
    )

# 获取任务
getTask = (req, res, next) ->
    taskId = req.params.id
    db.tasks.findOne({_id: taskId}, (err, task) ->
        return next(err) if err
        res.json(task)
    )

# 获取任务列表
getTasks = (req, res, next) ->
    db.tasks.find({deleted: false, creator: 'admin'}, (err, tasks) ->
        return next(err) if err
        res.json(tasks)
    )


module.exports = {
    addTask : addTask
    updateTask : updateTask
    getTask : getTask
    getTasks : getTasks
}
