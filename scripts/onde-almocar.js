'use strict';

const Conversation = require('hubot-conversation');

const locais = [
  'Subway',
  'Pizza Hut',
  'Mendes',
  'Casa do Yakisoba',
];

module.exports = function (robot) {

  const switchBoard = new Conversation(robot);

  robot.hear(/onde( vamos|) (almo(ç|c)ar|comer|jantar)\?/i, function (res) {
    const dialogo = switchBoard.startDialog(res);

    res.send('Vocês tem alguma preferência?\nSó me avise quando terminar');

    const verificarProximasRespostasDoUsuario = function () {
      dialogo.addChoice(/(.*)/i, function (respostaUsuario) {

        const mensagem = respostaUsuario.match[0];
        const regexDeVerificacaoSeFinaliou = /\W*(fim|(finaliz|termin|acab)(ar|ou)|(n(ã|a)o)?,?( ?é)? ?(s(ó|o))?( ?isso)?( ?mesmo)?)$/i;

        if (regexDeVerificacaoSeFinaliou.test(mensagem))
          return respostaUsuario.reply(`vocês podem ir em ${respostaUsuario.random(locais)}`);

        locais.push(mensagem);
        respostaUsuario.reply('ok, mais alguma preferência?');
        verificarProximasRespostasDoUsuario();
      });
    };

    verificarProximasRespostasDoUsuario();

  });

};
