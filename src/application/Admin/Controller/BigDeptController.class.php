<?php
/**
 * 科室档案
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class BigDeptController extends AdminbaseController {

	protected $bdept_model;

	public function _initialize() {
        parent::_initialize();
        $this->bdept_model = D("Common/BigDepartment");
    }

	public function index(){
		/*搜索条件*/
		$param = I('param.');
		$bdept_name = trim($param['bdept_name']);
		$bdept_contactor = trim($param['bdept_contactor']);
		$bdept_number = trim($param['bdept_number']);
		if($bdept_number != ""){
			$where['bdept_number'] = get_search_str($bdept_number);
		}
		if($bdept_name != ""){
			$where['bdept_name'] = get_search_str($bdept_name);
		}
		if($bdept_contactor != ""){
			$where['bdept_contactor'] = get_search_str($bdept_contactor);
		}
		$count=$this->bdept_model->count();
		$page = $this->page($count, 10);

		$bdept = $this->bdept_model
				->where($where)
				->limit($page->firstRow , $page->listRows)
				->order(array("bdept_id" => "ASC"))
				->select();
		$this->assign("bdept", $bdept);
		$this->assign("page", $page->show('Admin'));
		$this->display();
	}
	/**
     * 添加科室信息
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
			$_POST['bdept_name'] = trim($_POST['bdept_name']);
			$_POST['bdept_contactor'] = trim($_POST['bdept_contactor']);

			$where['bdept_name'] = $_POST['bdept_name'];
			$where['bdept_number'] = $_POST['bdept_number'];
			$where['_logic'] = 'OR';
			/*科室名称是否重复*/
			$count = $this->bdept_model
					->where($where)
					->count();
			if ($count == 0) {
				if ($this->bdept_model->create() !== false) {
					if ($this->bdept_model->add() !== false) {
						$this->success("添加成功", U("BigDept/add"));
					} else {
						$this->error("添加失败");
					}
				} else {
	    			$this->error($this->bdept_model->getError());
	    		}
			} else {
				$this->error("科室名称或科室编号重复");
			}
			
		}
	}
	/**
     * 删除信息
     *
     * @author wuxin
     */
	public function delete(){
		if(isset($_GET['bdept_id'])){
            $id = I("get.bdept_id",0,'intval');
            $find = M("Disease")->where('bdept_id='.$id)->find();
            if($find){
            	$this->error("该科室下存在疾病科，无法删除");
            }
            if ($this->bdept_model->where('bdept_id='.$id)->delete()){
                $this->success("删除成功");
            } else {
                $this->error("删除失败");
            }
        }
        if(isset($_POST['ids'])){
			$ids = I('post.ids/a');
			$find = M("Disease")->where(array('bdept_id'=>array('in',$ids)))->find();
            if($find){
            	$this->error("有科室下存在疾病科，无法删除");
            }
			if ($this->bdept_model->where(array('bdept_id'=>array('in',$ids)))->delete()){
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
		$bdept_id = I("get.bdept_id",0,'intval');
		$bdept_info = $this->bdept_model->where(array("bdept_id" => $bdept_id))->find();
		$this->assign("bdept" ,$bdept_info);
		$this->display();
	}
	/**
     * 修改大科室信息
     *
     * @author wuxin
     */
	public function edit_post(){
		if (IS_POST) {
			$_POST['bdept_name'] = trim($_POST['bdept_name']);
			$_POST['bdept_contactor'] = trim($_POST['bdept_contactor']);

			$where['bdept_name'] = $_POST['bdept_name'];
			$where['bdept_id'] = array("neq",$_POST['bdept_id']);
			/*科室名称是否重复*/
			$count = $this->bdept_model
					->where($where)
					->count();
			if ($count == 0) {
				if($this->bdept_model->create() !== false){
					if($this->bdept_model->save() !== false){
						$this->success("保存成功", U("BigDept/index"));
					}else{
						$this->error("保存失败");
					}
				} else {
	    			$this->error($this->bdept_model->getError());
	    		}
			}else{
				$this->error("科室名称重复");
			}
			
		}
	}
}