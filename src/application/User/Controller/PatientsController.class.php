<?php
namespace User\Controller;

use Common\Controller\HomebaseController;

class PatientsController extends HomebaseController {

	protected $patient_model;

	public function _initialize() {
        parent::_initialize();
        $this->patient_model = D("Common/Patients");
    }
	/**
     * 提交添加的信息
     *
     * @author wuxin
     */
	public function add_post(){
		if (IS_POST) {
			$_POST['patient_name'] = trim($_POST['patient_name']);
			$_POST['user_id'] = get_current_userid();
			$find = $this->patient_model->where($_POST)->find();
			if(!$find){
				$count = $this->patient_model->where('user_id='.get_current_userid())->count();
				if($count >= 10){
					$this->error("病人数量达到上限");
				}else{
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

		$patient_id = I("post.patient_id",0,'intval');

		$patient_info = $this->patient_model->where(array("patient_id" => $patient_id))->find();
		echo json_encode($patient_info);
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