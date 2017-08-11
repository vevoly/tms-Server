express = require('express')
router = express.Router()
taskBiz = require('./../biz/taskBiz')
commonBiz = require('./../biz/commonBiz')

# 新增接口
router.post('/task'
    #commonBiz.setUserInfo
    #commonBiz.validateUserInfo
    taskBiz.addTask
)

# 修改接口
router.put('/task'
    #commonBiz.setUserInfo
    #commonBiz.validateUserInfo
    taskBiz.updateTask
)

# 根据id获取
router.get('/task/:id'
    #commonBiz.setUserInfo
    #commonBiz.validateUserInfo
    taskBiz.getTask
)

# 获取全部
router.get('/task'
    #commonBiz.setUserInfo
    #commonBiz.validateUserInfo
    taskBiz.getTasks
)


module.exports = router