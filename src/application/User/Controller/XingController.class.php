<?php
namespace User\Controller;

use Common\Controller\HomebaseController;

class XingController extends HomebaseController {
    /**
     * 验证是否开启记录
     * @author wuxin 2017/02/08
     */
    public function _initialize() {
        parent::_initialize();

        //sp_is_user_login() || header("Location:./index.php?g=user&m=login");

        // $this->staff_model = M("staff");
        // $this->address_model = M('DeliveryAddress');
        // $this->cost_model = M('StaffCostcenters');
        // $this->staff_id = $_SESSION['user']['staff_id'];

    }
    
    //搜索结果页面
    public function index() {
        $this -> display(":index");
    }
   
    public function diseaseRegistered(){
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
