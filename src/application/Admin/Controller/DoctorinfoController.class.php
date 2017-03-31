<?php
/**
 * 医生档案
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class DoctorinfoController extends AdminbaseController {

	protected $bdept_model;
	protected $disease_model;
	protected $doctor_model;
	protected $position_model;

	public function _initialize() {
        parent::_initialize();
        $this->bdept_model = D("Common/BigDepartment");
        $this->disease_model = D("Common/Disease");
        $this->doctor_model = D("Commom/Doctor");
        $this->position_model = D("Commom/Position");
    }

	public function index(){
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
     * 添加医生信息
     *
     * @author wuxin
     */
	public function add(){
		$disease = $this->diseases();
		$position = $this->position();
		$this->assign("position",$position);
		$this->assign("disease",$disease);
		$this->display();
	}
	/**
     * 提交添加的信息
     *
     * @author wuxin
     */
	public function add_post(){
		if (IS_POST) {
			if (empty($_POST['position_id'])) {
				$this->error("医生职位不可为空");
			}
			if (empty($_POST['disease_id'])) {
				$this->error("疾病科所属不可为空");
			}

			$_POST['doctor_name'] = trim($_POST['doctor_name']);
			$_POST['doctor_email'] = trim($_POST['doctor_email']);
			$_POST['doctor_mobile'] = trim($_POST['doctor_mobile']);
			$_POST['doctor_detail'] = trim($_POST['doctor_detail']);
			/*医生是否重复*/
			$data['doctor_email'] = $_POST['doctor_email'];
			$data['doctor_mobile'] = $_POST['doctor_mobile'];
			$data['_logic'] = 'OR';
			$find = $this->doctor_model->where($data)->find();
			if ( $find ) {
				$this->error("手机号或邮箱重复，请重新填写");
				
			} else {
				/*生成医生编号*/
				$bdept = $this->disease_model
								    ->table("__DISEASE__ D")
								    ->join("__BIG_DEPARTMENT__ B ON B.bdept_id = D.bdept_id")
								    ->where(array('D.disease_id' => $_POST['disease_id']))
								    ->field("B.bdept_id,B.bdept_number,B.bdept_name,D.disease_name")
								    ->find();
				$_POST['bdept_id'] = $bdept['bdept_id'];
				$_POST['bdept_name'] = $bdept['bdept_name'];
				$_POST['disease_name'] = $bdept['disease_name'];
				$doc_number = $this->doctor_model
									->where(array('bdept_id' => $bdept['bdept_id']))
									->order("bdept_id DESC")
									->limit(1)
									->getField("doctor_number");
				if(empty($doc_number)){
					$_POST['doctor_number'] = $bdept['bdept_number'].$_POST['disease_id']."-1";
				}else{
					$number = explode("-",$doc_number);
					$num = $number[1] + 1;
					$_POST['doctor_number'] = $number[0]."-".$num;
				}
				if ($this->doctor_model->create() !== false) {
					if ($this->doctor_model->add() !== false) {
						$this->success("添加成功", U("Doctorinfo/add"));
					} else {
						$this->error("添加失败");
					}
				} else {
	    			$this->error($this->doctor_model->getError());
	    		}
			}
			
		}
	}
	/**
     * 编辑医生信息
     *
     * @author wuxin
     */
	public function edit(){
		$doctor_id = I("get.doctor_id",0,'intval');
		$doctor_info = $this->doctor_model->where(array("doctor_id" => $doctor_id))->find();
		$disease = $this->diseases();
		$position = $this->position();
		$this->assign("position",$position);
		$this->assign("disease",$disease);
		$this->assign("doctor" ,$doctor_info);
		$this->display();
	}
	/**
     * 编辑医生信息
     *
     * @author wuxin
     */
	public function edit_post(){
		if (IS_POST) {
			if (empty($_POST['position_id'])) {
				$this->error("医生职位不可为空");
			}
			if (empty($_POST['disease_id'])) {
				$this->error("疾病科所属不可为空");
			}

			$_POST['doctor_name'] = trim($_POST['doctor_name']);
			$_POST['doctor_email'] = trim($_POST['doctor_email']);
			$_POST['doctor_mobile'] = trim($_POST['doctor_mobile']);
			$_POST['doctor_detail'] = trim($_POST['doctor_detail']);
			/*医生是否重复*/
			$data['doctor_email'] = $_POST['doctor_email'];
			$data['doctor_mobile'] = $_POST['doctor_mobile'];
			$data['_logic'] = 'OR';
			$map['_complex'] = $data;
			$map['doctor_id'] = array("neq",$_POST['doctor_id']);
			$find = $this->doctor_model->where($map)->find();
			if ( $find ) {
				$this->error("手机号或邮箱重复，请重新填写");
				
			} else {
				if ($this->doctor_model->create() !== false) {
					if ($this->doctor_model->save() !== false) {
						$this->success("修改成功", U("Doctorinfo/index"));
					} else {
						$this->error("修改失败");
					}
				} else {
	    			$this->error($this->doctor_model->getError());
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
		if(isset($_GET['doctor_id'])){
            $id = I("get.doctor_id",0,'intval');
            $find = M("Order")->where('doctor_id='.$id)->find();
            if($find){
            	$this->error("该医生下存在挂号订单，无法删除");
            }
            if ($this->doctor_model->where('doctor_id='.$id)->delete()){
                $this->success("删除成功");
            } else {
                $this->error("删除失败");
            }
        }
        if(isset($_POST['ids'])){
			$ids = I('post.ids/a');
			$find = M("Order")->where(array('doctor_id'=>array('in',$ids)))->find();
            if($find){
            	$this->error("有医生下存在挂号订单，无法删除");
            }
			if ($this->doctor_model->where(array('doctor_id'=>array('in',$ids)))->delete()){
				$this->success("删除成功");
			} else {
				$this->error("删除失败");
			}
		}
	}
	/**
     * 编辑医生头像
     *
     * @author wuxin
     */
	public function avatar(){
		$id = I("get.doctor_id",0,'intval');
		$doctor_avatar = $this->doctor_model->where('doctor_id='.$id)->getField('doctor_avatar');
		$this->assign("doctor_avatar",$doctor_avatar);
		$this->assign("doctor_id",$id);
		$this->display(); 
	}
	/**
     * 疾病信息
     *
     * @author wuxin
     */
	public function diseases(){
		$disease = $this->disease_model
				 ->field("disease_id,disease_name")
				 ->select();
		return $disease;
	}
	/**
     * 职位信息
     *
     * @author wuxin
     */
	public function position(){
		$position = $this->position_model
				 ->field("position_id,position_name")
				 ->select();
		return $position;
	}
	/**
     * 医生信息
     *
     * @author wuxin
     */
	public function doctors(){
		$doctor = $this->doctor_model
				->table("__DOCTOR__ D")
				->join("__POSITION__ P ON D.position_id = P.position_id")
				->field("D.*,P.position_name")
				->select();
		return $doctor;
	}
	/**
     * 医生图片信息
     *
     * @author wuxin
     */
	public function add_avatar(){
		if(IS_POST){
			// $data['doctor_avatar'] = sp_asset_relative_url($_POST['avatar']);
			$data['doctor_avatar'] = $_POST['avatar'];
			$where['doctor_id'] = $_POST['doctor_id'];
			if ($this->doctor_model->where($where)->save($data) !== false) {
				$this->success("保存成功！", U("Doctorinfo/index"));
			} else {
				$this->error("保存失败！");
			}
		} else {
			$this->error($this->doctor_model->getError());
		}
	}
		
}