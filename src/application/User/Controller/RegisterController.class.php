<?php
namespace User\Controller;

use Common\Controller\HomebaseController;

class RegisterController extends HomebaseController {

	 protected $hosuser_model;

    /**
     * 验证是否开启记录
     * @author wuxin 2017/02/08
     */
    public function _initialize() {
        parent::_initialize();
        $this->hosuser_model = M('Hosuser');
        
    }
	
    // 前台用户注册
	public function index(){
	    // if(sp_is_user_login()){ //已经登录时直接跳到首页
	    //     redirect(__ROOT__."/");
	    // }else{
	        $this->display(":register");
	    // }
	}
	
	// 前台用户注册提交
	public function doregister(){
		$verify = sp_check_verify_code();
		if(!$verify){
	        $this->error("验证码错误！");
	    }
		$res = array();
		$param = I('param.');
		$map['idcard'] = $param['idcard'];
		$map['mobile'] = $param['mobile'];
		$map['_logic'] = "OR";
		$find = $this->hosuser_model->where($map)->find();
		if($find){
			$this->error("该用户已存在！");
		}
    	if(isset($param['hosuser_name'])){
    	    $res = array(
    	    	'hosuser_name' => trim($param['hosuser_name']),
    	    	'hosuser_password' => sp_password($param['hosuser_password']),
    	    	'idcard' => $param['idcard'],
    	    	'mobile' => $param['mobile'],
    	    	'email' => $param['email'],
    	    	'address' => trim($param['address']),
    	    );
    	    if($this->hosuser_model->data($res)->add()){
    			$this->success("注册成功！");
    		}else{
    			$this->error("注册失败！");
    		}
    	}

	}
	
	
}