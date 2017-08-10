express = require('express')
router = express.Router()
db = require('./../libs/db')

router.get('/faq', (req, res, next) ->
    db.users.insert({test:'1'}, (err, user) ->
        return next(err) if err
        console.log(user)
        res.send(user)
    )
    #res.send('I\'m fine, tank you. .')
)

module.exports = router
