<?php
namespace User\Controller;

use Common\Controller\HomebaseController;

class IndexController extends HomebaseController {

    protected $dept_model;
    protected $disease_model;
    /**
     * 验证是否开启记录
     * @author wuxin 2017/02/08
     */
    public function _initialize() {
        parent::_initialize();
        $this->dept_model = M('BigDepartment');
        $this->disease_model = M('Disease');

    }
    
    // 前台用户首页 (公开)
	public function index() {
        //科室疾病关联
        $list = $this->dept_model
                     ->limit(10)
                     ->field('bdept_id,bdept_name')
                     ->select();
        foreach( $list as $k => $v ){
            $disease = $this->disease_model
                            ->where('bdept_id='.$v['bdept_id'])
                            ->field('disease_id,disease_name')
                            ->select();
            $list[$k]['disease'] = $disease;
        }
        $this->assign('dept', $list);
		$this->display(":index");

    }
    
    // 前台ajax 判断用户登录状态接口
    function is_login(){
    	if(sp_is_user_login()){
    		$this->ajaxReturn(array("status"=>1,"user"=>sp_get_current_user()));
    	}else{
    		$this->ajaxReturn(array("status"=>0,"info"=>"此用户未登录！"));
    	}
    }

    //退出
    public function logout(){
    	$ucenter_syn=C("UCENTER_ENABLED");
    	$login_success=false;
    	if($ucenter_syn){
    		include UC_CLIENT_ROOT."client.php";
    		echo uc_user_synlogout();
    	}
    	session("hosuser",null);//只有前台用户退出
        $url = U("Login/index");
    	// redirect(__ROOT__."/");
        redirect($url);
    }

}
