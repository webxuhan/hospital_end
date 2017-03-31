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
		$page = $this->page($count, 20);
		$lists = $hosuser_model
		->where($where)
		->order("hosuser_id DESC")
		->limit($page->firstRow . ',' . $page->listRows)
		->select();
		$this->assign("page", $page->show('Admin'));
		$this->assign('lists', $lists);
		$this->display();
	}
	
}