<?php
namespace Common\Controller;

use Common\Controller\HomebaseController;

class MemberbaseController extends HomebaseController{

	protected $user_model;
	protected $user;
	protected $userid;

	function _initialize() {
		parent::_initialize();

		$this->check_login();
        //修改为staff表  PanF  2017-02-22
		//$this->check_user();
		//by Rainfer <81818832@qq.com>
		if(sp_is_user_login()){
			$this->userid=sp_get_current_userid();
			//$this->users_model=D("Common/Users");
			//$this->user=$this->users_model->where(array("id"=>$this->userid))->find();
            $this->users_model= M('staff');
            $this->user=$this->users_model->where(array("staff_id"=>$this->userid))->find();
		}
	}

}