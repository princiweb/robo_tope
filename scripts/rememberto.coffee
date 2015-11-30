# Description:
#   Remember to someone something
#
# Commands:
#   hubot lembre o <user> em <val with unit> de <something to remember> - Lembre uma pessoa em um determinado tempo (s,m,h,d) de alguma coisa
#   hubot o que você se lembra? - Mostrar jobs ativos
#   hubot esqueça <id> - Remova um job

cronJob = require('cron').CronJob
moment = require('moment')

JOBS = {}

createNewJob = (robot, pattern, user, message) ->
  id = Math.floor(Math.random() * 1000000) while !id? || JOBS[id]
  job = registerNewJob robot, id, pattern, user, message
  robot.brain.data.things[id] = job.serialize()
  id

registerNewJobFromBrain = (robot, id, pattern, user, message) ->
  registerNewJob(robot, id, pattern, user, message)

registerNewJob = (robot, id, pattern, user, message) ->
  job = new Job(id, pattern, user, message)
  job.start(robot)
  JOBS[id] = job

unregisterJob = (robot, id)->
  if JOBS[id]
    JOBS[id].stop()
    delete robot.brain.data.things[id]
    delete JOBS[id]
    return yes
  no

handleNewJob = (robot, msg, user, pattern, message) ->
    id = createNewJob robot, pattern, user, message
    msg.send "Tope mano! Vou lembrar #{user.name} em #{pattern}"

module.exports = (robot) ->
  robot.brain.data.things or= {}

  # The module is loaded right now
  robot.brain.on 'loaded', ->
    for own id, job of robot.brain.data.things
      console.log id
      registerNewJobFromBrain robot, id, job...

  robot.respond /(o |)(que|q|ke|que que) voc(ê|e)( se|) lembra/i, (msg) ->
    text = ''
    for id, job of JOBS
      room = job.user.reply_to || job.user.room
      if room == msg.message.user.reply_to or room == msg.message.user.room
        text += "#{id}: #{job.pattern} @#{room} \"#{job.message}\"\n"
    if text.length > 0
      msg.send text
    else
      msg.send "Vish, tinha alguma coisa pra lembrar?"

  robot.respond /(forget|rm|remove|esqueca|delete|esqueça) (\d+)/i, (msg) ->
    reqId = msg.match[2]
    for id, job of JOBS
      if (reqId == id)
        if unregisterJob(robot, reqId)
          msg.send "Tope! O que era mesmo esse job #{id}?!"
        else
          msg.send "Não consigo esquecer isso, acho que estou traumatizado..."

  robot.respond /(me |eu |)lembr(e|a|e\-se)( o | )(me|eu|.*)( |)(que em|em|daqui(| a)) (\d+)([smhd]) (de|para|pra|que( el(e|a)| eu|)|tenho que|) (.*)/i, (msg) ->
    name = msg.match[4] || msg.match[1]
    at = msg.match[8]
    time = msg.match[9]
    something = msg.match[13]

    if /^(me|eu|pra mim)( |)$/i.test(name.trim())
      users = [msg.message.user]
    else
      users = robot.brain.usersForFuzzyName(name)

    if users.length is 1
      switch time
        when 's' then handleNewJob robot, msg, users[0], moment().add(at, "second").toDate(), something
        when 'm' then handleNewJob robot, msg, users[0], moment().add(at, "minute").toDate(), something
        when 'h' then handleNewJob robot, msg, users[0], moment().add(at, "hour").toDate(), something
        when 'd' then handleNewJob robot, msg, users[0], moment().add(at, "day").toDate(), something
    else if users.length > 1
      msg.send "Mano, seja mais específico, I conheço #{users.length} pessoas " +
        "com os seguintes nomes: #{(user.name for user in users).join(", ")}"
    else
      msg.send "#{name}? Nunca houvi falar desse ai!"



class Job
  constructor: (id, pattern, user, message) ->
    @id = id
    @pattern = pattern
    # cloning user because adapter may touch it later
    clonedUser = {}
    clonedUser[k] = v for k,v of user
    @user = clonedUser
    @message = message

  start: (robot) ->
    @cronjob = new cronJob(@pattern, =>
      @sendMessage robot, ->
      unregisterJob robot, @id
    )
    @cronjob.start()

  stop: ->
    @cronjob.stop()

  serialize: ->
    [@pattern, @user, @message]

  sendMessage: (robot) ->
    envelope = user: @user, room: @user.room
    message = @message
    if @user.mention_name
      message = "Ow, @#{envelope.user.mention_name}, não esqueça: " + @message
    else
      message = "Ow, @#{envelope.user.name} lembre-se: " + @message
    robot.send envelope, message
