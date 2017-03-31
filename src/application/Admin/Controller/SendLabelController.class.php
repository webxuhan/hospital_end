<?php
/**
 * Staff(员工管理)
 */
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
use Common\Controller\ExcelController;

class SendLabelController extends AdminbaseController {

    protected $label_model;
    public function _initialize() {
        parent::_initialize();
        $this->label_model = M("SendLabel");
    }
    
    /**
     * 员工信息列表
     *
     * @author luchaonan 2017/02/13
     */
    public function index() {
    	//session('admin_staff_index','staff/index');
        $where = array();
        //未逻辑删除的
        $where['disabled'] = 0;
        
         /**搜索条件**/
        $params = I('param.');
        $batch = trim($params['batch']);
        $operator = trim($params['operator']);
        $start_time = trim($params['start_time']);
        $end_time = trim($params['end_time']);

        if($batch  != ''){
            $where['batch'] = get_search_str($batch);
        }
        if($operator  != ''){
            $where['user_login'] = get_search_str($operator);
        }
        if($start_time){
            $start_time = strtotime($start_time);
            $where['operation_time']=array(
                array('EGT',$start_time)
            );
        }
        if($end_time){
            $end_time = strtotime($end_time);
            if(!$where['operation_time']){
                $where['operation_time']=array();
            }
            array_push($where['operation_time'], array('ELT',$end_time));
        }   

        $count=$this->label_model->where($where)->count();
		$page = $this->page($count, 10);

		$labels = $this->label_model
            ->join('__USERS__ ON __USERS__.id = __SEND_LABEL__.operation_uid')
            ->field('batch,label_id,floor,building,num,operation_time,user_login')
            ->where($where)
            ->limit($page->firstRow , $page->listRows)
            ->order(array("label_id" => "DESC"))
            ->select();
        if($labels){
            foreach($labels as $key=>$val){
                $building = unserialize($val['building']);
                $floor = unserialize($val['floor']);
                $num = unserialize($val['num']);
                for($i=0;$i<count($building);$i++){
                    $Bfloor[] = $building[$i].L('BUIL').$floor[$i].L('FL');
                }
                $labels[$key]['floor'] = implode(",",$Bfloor);
                unset($Bfloor);
                $labels[$key]['num'] = array_sum($num);
            }
        }
        $this->assign("page", $page->show('Admin'));

        $this->assign("labels", $labels);
        $this->display();
    }
     /**
     * 生成标签页
     * @author luchaonan 2017/02/13
     */
    public function add() {
    	$this->display();
    }

    /**
     * 提交生成标签批次
     *
     * @author luchaonan 2017/02/13
     */
    public function add_post() {
        if(IS_POST){
            $params = I("post.");
            if (!empty($params['building'][0])) {
                for ($i=0;$i<count($params['building']);$i++) {
                    $building[$i] = get_building_prefix().$params['building'][$i];
                    $floor[$i] = get_floor_prefix().$params['floor'][$i];
                }
                $data['floor'] = serialize($floor);
                $data['building'] = serialize($building);
                $data['num'] = serialize($params['num']);
                //获取用户id
                $uid = session('ADMIN_ID');
                $data['operation_uid'] = ($uid)?$uid:0;
                $data['operation_time'] = time();
                $data['batch'] = date('YmdHis');
                if ($this->label_model->create($data) !== false) { 
                    if($this->label_model->add($data)){
                       //写入操作日志
                        write_log(L('CREATE').L('LABEL_BATCH').':'.$data['batch']);
                        $this->success(L('ADD_SUCCESS'), U('SendLabel/index')); 
                    }else{
                        $this->error(L('ADD_FAILED'));
                    }
                }else{
                    $this->error($this->label_model->getError());
                }
            }
        }
    }
   
    /**
     * 下载生成单个标签
     *
     * @author luchaonan 2017/02/13
     */
    public function create_label() {
        if(IS_GET){
            $data['id'] = $label_id = I("get.label_id",0,'intval');
            $labels = $this->label_model->where('label_id='.$label_id)->Field("batch,building,floor,num,download_times")->find();
            $batch = substr($labels['batch'],4);
            $building = unserialize($labels['building']);
            $floor = unserialize($labels['floor']);
            $num = unserialize($labels['num']);
            
            $download_times = $labels['download_times'];
            $limit_num = max($num)*($download_times+1);
           
            if ($limit_num <= 999999) {
                for ($i = 0;$i<count($building);$i++) {
                    $Bfloor = $building[$i].$floor[$i];
                    $k = 0;
                    for($j = 0;$j<$num[$i];$j++){
                        $label_random_start = $download_times*$num[$i];
                        $k++;
                        $label_random = $label_random_start + $k;
                        $serial_num = str_pad($label_random, 6, '0', STR_PAD_LEFT);
                        $label[] = $Bfloor.$batch.$serial_num;
                    }
                }
                $data['download_times'] = $download_times+1;
                $this->label_model->where('label_id='.$label_id)->save($data);
            }else{
                $this->error(L('PLEASE').L('CANCEL_LABEL'));
            }
            
            foreach($label as $key=>$value){
                $print_label[$key]['send_label_batch'] = $value;
            }

            $this->create_excel($print_label,$labels['batch'],$download_times);
        }   
       
    }
    /**
    * 作废
    * @author luchaonan 2017/02/13
    */
    public function cancel() {
        $data['id'] = I("post.label_id",0,'intval');
        $data['download_times'] = 0;
        $result = $this->label_model->where('label_id='.$data['id'])->save($data);
        if($result){
           // $this->index();
            $this->ajaxReturn('ha');
        }

    }
     /**
     * 删除批次
     *
     * @author luchaonan 2017/02/13
     */
    public function delete() {
        if(isset($_POST['ids'])){
			$ids = I('post.ids/a');
            $batch = $this->label_model->where(array('label_id'=>array('in',$ids)))->Field('batch')->select();
            foreach($batch as $key=>$value){
                $batch[$key] = $value['batch'];
            }
            $batch = implode(",",$batch);
			if ($this->label_model->where(array('label_id'=>array('in',$ids)))->save(array('disabled'=>1))!==false){
                //写入操作日志
                write_log(L('BATCH').L('DELETE').L('LABEL_BATCH').':'.$batch);
				$this->success(L('DELETE_SUCCESS'));
			} else {
				$this->error(L('DELETE_FAILURE'));
			}
		}

    }

    /**
     * 用生成的寄件标签生成excel并下载
     *
     * @author luchaonan 2017/03/01
     */
    public function create_excel($xlsData,$xlsName,$download_times) {
  
        $excel = new ExcelController();
        $xlsName  =  'SendLabel'.$xlsName;
        $xlsCell  = array('send_label_batch');

        $fileName = $xlsName. $download_times;
        $res = $excel->exportExcel($fileName, $xlsName, $xlsCell, $xlsData);
        if($res) {
            $fileInfo = array(
                'file_name' => $fileName,
                'file_size' => filesize($res),
            );
            download($res, $fileInfo);    
        }
    }

}
