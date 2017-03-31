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

        sp_is_user_login() || header("Location:./index.php?g=user&m=login");

        $this->staff_model = M("staff");
        $this->address_model = M('DeliveryAddress');
        $this->cost_model = M('StaffCostcenters');
        $this->staff_id = $_SESSION['user']['staff_id'];

    }
    
    //搜索结果页面
    public function index() {
        $this -> display(':index');
    }
    
    /**
     * 我的发件  
     * @author heyong 2017/02/21
     */
    public function mySendMail(){
        
        //分页
        $page = I('post.');
        $count = M('send_express_application')->where(array('send_staff_id'=>$this->staff_id))->count();
        $total_page = ceil($count/8);
        if(!empty($page)){
            $current_page = I('post.page');
        }else{
            $current_page = 1;
        }
        
        $list = M('send_express_application')
            ->field('id,express_number,receive_name,regions_area_id,update_time,status')
            ->where(array('send_staff_id'=>$this->staff_id))
            ->limit(($current_page-1)*8,8)
            ->order('id DESC')
            ->select();
        $this->assign("current_page",$current_page);
        $this->assign("total_num",$total_page);
        $this->assign("list",$list);
        $this -> display(':tpl/mySendMail');
    }
    
    /**
     * 我的发件  查看详情
     * @author heyong 2017/02/21
     */
    public function sendDetail(){
        $param = I("param.");
        if(!empty($param)){
        
            $staff_id = $param['id'];
            //dump($staff_id);
            /*内部件*/
            // $company = M('send_express_application')->where(array('id'=>$staff_id))->getField("express_company_id");
            // $package_addrid = M('send_express_application')->where(array('id'=>$staff_id))->getField("package_address_id");
            $express_type = M('send_express_application')->where(array('id'=>$staff_id))->getField("express_type"); 
            if($express_type == "3"){
                $inlist = M('send_express_application')  
                        ->field('express_quantity,express_type,service_type,status,express_quantity,receive_name,receive_phone,send_staff_id,number_type,create_time')
                        ->where(array('id'=>$staff_id))
                        ->select();
                $this->assign('inlist',$inlist[0]);
            }elseif($express_type == "2"){
                /*打包件*/
                $packlist  = M('send_express_application')
                            ->table("cmf_send_express_application R")
                            ->join("__EXPRESS_COMPANY__ E ON R.express_company_id = E.express_id", 'left')
                            ->join("__PACKAGE_ADDRESS__ P ON R.package_address_id = P.address_id", 'left')
                            ->field('P.address_name,package_address_id,receive_address,R.express_type,service_type,status,express_quantity,receive_name,receive_phone,send_staff_id,regions_area_id,number_type,R.create_time')
                            ->where(array('id'=>$staff_id))
                            ->select();
                /*处理地址，改为汉字*/
                foreach ($packlist as $key => &$value) {
                    $path = M('Regions')->where(array('id' => $value['regions_area_id']))->getField('path');
                    $path = substr($path, 1, strlen($path) - 2);
                    $region_name = M('Regions')
                    ->where("id in ({$path})")
                    ->field("group_concat(name order by find_in_set(id, '{$path}') separator '') as region_name")
                    ->find();
                    $value['regions_area_id'] = $region_name['region_name'];
                }
                $this->assign('packlist',$packlist[0]);
            }else{
                /*普通件*/
                $list = M('send_express_application')
                ->table("cmf_send_express_application R")
                ->join("__EXPRESS_COMPANY__ E ON R.express_company_id = E.express_id")
                
                ->field('receive_zip,regions_area_id,receive_address,R.express_type,express_number,service_type,express_company_id,status,express_quantity,receive_name,receive_phone,receive_tel,send_staff_id,weight,expenses,number_type,E.create_time,E.express_name')
                ->where(array('id'=>$staff_id))
                ->select();
                //处理地址，改为汉字
                foreach ($list as $key => &$value) {
                    $path = M('Regions')->where(array('id' => $value['regions_area_id']))->getField('path');
                    $path = substr($path, 1, strlen($path) - 2);
                    $region_name = M('Regions')
                    ->where("id in ({$path})")
                    ->field("group_concat(name order by find_in_set(id, '{$path}') separator '') as region_name")
                    ->find();
                    $value['regions_area_id'] = $region_name['region_name'];
                }
                $this->assign('list',$list[0]);
            }
        }
        $this -> display(':tpl/sendDetail');
    }
    
    
    
    public function personalInformation(){
    	$this -> display(':tpl/personalInformation');
    }
    /**
     * 快件下单  
     * @author wuxin 2017/02/24
     */
    public function placeOrder(){
        $packaddress = getPackageAddress();
        $express_type = I("param.express_type");
        $company = $this->get_expresscompany();
        $daddress = $this->receive_address();
        $staff_costcenters = $this->staff_costcenters();
        $this->assign('scost_center',$staff_costcenters);
        $this->assign('daddress',$daddress);
        $this->assign('address_list',$packaddress);
        $this->assign('express_company',$company);
        // 选择页面
        switch ($express_type){
            case 1:
                $this->display(':tpl/createGeneral'); //普通件
                break;
            case 2:
                $this->display(':tpl/createPack');  //打包件
                break;
            case 3:
                $this->display(':tpl/createInward');  //内部件
        }
    }
    /**
     * 我的收件  
     * @author wuxin 2017/02/21
     */
    public function myReceiptMail(){
         //分页
        $page_limit = 10;
        $page = I('post.');
        $count = M('Receiving')->where(array('staff_id'=>$this->staff_id))->count();
        $total_page = ceil($count/$page_limit);
        if(!empty($page)){
            $current_page = I('post.page');
        }else{

            $current_page = 1;
        }
        $list = M('Receiving')
            ->field('receive_id,job_no,staff_name,update_time,status')
            ->where(array('staff_id'=>$this->staff_id))
            ->limit(($current_page-1)*$page_limit,$page_limit)
            ->order('receive_id DESC')
            ->select();

        $this->assign("current_page",$current_page);
        $this->assign("total_num",$total_page);
        $this->assign("list",$list);
        $this -> display(':tpl/myReceiptMail');
    }
    /**
     * 我的收件  查看详情
     * @author wuxin 2017/02/21
     */
    public function receiveDetail(){
        $param = I("param.");
        if(!empty($param)){

            $receive_id = $param['receive_id'];
            $list = M('Receiving')
            ->table("__RECEIVING__ R")
            ->join("__EXPRESS_COMPANY__ E ON R.express_company_id = E.express_id")
            ->field('R.express_type,job_no,airway_bill_no,R.express_attr,package_num,status,staff_department,staff_name,express_name,staff_mobile,staff_tel,send_name,send_mobile,send_region_id,send_detail_addr,seat_number,sing_time')
            ->where(array('receive_id'=>$receive_id))
            ->select();
            /*处理地址，改为汉字*/
            if($list[0]['send_region_id'] != 0){
                $path = M('Regions')->where(array('id' => $list[0]['send_region_id']))->getField('path');
                $path = substr($path, 1, strlen($path) - 2);
                $region_name = M('Regions')
                ->where("id in ({$path})")
                ->field("group_concat(name order by find_in_set(id, '{$path}') separator '') as region_name")
                ->find();
                $list[0]['send_region_id'] = $region_name['region_name'];
            }else{
                $list[0]['send_region_id'] = "";
            }
        }
        $this->assign('list',$list[0]);
        $this -> display(':tpl/receiveDetail');
    }
    /**
     * 修改个人信息  
     * @author wuxin 2017/02/13 
     */
    public function editCenter(){

        $staff = $this->staff_model
        ->field('zn_name,en_name,sex,email,mobile,extension_no,department_id,seat_detail')
        ->where(array('staff_id'=>$this->staff_id))
        ->select();
        $depts = $this->department();
         
        $this->assign('depts',$depts);
        $this->assign('staff',$staff[0]);
        $this -> display(':tpl/editCenter');
    } 
    /**
     * 编辑图片信息
     * @author wuxin 2017/02/13
     */
    public function avatarCenter(){
        $avatar = $this->staff_model->where(array('staff_id'=>$this->staff_id))->getField('avatar');
        $this->assign('avatar',$avatar);
        $this -> display(':tpl/avatarCenter');
    }
    /**
     * 修改密码
     * @author wuxin 2017/02/13
     */
    public function passwordCenter(){
        $this -> display(':tpl/passwordCenter');
    }
    /**
     * 成本中心
     * @author wuxin 2017/02/13
     */
    public function costCenter(){
        //分页
        $page = I('post.');
        $count = $this->cost_model->count();
        $total_page = floor($count/8)+1;
        if(!empty($page)){
            $first_page = I('post.page');
        }else{
            $first_page = 1;
        }
        //已有的成本中心
        //成本中心表中数据若已删除，则删除员工成本中心的数据
        $del_costs = M('StaffCostcenters')
                    ->table('__STAFF_COSTCENTERS__ S')
                    ->join('__COSTCENTERS__ C ON C.center_id = S.center_id')
                    ->where(array('staff_id'=>$this->staff_id,'C.disabled'=>'1','S.disabled'=>'0'))
                    ->field('S.staffcenter_id,S.staffcenter_default')
                    ->limit(($first_page-1)*8,8)
                    ->select();
        $delstatus = "";
        foreach($del_costs as $v){
            if($v['staffcenter_default'] == "1"){
                //成本中心被强制删除，更换成本中心
                $delstatus = "1";
            }
            $scenter_id[] = $v['staffcenter_id'];
        }
        if(!empty($scenter_id)){
            $bool = M('StaffCostcenters')
                ->where(array('staffcenter_id'=>array('IN',$scenter_id)))
                ->save(array('disabled'=>'1'));
            if(!$bool){
                    $this->error(L("EDIT_FAILED"));
                }
        }
        /*成本中心被删除，更换成本中心*/
        if($delstatus == "1"){
            $sc_num = M('StaffCostcenters')
                ->where(array('staff_id'=>$this->staff_id,'disabled'=>'0'))
                ->count();
            if($sc_num != 0){
                $updatecost = M('StaffCostcenters')
                ->where(array('staff_id'=>$this->staff_id,'disabled'=>'0'))
                ->order("staffcenter_id ASC")
                ->limit(1)
                ->save(array('staffcenter_default'=>'1'));
                if(!$updatecost){
                    $this->error(L("EDIT_FAILED"));
                }
            }
            
        }  
        /*显示内容*/   
        $staff_costs = M('StaffCostcenters')
                ->table('__STAFF_COSTCENTERS__ S')
                ->join('__COSTCENTERS__ C ON C.center_id = S.center_id')
                ->field('C.disabled,center_name,office,city,delivery_no,contacts,mobile,S.*')
                ->where(array('staff_id'=>$this->staff_id,'C.disabled'=>'0','S.disabled'=>'0'))
                ->order("staffcenter_id ASC")
                ->limit(($first_page-1)*8,8)
                ->select();//print_r($staff_costs);
        $costs = $this->costcenters();
        $this->assign('staff_costs',$staff_costs);
        $this->assign('costs',$costs);
        $this->assign('current_page',$first_page);
        $this->assign('total_num',$count);
        $this->assign('total_page',$total_page);
        $this -> display(':tpl/costCenter');
    }
    /**
     * 地址管理
     * @author wuxin 2017/02/13
     */
    public function addressCenter(){
        //分页
        $page = I('post.');
        $count = $this->address_model->where(array('staff_id'=>$this->staff_id))->count();
        $total_page = floor($count/8)+1;
        if(!empty($page)){
            $first_page = I('post.page');
        }else{
            $first_page = 1;
        }
        $list = $this->address_model
                ->where(array('staff_id'=>$this->staff_id))
                ->order("delivery_id ASC")
                ->limit(($first_page-1)*8,8)
                ->select();
        //处理地址，改为汉字
        foreach ($list as $key => &$value) {
            $path = M('Regions')->where(array('id' => $value['delivery_address']))->getField('path');
            $path = substr($path, 1, strlen($path) - 2);
            $region_name = M('Regions')
            ->where("id in ({$path})")
            ->field("group_concat(name order by find_in_set(id, '{$path}') separator '') as region_name")
            ->find();
            $value['delivery_address'] = $region_name['region_name'];
        }
        $this->assign('current_page',$first_page);
        $this->assign('total_num',$count);
        $this->assign('total_page',$total_page);
        $this->assign('addressinfo',$list);
        $this ->display(':tpl/addressCenter');
    }
    /**
     * 添加地址信息
     * @author wuxin 2017/02/13
     */
    public function addressAdd(){
        $this -> display(':tpl/addressAdd');
    }
    /**
     * 添加成本中心信息
     * @author wuxin 2017/02/16
     */
    public function centersAdd(){
        $costs = $this->costcenters();
        $this->assign('costs',$costs);
        $this -> display(':tpl/centersAdd');
    }
    /**
     * 员工基础信息
     * @author wuxin 2017/02/13
     */
     public function center(){

        $prefix = C(DB_PREFIX);
        $sql = "select d.department_name,s.zn_name,s.en_name,s.seat_detail,s.sex,s.avatar,s.mobile,s.email from ".$prefix."staff s,".$prefix."departments d where s.department_id = d.department_id and s.staff_id = ".$this->staff_id;
        $staff = $this->staff_model->query($sql);
        //待收件
        $map['staff_id'] = $this->staff_id;
        $map['status'] = "0";
        $receive_num = M('Receiving')->where($map)->count();
        $list = M('Receiving')
            ->field('receive_id,job_no,staff_name,update_time,status')
            ->where($map)
            ->limit(0,10)
            ->order('receive_id DESC')
            ->select();
        //待发件
        $where['send_staff_id'] = $this->staff_id;
        $where['status'] = "0";
        $send_num = M('SendExpressApplication')->where($where)->count();
        $sendlist = M('SendExpressApplication')
            ->field('id,express_number,receive_name,update_time,status')
            ->where($where)
            ->limit(0,10)
            ->order('id DESC')
            ->select();   
        $this->assign("receive_num",$receive_num);
         $this->assign("send_num",$send_num);
        $this->assign("list",$list);
        $this->assign("sendlist",$sendlist);
        $this->assign('staff',$staff[0]);
        $this -> display(':tpl/center');
    } 

    /**
     * 获取部门信息
     * @return array
     * @author wuxin 2017/02/08
     */
    public function department(){
        $dept_model = M('departments');
        $depts = $dept_model->field('department_name,department_id')->select();
        return $depts;
    }

    /**
     * 编辑个人信息
     * @author wuxin 2017/02/13
     */
    public function editStaff() {
        $params =I('param.');
        foreach($params as $k=>$v){
            $params[$k] = trim($v);
        }
        $params['update_time'] = time();
        $res = $this->staff_model->where(array('staff_id'=>$this->staff_id))->save($params);
        if($res !== false) {
             $this->success('success');
        } else {
            $this->error('error');
        }
    }
    
     /**
     * 获取成本中心信息
     * @return array
     * @author wuxin 2017/02/12
     */
    public function costcenters(){
        $cost_model = M('costcenters');
        $costs = $cost_model->field('center_name,center_id')->where(array('disabled'=>'0'))->select();
        return $costs;
    }
    /**
     * 获取默认收件地址信息
     * @return string
     * @author wuxin 2017/02/12
     */
    public function receive_address(){
        $map['staff_id'] = $this->staff_id;
        $map['delivery_default'] = "1"; 
        $daddress = $this->address_model->where($map)->select();
        return $daddress[0];
    }

    /**
     * 获取个人成本中心信息  
     * @return array
     * @author wuxin 2017/02/24
     */
    public function staff_costcenters(){
        $staffcost_model = M('StaffCostcenters');
        $staffcosts = $staffcost_model
            ->table('__STAFF_COSTCENTERS__ S')
            ->join('__COSTCENTERS__ C ON S.center_id = C.center_id')
            ->field('C.center_name,S.center_id')
            ->where(array('staff_id'=>$this->staff_id,'S.disabled' => '0'))
            ->select();
        return $staffcosts;
    }
    /**
     * 获取快递公司  
     * @return array
     * @author wuxin 2017/03/05
     */
    public function get_expresscompany(){
        $company = M("ExpressCompany")->field("express_id,express_name")->select();
        return $company;
    }
}
