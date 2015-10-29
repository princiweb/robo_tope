module.exports = function (robot){
  robot.router.get('/',function (req,res){
    res.send('Ta bom mano, já acordei!!');
  });
};
