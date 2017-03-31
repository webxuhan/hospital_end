<?php
namespace Common\Controller;

use Think\Controller;
use Common\Controller\ExcelController;

class ImportExportController extends Controller{

    public function _initialize() {
        parent::_initialize();
    }
    
    public function export_old() {
        $params = func_get_args();
        $params = $params[0];
        // TODO
        $excel = new ExcelController();

        $xlsName  = "queue test";
        $xlsCell  = array(
            array('id','任务ID'),
            array('name','任务名称'),
            array('params','参数'),
            array('status','状态'),
            array('create_time','创建时间'),
            array('update_time','更新时间'),
        );
        $xlsModel = M('Queue');
        $xlsData  = $xlsModel->select();
        $fileName = 'queue' . $params['task_id'];
        $res = $excel->exportExcel($fileName, $xlsName, $xlsCell, $xlsData);
        if($res && $params['task_id']) {
            M('Queue')->where(array('id' => $params['task_id']))->save(array('file_url' => $res));
        }
        return true;
    }

    public function export() {
        $params = func_get_args();
        $params = $params[0];
        // TODO
        $excel = new ExcelController();
        $xlsName  =  $params['controller'];
        /*$xlsCell  = array(
            array('zn_name','中文名'),
            array('en_name','英文名'),
            array('mobile','手机号'),
            array('email','邮箱'),
            array('receiving_demand','需求'),
            array('building','楼'),
            array('floor_no','栋'),
            array('area_no','区号'),
            array('seat_no','座位号'),
            array('turnover_status','收件需求'),
            array('create_time','创建时间'),
            array('update_time','更新时间'),
            
        );*/
        $xlsCell  = C($xlsName);
        //$xlsCell  = array('label');
        $xlsData  = M($xlsName)->limit(20000)->select();
        $fileName = $xlsName. $params['task_id'];
        $res = $excel->exportExcel($fileName, $xlsName, $xlsCell, $xlsData);
        if($res && $params) {
            M('Queue')->where(array('id' => $params['task_id']))->save(array('file_url' => $res));
        }
        return true;
        //return $res;
        
    }

    public function download($task_id){
        $queueInfo = M('Queue')->where(array('id' => $task_id))->find();
        $fileInfo = array(
            'file_name' => $queueInfo['name'],
            'file_size' => filesize($queueInfo['file_url']),
        );
        /*$fileInfo = array(
            'file_name' => 'haha',
            'file_size' => filesize($haha),
        );*/
        download($queueInfo['file_url'], $fileInfo);
        //download($haha, $fileInfo);
    }

    public function import($params) {
        /*$params = func_get_args();
        $params = $params[0];*/
        // TODO
        $params = unserialize($params);
        $_FILES = $params['files'];
        if(!empty($_FILES)){
            $file = $_FILES;
            $excel = new ExcelController();

            $res = $excel->importExecl();
            //print_r($res);
            foreach($res['data'] as $value){
                for($i=3;$i<=$value['Rows'];$i++){
                    for($j=0;$j<$value['Cols'];$j++){
                        $data[$value['Content'][2][$j]] = $value['Content'][$i][$j];
                        
                    }
                    if(M('staff')->add($data)){
                        print_r('haha');
                        echo "<hr/>";
                    }
                }
            }
        }else{
            $this->error("请选择上传的文件");
        } 
    }
    public function import_export(){
        if(IS_POST){
            $queue_type = I('post.queue_type',1,intval);
            $action = I('post.action');
            $controller = CONTROLLER_NAME;
            $model = MODULE_NAME;
            $task_name = CONTROLLER_NAME.' '.$action;
            if($_FILES){
                $params['files'] = $_FILES;
            }else{

            }
            $task_id = add_tasks($controller,$model,$action,$params,$task_name,$queue_type);
            if($task_id){
                if($queue_type == 1){
                    /*$haha['controller'] = CONTROLLER_NAME;
                    $haha['task_id'] = $task_id;
                    if($this->export($haha)){
                        //print_r($hei);
                        $this->download($task_id);
                    }*/
                    $this->ajaxReturn($queue_type);
                }else{
                    //print_r('haha');
                    $this->import();
                }
            }
        }
        //print_r($_FILES);
    }
    public function import_index(){
        $this->display('ImportExport/import');
    }

}