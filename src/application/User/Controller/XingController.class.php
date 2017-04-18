<?php
namespace User\Controller;

use Common\Controller\HomebaseController;

class XingController extends HomebaseController {

    protected $dept_model;
    protected $disease_model;
    protected $doctor_model;
    protected $hosuser_model;
    protected $patient_model;
    protected $order_model;

    /**
     * 验证是否开启记录
     * @author wuxin 2017/02/08
     */
    public function _initialize() {
        parent::_initialize();
        $this->dept_model = M('BigDepartment');
        $this->disease_model = M('Disease');
        $this->doctor_model = M('Doctor');
        $this->hosuser_model = M('Hosuser');
        $this->patient_model = D("Common/Patients");
        $this->order_model = D("Common/Order");
        $this->hosuser_id = get_current_userid();
    }
    
    //搜索结果页面
    public function index() {
        //科室疾病关联
        $list = $this->dept_model
                     ->limit(10)
                     ->field('bdept_id,bdept_name')
                     ->select();
        foreach( $list as $k => $v ){
            $disease = $this->disease_model
                            ->where('bdept_id='.$v['bdept_id'])
                            ->field('disease_id,disease_name')
                            ->select();
            $list[$k]['disease'] = $disease;
        }
        $this->assign('dept', $list);
        //挂号查找
        $dept = $this->dept_model->field('bdept_id,bdept_name')->select();
        $this->assign('selectdept', $dept);
        $this -> display(":index");
    }
   /**
    *科室展示
    *
    *@author wuxin
    */
    public function diseaseRegistered(){
        //热门科室
        $dept = $this->dept_model
                     ->limit(10)
                     ->field('bdept_id,bdept_name')
                     ->select();
        //科室疾病关联
        $list = $this->dept_model
                     ->field('bdept_id,bdept_name')
                     ->select();
        foreach( $list as $k => $v ){
            $disease = $this->disease_model
                            ->where('bdept_id='.$v['bdept_id'])
                            ->field('disease_id,disease_name')
                            ->select();
            $list[$k]['disease'] = $disease;
        }

        $this->assign('hot_dept', $dept);
        $this->assign('dept', $list);
        $this->display(":diseaseRegistered");
   }
    /**
    *按医生挂号
    *
    *@author wuxin
    */
    public function doctorRegistered(){
        $param = I("param.");
        if($param['doctor_name'] != ""){
            $where['doctor_name'] = get_search_str(trim($param['doctor_name']));
        }if($param['doctor_number'] != ""){
            $where['doctor_number'] = get_search_str(trim($param['doctor_number']));
        }
        $doctor_page = 10;//每页显示的条数
        $page = I('page');
        if(!empty($page)){
            $current_page = $page;
        }else{
            $current_page = 1;
        }
        $doctor_num = $this->doctor_model->count();
        $total_page = ceil($doctor_num/$doctor_page);
        $doctor = $this->doctor_model
                       ->table('__DOCTOR__ D')
                       ->join("__POSITION__ P ON P.position_id = D.position_id")
                       ->where($where)
                       ->limit($doctor_page*($current_page - 1) , $doctor_page)
                       ->field('D.*,P.position_name,P.position_price')
                       ->select();
        $this->assign("doctor", $doctor);
        $this->assign("total_page", $total_page);
        $this->assign("current_page", $current_page);
        $this->display(":doctorRegistered");
   }
   /**
    *挂号预约
    *
    *@author wuxin
    */
    public function doctorRegistration(){
        if(!sp_is_user_login()){ //已经登录时直接跳到首页
            $this->display(":login");
        }
        $doctor_id = I('doctor_id');
        $list = $this->doctor_model->where('doctor_id='.$doctor_id)->find();
        $this->assign("doctor", $list);
        $cal = calendar();
        $patient = $this->patient_model->where('user_id='.$this->hosuser_id)->select();
        $this->assign("cal", $cal);
        $this->assign("patients", $patient);
        $this->display(":doctorRegistration");
    }
   /**
    *医生出诊表
    *
    *@author wuxin
    */
    public function visitTheTable(){
        $doclist_page = 2;//每页显示的条数
        $page = I('page');
        if(!empty($page)){
            $current_page = $page;
        }else{
            $current_page = 1;
        }
        //科室疾病关联
        $dept_num = $this->dept_model->count();
        $total_page = ceil($dept_num/$doclist_page);
        $list = $this->dept_model
                     ->limit($doclist_page*($current_page - 1) , $doclist_page)
                     ->field('bdept_id,bdept_name')
                     ->select();
        foreach( $list as $k => $v ){
            $doctor = $this->doctor_model
                           ->table("__DOCTOR__ D")
                           ->join("__DOCTIME__ T ON D.doctor_id = T.doctor_id")
                           ->where('bdept_id='.$v['bdept_id'])
                           ->field('D.doctor_id,D.doctor_name,D.doctor_number,T.time_id')
                           ->select();
            $count = count($doctor);
            $list[$k]['doctor'] = $doctor;
            $list[$k]['docnum'] = $count;
        }
        $this->assign("total_page", $total_page);
        $this->assign("current_page", $current_page);
        $this->assign("doctor", $list);
        $this->display(":visitTheTable");
   }
   /**
    *个人信息
    *
    *@author wuxin
    */
    public function personalCenter(){
        $hosuser_id = get_current_userid();
        $list = $this->hosuser_model->where("hosuser_id=".$hosuser_id)->find();
        $this->assign("hosuser", $list);
        $this->display(":personalCenter");
   }
   /**
    *查看疾病
    *
    *@author wuxin
    */
    public function disease_gh(){
        $disease_id = I('disease_id');
        $doctor_page = 2;//每页显示的条数
        $page = I('page');
        if(!empty($page)){
            $current_page = $page;
        }else{
            $current_page = 1;
        }
        $list = $this->disease_model->where('disease_id='.$disease_id)->find();//疾病内容
        $doctor_num = $this->doctor_model->where('disease_id='.$disease_id)->count();
        $total_page = ceil($doctor_num/$doctor_page);
        $doctor = $this->doctor_model
                       ->table('__DOCTOR__ D')
                       ->join("__POSITION__ P ON P.position_id = D.position_id")
                       ->where('D.disease_id='.$disease_id)
                       ->limit($doctor_page*($current_page - 1) , $doctor_page)
                       ->field('D.*,P.position_name,P.position_price')
                       ->select();
        $this->assign("doctor", $doctor);
        $this->assign("disease", $list);
        $this->assign("total_page", $total_page);
        $this->assign("current_page", $current_page);
        $this->display(":disease_gh");
   }

   /*科室后的疾病科*/
   public function selectdisease(){
        $bdept_id = I('bdept_id');
        $list = $this->disease_model->where('bdept_id='.$bdept_id)->field('disease_id,disease_name')->select();
        echo json_encode($list);
   }
   /*疾病后的医生*/
   public function selectdoctor(){
        $disease_id = I('disease_id');
        $list = $this->doctor_model->where('disease_id='.$disease_id)->field('doctor_id,doctor_name')->select();
        echo json_encode($list);
   }
    /**
    *查看疾病
    *
    *@author wuxin
    */
    public function patientInfo(){
        $patients = $this->patient_model
                         ->where('user_id='.$this->hosuser_id) 
                         ->select();
        $this->assign("patients", $patients);
        $this->display(":patientInfo");
    }
    public function safety(){
        $this->display(":safety");
    }
    /**
    *挂号记录
    *
    *@author wuxin
    */
    public function gh_logCenter(){
        expire();//判断是否逾期未就诊
        $treat_page = 2;
        $page = I('page');
        if(!empty($page)){
            $current_page = $page;
        }else{
            $current_page = 1;
        }
        /*搜索条件*/
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
        if(!empty($_POST['appoint_time'])){
            $where['O.appoint_time'] = strtotime($_POST['appoint_time']);
        }
        $where['O.status'] = 0;
        $where['O.hosuser_id'] = $this->hosuser_id;

        $order = $this->order_model
                ->table("__ORDER__ O")
                ->join("__DOCTOR__ D ON O.doctor_id = D.doctor_id")
                ->join("__POSITION__ P ON P.position_id = D.position_id")
                ->where($where)
                ->limit($treat_page*($current_page - 1) , $treat_page)
                ->order(array("O.order_id" => "ASC"))
                ->field("O.*,P.*")
                ->select();
        $count=$this->order_model
                ->table("__ORDER__ O")
                ->join("__DOCTOR__ D ON O.doctor_id = D.doctor_id")
                ->join("__POSITION__ P ON P.position_id = D.position_id")
                ->where($where)
                ->count();
        $total_page = ceil($count/$treat_page);
        $doctime =M("Time")->getField('time_id,time_name');
        $this->assign("doctime", $doctime);
        $this->assign("order", $order);
        $this->assign("total_page", $total_page);
        $this->assign("current_page", $current_page);
        $this->display(":gh_logCenter");
    }
    // public function gh_log2(){
    //     $this->display(":gh_log2");
    // }
    // public function gh_log3(){
    //     $this->display(":gh_log3");
    // }
    // public function gh_log4(){
    //     $this->display(":gh_log4");
    // }
    // public function gh_log5(){
    //     $this->display(":gh_log5");
    // }
    /**
    *编辑个人信息
    *
    *@author wuxin
    */
    public function personedit(){
        if($this->hosuser_model->create($_POST) !== false){
            if($this->hosuser_model->save() !== false){
                $this->success("编辑成功");
            }else{
                $this->error("编辑失败");
            }
        } else {
            $this->error($this->hosuser_model->getError());
        }
    }
    /**
    *密码修改
    *
    *@author wuxin
    */
    public function passwordedit(){
        $old_password=I('param.old_password');
        if(empty($old_password)){
            $this->error(L('原始密码不能为空'));
        }
        
        $password=I('param.hosuser_password');
        if(empty($password)){
            $this->error(L('新密码不能为空'));
        }
    
        $admin=$this->hosuser_model->where(array('hosuser_id'=>$this->hosuser_id))->find();
        if(sp_compare_password($old_password, $admin['hosuser_password'])){
            if($password==I('param.repassword')){
                if(sp_compare_password($password, $admin['hosuser_password'])){
                    $this->error(L('新密码与原始密码输入相同'));
                }else{
                    $data['hosuser_password']=sp_password($password);
                    $data['hosuser_id']=$this->hosuser_id;
                    $r=$this->hosuser_model->save($data);
                    if ($r!==false) {
                        $this->success(L('修改成功'));
                    } else {
                        $this->error(L('修改失败'));
                    }
                }
            }else{
                $this->error(L('确认密码错误'));
            }
    
        }else{
            $this->error(L('原始密码错误'));
        }
    }
}
