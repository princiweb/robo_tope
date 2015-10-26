'use strict';
module.exports = function (robot) {
  robot.hear(/hoje é dia de assistir vídeo! :D/i, function (res) {
    res.send('Eu já sabia, ia falar isso antes... :(');
  });
};
