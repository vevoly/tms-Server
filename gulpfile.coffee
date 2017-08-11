# 引入需要的包
gulp = require('gulp')
del = require('del')
runSequence = require('run-sequence')
developServer = require('gulp-develop-server')
notify = require('gulp-notify')

# 默认任务
gulp.task('default', (callback) ->
    runSequence(['clean'], ['copyFile'], ['serve', 'watch'], callback)
)

# 清空目录
gulp.task('clean', (callback) ->
    del('./dist/', callback)
)

# 复制文件
gulp.task('copyFile', ->
    gulp.src(['./src/**/*.js', './src/database*/*.db'])
    .pipe(gulp.dest('./dist/'))
)

# 服务
gulp.task('serve', ->
    developServer.listen({
        path: './dist/index.js'
    })
)

# 监控
gulp.task('watch', ->
    gulp.watch('./src/**/*.js', ['reload'])
)

# 重载
gulp.task('reload', (callback) ->
    runSequence(['copyFile'], ['reload-node'], callback)
)

# 重载节点
gulp.task('reload-node', ->
    developServer.restart()
    gulp.src('./dist/index.js')
        # 发送通知
        .pipe(notify('Server restarted ...'))

)