<?php
namespace User\Controller;

use Common\Controller\HomebaseController;

class LoginController extends HomebaseController {

    protected $hosuser_model;

    /**
     * 验证是否开启记录
     * @author wuxin 2017/02/08
     */
    public function _initialize() {
        parent::_initialize();
        $this->hosuser_model = M('Hosuser');
        
    }
    // 前台用户登录
	public function index(){
	    // $redirect=I('get.redirect','');
	    // if(empty($redirect)){
	    //     $redirect=$_SERVER['HTTP_REFERER'];
	    // }else{
	    //     $redirect=base64_decode($redirect);
	    // }
	    // session('login_http_referer',$redirect);

	    // if(sp_is_user_login()){ //已经登录时直接跳到首页
	    //     redirect(U("Xing/index"));
	    // }else{
	        $this->display(":login");
	    //}
	}

    public function dologin(){
        $verify = sp_check_verify_code();
        if(!$verify){
            $this->error("验证码错误！");
        }
        $res = array();
        $param = I('param.');
        $map['idcard'] = $param['user_name'];
        $map['mobile'] = $param['user_name'];
        $map['_logic'] = "OR";
        $find = $this->hosuser_model->where($map)->find();
        if(!$find){
            $this->error("该用户未注册！");
        }
        $where['hosuser_password'] = sp_password($param['hosuser_password']);
        $where["_complex"] = $map;
        $find = $this->hosuser_model->where($where)->find();
        if($find){
            $this->success("登录成功！");
        }else{
            $this->error("登录失败！");
        }
    }
	
}