<?php
namespace User\Controller;

use Common\Controller\HomebaseController;

class XingController extends HomebaseController {

    protected $dept_model;
    protected $disease_model;

    /**
     * 验证是否开启记录
     * @author wuxin 2017/02/08
     */
    public function _initialize() {
        parent::_initialize();
        $this->dept_model = M('BigDepartment');
        $this->disease_model = M('Disease');

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
        $this->assign('dept', $list);
        $this->display(":diseaseRegistered");
   }
    public function doctorRegistered(){
        $this->display(":doctorRegistered");
   }
    public function visitTheTable(){
        $this->display(":visitTheTable");
   }
    public function personalCenter(){
        $this->display(":personalCenter");
   }
    public function disease_gh(){
        $this->display(":disease_gh");
   }
}
