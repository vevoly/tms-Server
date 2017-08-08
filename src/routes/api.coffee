express = require('express')
router = express.Router()

router.get('/faq', (req, res, next) ->
    res.send('I\'m fine, tank you. .')
)

module.exports = router
