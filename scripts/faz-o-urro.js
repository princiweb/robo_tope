// Description:
//   ele faz o urro
//
// Configuration:
//   LIST_OF_ENV_VARS_TO_SET
//
// Commands:
//   faz o urro - faz 10 urros separados por 3 segundos
//   faz o urro 3 - faz 3 urros separados por 3 segundos
//   faz o urro 3 1000 - faz 3 urros separados por 1 segundo
//   faz o duro - faz 10 duros separados por 3 segundos
//
// Notes:
//   Use com cuidado, esse script pode irritar os amiguinhos
//
// Author:
//   victorperin
'use strict';

let urrosEmExecucao = [];

module.exports = function (robot){
  robot.hear(/(faz o (\w*)ro)( \d+)?( \d+)?/i, function (res){
    const tipoDeUrro = res.match[2];
    const numeroDeUrros = res.match[3] || 3;
    const delayEntreUrros = res.match[4] || 3000;
    let urros = 0;

    const urroIndex = (-1) + urrosEmExecucao.push(
      setInterval(urrar, delayEntreUrros)
    );

    function urrar (){
      res.send(`FAZ O ${tipoDeUrro.toUpperCase()}RO!`);
      urros++;

      if(urros >= numeroDeUrros){
        clearInterval(urrosEmExecucao[urroIndex]);
        urrosEmExecucao.splice([urroIndex], 1);
      }
    };

  });

  robot.hear(/put the (cookie|\w*ro) down,?( now)?/i, function (res){
    urrosEmExecucao.forEach(clearInterval);
    urrosEmExecucao = [];
    res.send('Putting the cookie down, now.');
  });
};
