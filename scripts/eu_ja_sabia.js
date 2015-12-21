'use strict';
module.exports = function (robot) {
  robot.hear(/hoje é dia de assistir vídeo! :D/i, function (res) {
    res.send('Eu já sabia, ia falar isso antes... :(');
  });
  robot.hear(/ifttt/i, function (res){
    res.send('IFTTT is a web-based service that allows users to create chains of simple conditional statements, called "recipes", which are triggered based on changes to other web services such as Gmail, Facebook, Instagram, and Pinterest. IFTTT is an abbreviation of "If This Then That" (pronounced like "gift" without the "g").  http://bfy.tw/3NxP');
  });
};
