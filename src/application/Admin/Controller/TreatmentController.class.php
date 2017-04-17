<?php
/**
 * 预约
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class TreatmentController extends AdminbaseController {
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
    /**
     * 未就诊
     *
     * @author wuxin
     */
    public function index(){
    	expire();//判断是否逾期未就诊
    	/*搜索条件*/
		$where = $this->getwhere();
		$where['O.status'] = 1;
		$count = $this->pagenum($where);
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
		/*当天凌晨时间*/
		$y = date("Y");
        $m = date("m");
		$d = date("d");
		$todayTime= mktime(0,0,0,$m,$d,$y);
		$this->assign("todaytime", $todayTime);
		$this->assign("doctime", $doctime);
		$this->assign("order", $order);
		$this->assign("page", $page->show('Admin'));
		$this->display();
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
                $this->success("支付成功");
            } else {
                $this->error("支付失败");
            }
        }
    }
    /**
     * 已就诊
     *
     * @author wuxin
     */
    public function yettreat(){
    	expire();//判断是否逾期未就诊
    	/*搜索条件*/
		$where = $this->getwhere();
		$where['O.status'] = 2;
		$count = $this->pagenum($where);
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
     * 逾期未就诊
     *
     * @author wuxin
     */
    public function notreat(){
    	expire();//判断是否逾期未就诊
    	/*搜索条件*/
		$where = $this->getwhere();
		$where['O.status'] = 4;
		$count = $this->pagenum($where);
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
     * 查询条件
     *
     * @author wuxin
     */
    public function getwhere(){
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
		if($param['appoint_time'] != ""){
			$where['O.appoint_time'] = strtotime($param['appoint_time']);
		}
		return $where;
    }
     /**
     * 取消预约
     *
     * @author wuxin
     */
    public function canceltreat(){
    	expire();//判断是否逾期未就诊
    	/*搜索条件*/
		$where = $this->getwhere();
		$where['O.status'] = 3;
		$count = $this->pagenum($where);
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
     * 打印预览
     *
     * @author wuxin
     */
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
    	$this->display();
    }
    /**
     *总页数
     *
     * @author wuxin
     */
    public function pagenum($where){
    	$pagenum = $this->order_model
				->table("__ORDER__ O")
				->join("__DOCTOR__ D ON O.doctor_id = D.doctor_id")
				->join("__POSITION__ P ON P.position_id = D.position_id")
				->where($where)
				->count();
		return $pagenum;
    }
}