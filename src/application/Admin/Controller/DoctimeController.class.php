<?php
/**
 * 医生档案
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class DoctimeController extends AdminbaseController {

	protected $doctor_model;
	protected $time_model;
	protected $doctime_model;

	public function _initialize() {
        parent::_initialize();
        $this->doctor_model = D("Commom/Doctor");
        $this->time_model = D("Commom/Time");
        $this->doctime_model = D("Commom/Doctime");
    }

	public function index(){
		/*搜索条件*/
		$doctime = $this->time_model->select();
		$param = I('param.');
		$doctor_number = trim($param['doctor_number']);
		$doctor_name = trim($param['doctor_name']);
		
		if($doctor_number != ""){
			$where['doctor_number'] = get_search_str($doctor_number);
		}
		if($doctor_name != ""){
			$where['doctor_name'] = get_search_str($doctor_name);
		}
		if($param['time_id'] != ""){
			$where['time_id'][] = array("like","%,".$param['time_id'].",%");
			$where['time_id'][] = array("like",$param['time_id'].",%");
			$where['time_id'][] = array("like","%,".$param['time_id']);
			$where['time_id'][] = "or";
		}
		$count=$this->doctime_model->count();
		$page = $this->page($count, 10);
		$worktime = $this->doctime_model
				->where($where)
				->limit($page->firstRow , $page->listRows)
				->select();
		foreach($worktime as $k => &$v){
			$work = $v['time_id'];
			$w = M("Time")
			->where("time_id in ({$work})")
			->field("group_concat(time_name order by find_in_set(time_id, '{$work}') separator ' | ') as work_time")
			->find();
			$v['time_id'] = $w['work_time'];
		}

		$this->assign("doctime",$doctime);
		$this->assign("worktime",$worktime);
		$this->assign("page", $page->show('Admin'));
		$this->display();
	}
	/**
     * 添加医生信息
     *
     * @author wuxin
     */
	public function add(){
		$doctime = $this->time_model->select();
		$this->assign("doctime",$doctime);
		$this->display();
	}
	/**
     * 提交添加的信息
     *
     * @author wuxin
     */
	public function add_post(){
		if(empty($_POST['doctor_number'])){
			$this->error("请选择医生");
		}
		$time_num = count($_POST['time_id']);
		if($time_num < 6 || $time_num > 8){
			$this->error("请选择3到4个工作日");
		}
		$doctime = $this->doctime_model->where(array('doctor_id' => trim($_POST['doctor_id'])))->getField("time_id");
		if(!empty($doctime)){
			$this->error("该医生已存在工作日");
		}else{
			$_POST['time_id'] = implode(",",$_POST['time_id']);
			if ($this->doctime_model->create() !== false) {
				if ($this->doctime_model->add() !== false) {
					$this->success("添加成功", U("Doctime/add"));
				} else {
					$this->error("添加失败");
				}
			} else {
    			$this->error($this->doctime_model->getError());
    		}
		}
		
		
	}
	/**
     * 编辑医生工作时间信息
     *
     * @author wuxin
     */
	public function edit(){
		$work_id = I("get.work_id",0,'intval');
		/*工作日*/
		$doctime = $this->time_model->select();
		$doctor_worktime = $this->doctime_model->where(array('work_id' => $work_id))->find();
		$doctor_worktime['time_id'] = explode(",",$doctor_worktime['time_id']);
		$this->assign("dwtime",$doctor_worktime);
		$this->assign("doctime",$doctime);
		$this->display();
		
	}
	/**
     * 保存医生工作时间信息
     *
     * @author wuxin
     */
	public function edit_post(){
		$time_num = count($_POST['time_id']);
		if($time_num < 6 || $time_num > 8){
			$this->error("请选择3到4个工作日");
		}
		$_POST['time_id'] = implode(",",$_POST['time_id']);
		if ($this->doctime_model->create() !== false) {
			if ($this->doctime_model->save() !== false) {
				$this->success("保存成功", U("Doctime/index"));
			} else {
				$this->error("保存失败");
			}
		} else {
			$this->error($this->doctime_model->getError());
		}
		
	}
	/**
     * 前台ajax获取医生信息
     *
     * @author wuxin
     */
	public function doctorinfo(){
		$where['doctor_number'] = I("param.doctor_number");
		$find = $this->doctor_model->where($where)->find();
		if($find){
			$doctor = $this->doctor_model->where($where)->field('doctor_name,doctor_id')->select();
			$this->success($doctor[0]['doctor_name'],U(""),array('doctor_id'=>$doctor[0]['doctor_id']));
		}else{
			$this->error("不存在该医生");
		}
		
	}
	/**
     * 删除信息
     *
     * @author wuxin
     */
	public function delete(){
		if(isset($_GET['work_id'])){
            $id = I("get.work_id",0,'intval');
            if ($this->doctime_model->where('work_id='.$id)->delete()){
                $this->success("删除成功");
            } else {
                $this->error("删除失败");
            }
        }
        if(isset($_POST['ids'])){
			$ids = I('post.ids/a');
			if ($this->doctime_model->where(array('work_id'=>array('in',$ids)))->delete()){
				$this->success("删除成功");
			} else {
				$this->error("删除失败");
			}
		}
	}
}