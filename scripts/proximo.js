// Description:
//   OOOOOOOOOOOOOOOOOOOOOOO, PRÓXIMOOOOO!
//
// Configuration:
//   LIST_OF_ENV_VARS_TO_SET
//
// Commands:
//   OOOOOOOOOOOOOOOOOOO - responde PRÓXIMOOOOO!
//
// Notes:
//   #cpbr10
//
// Author:
//   victorperin
'use strict';

module.exports = function (robot){
  robot.hear(/o{4,}/i, function (res){
    res.send('PRÓXIMOOOOOOOOOO!');
  });
};
