<?php
namespace User\Controller;

use Common\Controller\HomebaseController;

class TreatController extends HomebaseController {

	 protected $hosuser_model;
	 protected $doctime_model;
	 protected $order_model;
	 protected $doctor_model;
	 protected $patient_model;

    /**
     * 验证是否开启记录
     * @author wuxin 2017/02/08
     */
    public function _initialize() {
        parent::_initialize();
        $this->hosuser_model = M('Hosuser');
        $this->doctime_model = M('Doctime'); 
        $this->order_model = D("Common/Order");
        $this->doctor_model = D("Common/Doctor");
        $this->patient_model = D("Common/Patients");
        $this->hosuser_id = get_current_userid();
        
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
		if(empty($_POST['doctime'])){
			$this->error("请选择日期");
		}
		/*病人信息*/
		$patient = $this->patient_model->where('patient_id='.$_POST['patient_id'])->find();
		$_POST['patient_name'] = $patient['patient_name'];
		$_POST['patient_mobile'] = $patient['patient_mobile'];
		$_POST['patient_idcard'] = $patient['patient_idcard'];
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
		$_POST['hosuser_id'] = $this->hosuser_id;
		$map['patient_idcard'] = $_POST['patient_idcard'];
		$map['doctor_id'] = $_POST['doctor_id'];
		$map['appoint_time'] = $_POST['appoint_time'];
		$map['status'] = array('neq', 3);
		$find = $this->order_model->where($map)->find();
		if($find){
			$this->error("该病人当天已挂过号");
		}
		if ($this->order_model->create() !== false) {
			if ($this->order_model->add() !== false) {
				$this->success("添加成功");
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

	//预约量
	public function appoint_number($d){
		$number = $this->doctor_model
				->table("__DOCTOR__ D")
				->join("__POSITION__ P ON P.position_id = D.position_id")
				->where('D.doctor_id='.$d)
				->getField("P.position_appointnum");	
		return $number;
	}
	/**
     * 未就诊
     * @author wuxin
     */
	public function gh_log2(){
		expire();//判断是否逾期未就诊
		$treat_page = 10;
        $page = I('page');
        if(!empty($page)){
            $current_page = $page;
        }else{
            $current_page = 1;
        }
    	/*搜索条件*/
		$where = $this->getwhere();
		$where['O.status'] = 1;
		$where['O.hosuser_id'] = $this->hosuser_id;
		$order = $this->orderlist($where,$treat_page,$current_page);//获得list
		$total_page = $this->totalpage($where,$treat_page);//获得总页数
		$doctime =M("Time")->getField('time_id,time_name');
		/*当天凌晨时间*/
		$y = date("Y");
        $m = date("m");
		$d = date("d");
		$todayTime= mktime(0,0,0,$m,$d,$y);
		$this->assign("todaytime", $todayTime);
		$this->assign("doctime", $doctime);
        $this->assign("total_page", $total_page);
        $this->assign("current_page", $current_page);
		$this->assign("order", $order);
        $this->display(":gh_log2");
    }
    /**
     * 已就诊
     * @author wuxin
     */
    public function gh_log3(){
    	expire();//判断是否逾期未就诊
		$treat_page = 10;
        $page = I('page');
        if(!empty($page)){
            $current_page = $page;
        }else{
            $current_page = 1;
        }
    	/*搜索条件*/
		$where = $this->getwhere();
		$where['O.status'] = 2;
		$where['O.hosuser_id'] = $this->hosuser_id;

		$order = $this->orderlist($where,$treat_page,$current_page);//获得list
		$total_page = $this->totalpage($where,$treat_page);//获得总页数
		$doctime =M("Time")->getField('time_id,time_name');

		$this->assign("doctime", $doctime);
        $this->assign("total_page", $total_page);
        $this->assign("current_page", $current_page);
		$this->assign("order", $order);
        $this->display(":gh_log3");
    }
     /**
     * 逾期未就诊
     * @author wuxin
     */
    public function gh_log4(){
    	expire();//判断是否逾期未就诊
		$treat_page = 10;
        $page = I('page');
        if(!empty($page)){
            $current_page = $page;
        }else{
            $current_page = 1;
        }
    	/*搜索条件*/
		$where = $this->getwhere();
		$where['O.status'] = 4;
		$where['O.hosuser_id'] = $this->hosuser_id;
		$order = $this->orderlist($where,$treat_page,$current_page);//获得list
		$total_page = $this->totalpage($where,$treat_page);//获得总页数
		$doctime =M("Time")->getField('time_id,time_name');

		$this->assign("doctime", $doctime);
        $this->assign("total_page", $total_page);
        $this->assign("current_page", $current_page);
		$this->assign("order", $order);
        $this->display(":gh_log4");
    }
     /**
     * 取消预约
     * @author wuxin
     */
    public function gh_log5(){
    	expire();//判断是否逾期未就诊
		$treat_page = 10;
        $page = I('page');
        if(!empty($page)){
            $current_page = $page;
        }else{
            $current_page = 1;
        }
    	/*搜索条件*/
		$where = $this->getwhere();
		$where['O.status'] = 3;
		$where['O.hosuser_id'] = $this->hosuser_id;
		$order = $this->orderlist($where,$treat_page,$current_page);//获得list
		$total_page = $this->totalpage($where,$treat_page);//获得总页数
		$doctime =M("Time")->getField('time_id,time_name');

		$this->assign("doctime", $doctime);
        $this->assign("total_page", $total_page);
        $this->assign("current_page", $current_page);
		$this->assign("order", $order);
        $this->display(":gh_log5");
    }
   	//获得查询结果列表
    public function orderlist($a,$treat_page,$current_page){
    	$order = $this->order_model
                ->table("__ORDER__ O")
                ->join("__DOCTOR__ D ON O.doctor_id = D.doctor_id")
                ->join("__POSITION__ P ON P.position_id = D.position_id")
                ->where($a)
                ->limit($treat_page*($current_page - 1) , $treat_page)
                ->order(array("O.order_id" => "ASC"))
                ->field("O.*,P.*")
                ->select();
        return $order;
    }
    //获得总页数
    public function totalpage($a,$treat_page){
        $count=$this->order_model
                ->table("__ORDER__ O")
                ->join("__DOCTOR__ D ON O.doctor_id = D.doctor_id")
                ->join("__POSITION__ P ON P.position_id = D.position_id")
                ->where($a)
                ->count();
        $total_page = ceil($count/$treat_page);
        return $total_page;
    }
    /**
     * 查询条件
     *
     * @author wuxin
     */
    public function getwhere(){
    	$param = I('param.');
		$order_number = trim($param['order_number']);
		$patient_name = trim($param['patient_name']);
		$doctor_name = trim($param['doctor_name']);
		if($order_number != ""){
			$where['O.order_number'] = get_search_str($order_number);
		}
		if($patient_name != ""){
			$where['O.patient_name'] = get_search_str($patient_name);
		}
		if($doctor_name != ""){
			$where['O.doctor_name'] = get_search_str($doctor_name);
		}
		if($param['appoint_time'] != ""){
			$where['O.appoint_time'] = strtotime($param['appoint_time']);
		}
		return $where;
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
     * 取消预约
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
	}
	/**
     * 确认已就诊
     *
     * @author wuxin
     */
    public function treatment(){
    	if(isset($_GET['order_id'])){
            $id = I("get.order_id",0,'intval');
            if ($this->order_model->where('order_id='.$id)->save(array('status'=>2))){
            	/*医生预约量+1*/
            	$doctor_id = I("get.doctor_id",0,'intval');
            	$res = $this->doctor_model
        					->where(array('doctor_id' => $doctor_id))
        					->setInc("expire_totalnum");
            	if(!$res){
            		$this->error("更新失败");
            	}
                $this->success("就诊成功");
            } else {
                $this->error("就诊失败");
            }
        }
    }

    public function treatprint(){
        if(isset($_GET['order_id'])){
            $id = I("get.order_id",0,'intval');
            $list = $this->order_model
                         ->table("__ORDER__ O")
                         ->join("__DOCTOR__ D ON O.doctor_id = D.doctor_id")
                         ->join("__POSITION__ P ON P.position_id = D.position_id")
                         ->where('order_id='.$id)
                         ->find();
            $doctime =M("Time")->getField('time_id,time_name');
            $this->assign("doctime", $doctime);
            $this->assign("appoint",$list);
        }
        $this->display(":gh_print");
    }
}