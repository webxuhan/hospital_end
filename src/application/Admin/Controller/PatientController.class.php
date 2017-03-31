<?php
/**
 * 病人档案
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class PatientController extends AdminbaseController {

	protected $patient_model;

	public function _initialize() {
        parent::_initialize();
        $this->patient_model = D("Common/Patients");
    }

	public function index(){
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
		if($param['manage'] == 1){
			$where['admin_id'] = null;
		}elseif($$param['manage'] == 2){
			$where['user_id'] = 0;
		}
		$count=$this->patient_model->count();
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
     * 添加病人信息
     *
     * @author wuxin
     */
	public function add(){
		$this->display();
	}
	/**
     * 提交添加的信息
     *
     * @author wuxin
     */
	public function add_post(){
		if (IS_POST) {
			$_POST['patient_name'] = trim($_POST['patient_name']);
			$_POST['admin_id'] = sp_get_current_admin_id();
			$find = $this->patient_model->where($_POST)->find();
			if(!$find){
				if ($this->patient_model->create() !== false) {
					if ($this->patient_model->add() !== false) {
						$this->success("保存成功", U("Patient/add"));
					} else {
						$this->error("保存失败");
					}
				} else {
	    			$this->error($this->patient_model->getError());
	    		}
			}
		}
	}
	/**
     * 删除信息
     *
     * @author wuxin
     */
	public function delete(){
		if(isset($_GET['patient_id'])){
            $id = I("get.patient_id",0,'intval');
            $find = M("Order")->where('patient_id='.$id)->find();
            if($find){
            	$this->error("该病人下存在挂号订单，无法删除");
            }
            if ($this->patient_model->where('patient_id='.$id)->delete()){
                $this->success("删除成功");
            } else {
                $this->error("删除失败");
            }
        }
        if(isset($_POST['ids'])){
			$ids = I('post.ids/a');
			$find = M("Order")->where(array('patient_id'=>array('in',$ids)))->find();
            if($find){
            	$this->error("有病人下存在挂号订单，无法删除");
            }
			if ($this->patient_model->where(array('patient_id'=>array('in',$ids)))->delete()){
				$this->success("删除成功");
			} else {
				$this->error("删除失败");
			}
		}
	}
	/**
     * 编辑病人信息
     *
     * @author wuxin
     */
	public function edit(){
		$patient_id = I("get.patient_id",0,'intval');
		$patient_info = $this->patient_model->where(array("patient_id" => $patient_id))->find();
		$this->assign("patient" ,$patient_info);
		$this->display();
	}
	/**
     * 提交编辑的信息
     *
     * @author wuxin
     */
	public function edit_post(){
		if (IS_POST) {
			$map['patient_mobile'] = $_POST['patient_mobile'];
			$map['patient_id'] = array('neq', $_POST['patient_id']);
			$find = $this->patient_model->where($map)->find();
			if ( $find ) {
				$this->error("改手机号已被使用，请重新填写");
			}else{

				if ($this->patient_model->create() !== false) {
					if ($this->patient_model->save() !== false) {
						$this->success("保存成功", U("Patient/index"));
					} else {
						$this->error("保存失败");
					}
				}
			}
		}
	}

}