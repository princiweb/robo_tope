'use strict';

module.exports = function (robot) {
  robot.hear(/ping (.*)/i, function (res) {
    var http = require('http');

    var site = res.match[1];
    if(site.indexOf('http://') === -1){
      site = 'http://' + site;
    }
    res.send('Vou tentar enviar um request GET para ' + site);
    http.get(site, function (response) {
      res.send('https://http.cat/' + response.statusCode);
    }).on('error', function (e) {
      res.send('Dei pau!!!!11!\n' + e.message);
    });
  });

};
