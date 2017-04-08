<?php
/**
 * 预约
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class RegistrationController extends AdminbaseController {

	protected $patient_model;
	protected $doctor_model;
	protected $order_model;
	protected $doctime_model;

	public function _initialize() {
        parent::_initialize();
        $this->patient_model = D("Common/Patients");
        $this->doctor_model = D("Common/Doctor");
        $this->order_model = D("Common/Order");
        $this->doctime_model = D("Common/Doctime");
    }

	public function index(){
		expire();//判断是否逾期未就诊
		/*搜索条件*/
		$param = I('param.');
		$order_number = trim($param['order_number']);
		$patient_name = trim($param['patient_name']);
		$doctor_name = trim($param['doctor_name']);
		$disease_name = trim($param['disease_name']);
		$bdept_name = trim($param['bdept_name']);
		if($order_number != ""){
			$where['O.order_number'] = get_search_str($order_number);
		}
		if($patient_name != ""){
			$where['O.patient_name'] = get_search_str($patient_name);
		}
		if($doctor_name != ""){
			$where['O.doctor_name'] = get_search_str($doctor_name);
		}
		if($disease_name != ""){
			$where['O.disease_name'] = get_search_str($disease_name);
		}
		if($bdept_name != ""){
			$where['O.bdept_name'] = get_search_str($bdept_name);
		}
		if(!empty($_POST['appoint_time'])){
			$where['O.appoint_time'] = strtotime($_POST['appoint_time']);
		}
		$where['O.status'] = 0;
		$count=$this->order_model->count();
		$page = $this->page($count, 10);

		$order = $this->order_model
				->table("__ORDER__ O")
				->join("__DOCTOR__ D ON O.doctor_id = D.doctor_id")
				->join("__POSITION__ P ON P.position_id = D.position_id")
				->where($where)
				->limit($page->firstRow , $page->listRows)
				->order(array("O.order_id" => "ASC"))
				->field("O.*,P.*")
				->select();
		$doctime =M("Time")->getField('time_id,time_name');
		$this->assign("doctime", $doctime);
		$this->assign("order", $order);
		$this->assign("page", $page->show('Admin'));
		$this->display();
	}
	/**
     * 添加挂号信息
     *
     * @author wuxin
     */
	public function add(){
		$cal = $this->calendar();
		$this->assign("cal", $cal);
		$this->display();
	}
	/**
     * 选择病人信息
     *
     * @author wuxin
     */
	public function patient(){
		/*搜索条件*/
		$param = I('param.');
		$patient_name = trim($param['patient_name']);
		if($patient_name != ""){
			$where['patient_name'] = get_search_str($patient_name);
		}
		if($param['patient_idcard'] != ""){
			$where['patient_idcard'] = get_search_str($param['patient_idcard']);
		}
		if($param['patient_email'] != ""){
			$where['patient_email'] = get_search_str($param['patient_email']);
		}
		if($param['patient_mobile'] != ""){
			$where['patient_mobile'] = get_search_str($param['patient_mobile']);
		}
		// if($param['manage'] == 2){
		// 	$where['user_id'] = 0;
		// }
		$where['user_id'] = 0;
		$count=$this->patient_model->where($where)->count();
		$page = $this->page($count, 10);

		$patients = $this->patient_model
				->where($where)	
				->limit($page->firstRow , $page->listRows)
				->select();
		$this->assign("patients", $patients);
		$this->assign("page", $page->show('Admin'));
		$this->display();
	}
	/**
     * 选择医生信息
     *
     * @author wuxin
     */
	public function doctor(){
		/*搜索条件*/
		$param = I('param.');
		$doctor_number = trim($param['doctor_number']);
		$doctor_name = trim($param['doctor_name']);
		$bdept_name = trim($param['bdept_name']);
		$disease_name = trim($param['disease_name']);
		$doctor_email = trim($param['doctor_email']);
		$doctor_mobile = trim($param['doctor_mobile']);
		if($doctor_number != ""){
			$where['doctor_number'] = get_search_str($doctor_number);
		}
		if($doctor_name != ""){
			$where['doctor_name'] = get_search_str($doctor_name);
		}
		if($bdept_name != ""){
			$where['bdept_name'] = get_search_str($bdept_name);
		}
		if($disease_name != ""){
			$where['disease_name'] = get_search_str($disease_name);
		}
		if($doctor_email != ""){
			$where['doctor_email'] = get_search_str($doctor_email);
		}
		if($doctor_mobile != ""){
			$where['doctor_mobile'] = get_search_str($doctor_mobile);
		}
		if($_POST['doctor_status'] != ""){
			$where['doctor_status'] = $_POST['doctor_status'];
		}
		$count=$this->doctor_model->count();
		$page = $this->page($count, 10);

		$doctor = $this->doctor_model
				->table("__DOCTOR__ D")
				->join("__POSITION__ P ON D.position_id = P.position_id")
				->where($where)
				->limit($page->firstRow , $page->listRows)
				->order(array("doctor_status" => "ASC",'doctor_id' => 'ASC'))
				->field("D.*,P.position_name")
				->select();
		$this->assign("page", $page->show('Admin'));
		$this->assign("doctor",$doctor);
		$this->display();
	}
	/**
     * 预约功能
     *
     * @author wuxin
     */
	public function add_post(){
		if(empty($_POST['patient_id'])){
			$this->error("请选择病人信息");
		}
		if(empty($_POST['doctor_id'])){
			$this->error("请选择医生信息");
		}
		/*预约时间*/
		$time = time();
		$w = date('w',$time);
		if(2*$w < $_POST['doctime']){
			$appoint = 60*60*24*ceil(($_POST['doctime'] - 2*$w)/2);
		}else{
			$appoint = 60*60*24*(7 - floor((2*$w-$_POST['doctime'])/2));
		}
		/*当天凌晨时间*/
		$y = date("Y");
        $m = date("m");
		$d = date("d");
		$todayTime= mktime(0,0,0,$m,$d,$y);
		$appoint_time = $appoint+$todayTime;
		$order_num = date("ymd",$appoint_time);
		/*序号*/
		$appoint_num = $this->order_model->where(array('appoint_time' => $appoint_time,'doctor_id' => $_POST['doctor_id']))->count();
		$position_appointnum = $this->appoint_number($_POST['doctor_id']);//预约量
		if($appoint_num > $position_appointnum){
			$this->error('挂号量已满');
		}elseif($appoint_num < 9){
			$appoint_num = '0'.($appoint_num+1);
		}else{
			$appoint_num += 1;
		}
		$_POST['order_number'] = $_POST['doctor_id'].$order_num.$appoint_num;
		$_POST['create_time'] = $time;
		$_POST['appoint_time'] = $appoint_time;
		$map['patient_id'] = $_POST['patient_id'];
		$map['doctor_id'] = $_POST['doctor_id'];
		$map['appoint_time'] = $_POST['appoint_time'];
		$map['status'] = array('neq', 3);
		$find = $this->order_model->where($map)->find();
		if($find){
			$this->error("该病人当天已挂过号");
		}
		if ($this->order_model->create() !== false) {
			if ($this->order_model->add() !== false) {
				$this->success("添加成功", U("Registration/add"));
			} else {
				$this->error("添加失败");
			}
		} else {
			$this->error($this->order_model->getError());
		}
	}
	public function doctorcal(){
		$doctor_id = I("param.doctor_id");
		$doctime = $this->doctime_model->where(array('doctor_id' => $doctor_id))->getField('time_id');
		echo $doctime;
	}
	/**
     * 支付信息
     *
     * @author wuxin
     */
	public function payfor(){
		if(isset($_GET['order_id'])){
            $id = I("get.order_id",0,'intval');
            if ($this->order_model->where('order_id='.$id)->save(array('status'=>1))){
            	/*医生预约量+1*/
            	$doctor_id = I("get.doctor_id",0,'intval');
            	$res = $this->doctor_model
            					->where(array('doctor_id' => $doctor_id))
            					->setInc("appoint_totalnum");
            	if(!$res){
            		$this->error("更新失败");
            	}
                $this->success("支付成功");
            } else {
                $this->error("支付失败");
            }
        }
	}
	/**
     * 删除信息
     *
     * @author wuxin
     */
	public function delete(){
		if(isset($_GET['order_id'])){
            $id = I("get.order_id",0,'intval');
            if ($this->order_model->where('order_id='.$id)->save(array('status'=>3))){
                $this->success("取消成功");
            } else {
                $this->error("取消失败");
            }
        }
        if(isset($_POST['ids'])){
			$ids = I('post.ids/a');
			if ($this->order_model->where(array('order_id'=>array('in',$ids)))->save(array('status'=>3))){
				$this->success("取消成功");
			} else {
				$this->error("取消失败");
			}
		}
	}

	/**
     * 预约日期
     * @author wuxin
     */
	public function calendar(){
		/*获得当前日期，展示医生一周的工作时间*/
		$time=time();
		$month=date("m");
		$day=date("d");
		$xinqi=date("l");
		$year=date("Y");
		$days=date("t",$time);
		$arr=array();
		$month1=$month+1;
		for($j=1;$j<8;$j++){
			$m=$day+$j;
			if($m>$days){
				$month=$month1;
				$m-=$days;
			}
			if($month>12){
				$month=1;
			}
			if($m<10){
				$m = "0".$m;
			}
			$cal = $month."-".$m;
			$arr[$cal]=$this->getTimeWeek($time+24*3600,$j-1);
		}
		return $arr;
		/*展示结束*/
	}
	public function getTimeWeek($time,$i){
			// $weekarray = array("日","一", "二", "三", "四", "五", "六");
			$oneD = 24 * 60 * 60;
			// return "周" . $weekarray[date("w", $time + $oneD * $i)];
			$week = date("w", $time + $oneD * $i);
			if($week == 0){
				$week = 7;
			}
			return $week;
	}
	//预约量
	public function appoint_number($d){
		$number = $this->doctor_model
				->table("__DOCTOR__ D")
				->join("__POSITION__ P ON P.position_id = D.position_id")
				->where('D.doctor_id='.$d)
				->getField("P.position_appointnum");	
		return $number;
	}

}