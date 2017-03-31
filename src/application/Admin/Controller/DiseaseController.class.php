<?php
/**
 * 疾病分类
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class DiseaseController extends AdminbaseController {

	protected $bdept_model;
	protected $disease_model;

	public function _initialize() {
        parent::_initialize();
        $this->bdept_model = D("Common/BigDepartment");
        $this->disease_model = D("Common/Disease");
    }

	public function index(){
		/*搜索条件*/
		$param = I('param.');
		$disease_name = trim($param['disease_name']);
		$disease_contactor = trim($param['disease_contactor']);
		$bdept_name = trim($param['bdept_name']);
		if($disease_name != ""){
			$where['disease_name'] = get_search_str($disease_name);
		}
		if($disease_contactor != ""){
			$where['disease_contactor'] = get_search_str($disease_contactor);
		}
		if($bdept_name != ""){
			$where['bdept_name'] = get_search_str($bdept_name);
		}
		$count=$this->disease_model->count();
		$page = $this->page($count, 10);

		$disease = $this->disease_model
				->where($where)
				->limit($page->firstRow , $page->listRows)
				->order(array("bdept_id" => "ASC"))
				->select();
		$this->assign("disease", $disease);
		$this->assign("page", $page->show('Admin'));

		$this->display();
	}
	/**
     * 添加科室信息
     *
     * @author wuxin
     */
	public function add(){
		$dept = $this->departments();
		$this->assign("dept", $dept);
		$this->display();
	}
	/**
     * 提交添加的信息
     *
     * @author wuxin
     */
	public function add_post(){
		if (IS_POST) {
			$_POST['disease_name'] = trim($_POST['disease_name']);
			$_POST['disease_contactor'] = trim($_POST['disease_contactor']);
			if ($_POST['bdept_id'] == "") {
				$this->error("请选择科室");
			} else {
				$bdept_name = $this->bdept_model
							->where(array("bdept_id" => $_POST['bdept_id']))
							->getField("bdept_name");
				$_POST['bdept_name'] = $bdept_name;
			}
			/*疾病名称是否重复*/
			$count = $this->disease_model
					->where(array("disease_name" => $_POST['disease_name']))
					->count();
			if ($count == 0) {
				if ($this->disease_model->create() !== false) {
					if ($this->disease_model->add() !== false) {
						$this->success("添加成功", U("Disease/add"));
					} else {
						$this->error("添加失败");
					}
				} else {
	    			$this->error($this->disease_model->getError());
	    		}
			}else{
				$this->error("疾病名称重复");
			}
			
		}
	}
	/**
     * 删除信息
     *
     * @author wuxin
     */
	public function delete(){
		if(isset($_GET['disease_id'])){
            $id = I("get.disease_id",0,'intval');
            $find = M("Doctor")->where('disease_id='.$id)->find();
            if($find){
            	$this->error("该疾病科下存在医生，无法删除");
            }
            if ($this->disease_model->where('disease_id='.$id)->delete()){
                $this->success("删除成功");
            } else {
                $this->error("删除失败");
            }
        }
        if(isset($_POST['ids'])){
			$ids = I('post.ids/a');
			$find = M("Doctor")->where(array('disease_id'=>array('in',$ids)))->find();
            if($find){
            	$this->error("有疾病科下存在医生，无法删除");
            }
			if ($this->disease_model->where(array('disease_id'=>array('in',$ids)))->delete()){
				$this->success("删除成功");
			} else {
				$this->error("删除失败");
			}
		}
	}
	/**
     * 编辑大科室信息
     *
     * @author wuxin
     */
	public function edit(){
		$disease_id = I("get.disease_id",0,'intval');
		$disease_info = $this->disease_model->where(array("disease_id" => $disease_id))->find();
		$dept = $this->departments();
		$this->assign("dept", $dept);
		$this->assign("disease" ,$disease_info);
		$this->display();
	}
	/**
     * 修改大科室信息
     *
     * @author wuxin
     */
	public function edit_post(){
		if (IS_POST) {
			$_POST['disease_name'] = trim($_POST['disease_name']);
			$_POST['disease_contactor'] = trim($_POST['disease_contactor']);
			if ($_POST['bdept_id'] == "") {
				$this->error("请选择科室");
			} else {
				$bdept_name = $this->bdept_model
							->where(array("bdept_id" => $_POST['bdept_id']))
							->getField("bdept_name");
				$_POST['bdept_name'] = $bdept_name;
			}
			/*疾病名称是否重复*/
			$count = $this->disease_model
					->where(array("disease_name" => $_POST['disease_name'], "disease_id" => array("neq",$_POST['disease_id'])))
					->count();
			if ($count == 0) {
				if ($this->disease_model->create() !== false) {
					if ($this->disease_model->save() !== false) {
						$this->success("保存成功", U("Disease/index"));
					} else {
						$this->error("保存失败");
					}
				} else {
	    			$this->error($this->disease_model->getError());
	    		}
			}else{
				$this->error("疾病名称重复");
			}
			
		}
	}
	/**
     * 查询科室信息
     *
     * @author wuxin
     */
	public function departments(){
		$dept = $this->bdept_model
				->field("bdept_id,bdept_name")
				->select();
		return $dept;
	}
}