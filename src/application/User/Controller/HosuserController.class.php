<?php
/**
 * 参    数：
 * 作    者：lht
 * 功    能：OAth2.0协议下第三方登录数据报表
 * 修改日期：2013-12-13
 */
namespace User\Controller;

use Common\Controller\AdminbaseController;

class HosuserController extends AdminbaseController {

	protected $hosuser_model;

    /**
     * 验证是否开启记录
     * @author wuxin 2017/02/08
     */
    public function _initialize() {
        parent::_initialize();
        $this->hosuser_model = M('Hosuser');
        $this->hosuser_id = get_current_userid();
    }

	// 后台第三方用户列表
	public function index(){
		/*搜索条件*/
		$param = I('param.');
		$hosuser_name = trim($param['hosuser_name']);
		$mobile = trim($param['mobile']);
		$idcard = trim($param['idcard']);
		$email = trim($param['email']);
		if($hosuser_name != ""){
			$where['hosuser_name'] = get_search_str($hosuser_name);
		}
		if($mobile != ""){
			$where['mobile'] = get_search_str($mobile);
		}
		if($idcard != ""){
			$where['idcard'] = get_search_str($idcard);
		}
		if($email != ""){
			$where['email'] = get_search_str($email);
		}

		$hosuser_model=M('Hosuser');
		$count=$hosuser_model->count();
		$page = $this->page($count, 10);
		$lists = $hosuser_model
		->where($where)
		->order("hosuser_id DESC")
		->limit($page->firstRow . ',' . $page->listRows)
		->select();
		$this->assign("page", $page->show('Admin'));
		$this->assign('lists', $lists);
		$this->display();
	}
	/**
    *编辑个人信息
    *
    *@author wuxin
    */
	public function personedit(){
		if($this->hosuser_model->create() !== false){
			if($this->hosuser_model->save() !== false){
				$this->success("编辑成功");
			}else{
				$this->error("编辑失败");
			}
		} else {
			$this->error($this->hosuser_model->getError());
		}
	}
	/**
    *编辑个人信息
    *
    *@author wuxin
    */
	public function passwordedit(){
		$old_password=I('param.old_password');
		if(empty($old_password)){
			$this->error(L('原始密码不能为空'));
		}
		
		$password=I('param.hosuser_password');
		if(empty($password)){
			$this->error(L('新密码不能为空'));
		}
	
		$admin=$this->hosuser_model->where(array('hosuser_id'=>$this->hosuser_id))->find();
		if(sp_compare_password($old_password, $admin['hosuser_password'])){
			if($password==I('param.repassword')){
				if(sp_compare_password($password, $admin['hosuser_password'])){
					$this->error(L('新密码与原始密码输入相同'));
				}else{
					$data['hosuser_password']=sp_password($password);
					$data['hosuser_id']=$this->hosuser_id;
					$r=$this->hosuser_model->save($data);
					if ($r!==false) {
						$this->success(L('修改成功'));
					} else {
						$this->error(L('修改失败'));
					}
				}
			}else{
				$this->error(L('确认密码错误'));
			}
	
		}else{
			$this->error(L('原始密码错误'));
		}
	}
}