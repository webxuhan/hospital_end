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
    public function disease_gh(){
        $this->display(":disease_gh");
   }
}
