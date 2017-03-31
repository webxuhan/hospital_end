<?php
/**
 * 职位
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class PositionsController extends AdminbaseController {

	protected $position_model;

	public function _initialize() {
        parent::_initialize();
        $this->position_model = D("Common/Position");
    }

	public function index(){
		/*搜索条件*/
		$param = I('param.');
		$position_name = trim($param['position_name']);
		$position_price = trim($param['position_price']);
		$position_appointnum = trim($param['position_appointnum']);
		if($position_name != ""){
			$where['position_name'] = get_search_str($position_name);
		}
		if($position_price != ""){
			$where['position_price'] = get_search_str($position_price);
		}
		if($position_appointnum != ""){
			$where['position_appointnum'] = $position_appointnum;
		}
		$count=$this->position_model->count();
		$page = $this->page($count, 10);

		$position = $this->position_model
				->where($where)
				->limit($page->firstRow , $page->listRows)
				->order(array("position_id" => "ASC"))
				->select();
		$this->assign("position", $position);
		$this->assign("page", $page->show('Admin'));
		$this->display();
	}
	/**
     * 添加职位信息
     *
     * @author wuxin
     */
	public function add(){
		$this->display();
	}
	/**
     * 职位添加功能
     *
     * @author wuxin
     */
	public function add_post(){
		if (IS_POST) {
			$where['position_name'] = $_POST['position_name'];
			/*职位名称是否重复*/
			$find = $this->position_model
					->where($where)
					->find();
			if (!$find) {
				if ($this->position_model->create() !== false) {
					if ($this->position_model->add() !== false) {
						$this->success("添加成功", U("Positions/add"));
					} else {
						$this->error("添加失败");
					}
				} else {
	    			$this->error($this->position_model->getError());
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
		if(isset($_GET['position_id'])){
            $id = I("get.position_id",0,'intval');
            $find = M("Doctor")->where('position_id='.$id)->find();
            if($find){
            	$this->error("该职位下存在医生，无法删除");
            }
            if ($this->position_model->where('position_id='.$id)->delete()){
                $this->success("删除成功");
            } else {
                $this->error("删除失败");
            }
        }
        if(isset($_POST['ids'])){
			$ids = I('post.ids/a');
			$find = M("Doctor")->where(array('position_id'=>array('in',$ids)))->find();
            if($find){
            	$this->error("有职位下存在医生，无法删除");
            }
			if ($this->position_model->where(array('position_id'=>array('in',$ids)))->delete()){
				$this->success("删除成功");
			} else {
				$this->error("删除失败");
			}
		}
	}
	/**
     * 编辑职位信息
     *
     * @author wuxin
     */
	public function edit(){
		$position_id = I("get.position_id",0,'intval');
		$position_info = $this->position_model->where(array("position_id" => $position_id))->find();
		$this->assign("position" ,$position_info);
		$this->display();
	}
	/**
     * 修改职位信息
     *
     * @author wuxin
     */
	public function edit_post(){
		if (IS_POST) {
			$where['position_name'] = $_POST['position_name'];
			$where['position_id'] = array("neq",$_POST['position_id']);
			/*科室名称是否重复*/
			$find = $this->position_model
					->where($where)
					->find();
			if (!$find) {
				if($this->position_model->create() !== false){
					if($this->position_model->save() !== false){
						$this->success("保存成功", U("Positions/index"));
					}else{
						$this->error("保存失败");
					}
				} else {
	    			$this->error($this->position_model->getError());
	    		}
			}else{
				$this->error("职位名称重复");
			}
			
		}
	}
}