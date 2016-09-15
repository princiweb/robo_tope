# Description:
#   CACHORRO?!
# Dependencies:
#   None
# Configuration:
#   None
# Commands:
#   E voce pequenininho que que se acho?
# Author:
#   victorperin

module.exports = (robot) ->

    eVocePequenininhoRegex = /(E (vc|voc(ê|e)) \S+inho (quando v(ê|e) (um(a|) |)\S+ assim (t(ã|a)o grande |)|)|)(o |)que (que |)(é |)que ((s|voc)(ê|e) |)achou?/i

    robot.hear eVocePequenininhoRegex, (res) ->
        res.send 'CACHORRO?! Eu não sou cachorro não!'
