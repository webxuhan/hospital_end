<?php
namespace User\Controller;

use Common\Controller\HomebaseController;

class XingController extends HomebaseController {

    protected $dept_model;
    protected $disease_model;
    protected $doctor_model;

    /**
     * 验证是否开启记录
     * @author wuxin 2017/02/08
     */
    public function _initialize() {
        parent::_initialize();
        $this->dept_model = M('BigDepartment');
        $this->disease_model = M('Disease');
        $this->doctor_model = M('Doctor');
        
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
    public function personalCenter(){
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
}
