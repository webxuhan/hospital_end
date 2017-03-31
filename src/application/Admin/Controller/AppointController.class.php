<?php
/**
 * 科室档案
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class AppointController extends AdminbaseController {

	protected $doctor_model;
	protected $order_model;
	protected $position_model;

	public function _initialize() {
        parent::_initialize();
        $this->doctor_model = D("Commom/Doctor");
        $this->order_model = D("Commom/Order");
        $this->position_model = D("Commom/Position");
    }

	public function index(){
		/*搜索条件*/
		$param = I('param.');
		$doctor_number = trim($param['doctor_number']);
		$doctor_name = trim($param['doctor_name']);
		if($doctor_number != ""){
			$where['doctor_number'] = get_search_str($doctor_number);
		}
		if($doctor_name != ""){
			$where['doctor_name'] = get_search_str($doctor_name);
		}

		$count=$this->doctor_model->count();
		$page = $this->page($count, 10);

		$doctor = $this->doctor_model
					   ->where($where)
					   ->limit($page->firstRow , $page->listRows)
					   ->order(array("doctor_id" => "ASC"))
					   ->select();
		$this->assign("doctor", $doctor);
		$this->assign("page", $page->show('Admin'));
		$this->display();
	}

	public function detail(){
		$param = I('param.');
		if($param['appoint_time'] != ""){
			$appoint_time = strtotime($param['appoint_time']);
			/*当天凌晨时间*/
			$y = date("Y");
	        $m = date("m");
			$d = date("d");
			$todayTime= mktime(0,0,0,$m,$d,$y);
			if($appoint_time > $todayTime){
				$where['appoint_time'] = $appoint_time;
				$where['status'] = 0;
				$where['doctor_id'] = $param['doctor_id'];
				$appoint_num = $this->order_model->where($where)->count();
				$permit_num = $this->position_model
								   ->table("__POSITION__ P")
								   ->join("__DOCTOR__ D ON D.position_id = P.position_id")
								   ->where(array('D.doctor_id' => $param['doctor_id']))
								   ->getField('position_appointnum');
				$surplus_num = $permit_num - $appoint_num;
				
			}else{
				$appoint_num = "";
				$permit_num = "";
			}
			$this->assign("appoint_num", $appoint_num);
			$this->assign("surplus_num", $surplus_num);
		}
		$this->assign("doctor_id",$param['doctor_id']);
		$this->display();
	}
}