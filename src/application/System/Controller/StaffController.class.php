<?php
/**
 * Staff(员工管理)
 */
  namespace System\Controller;
  
  use Think\Controller;
  use Common\Controller\ExcelController;

class StaffController extends Controller {

    private $staff_model;

    public function _initialize() {
        $this->staff_model = D("Common/Staff");
    }
    /**
     * 导出
     *
     * @author luchaonan 2017/03/03
     */
     public function export() {
        $params = func_get_args();
        $params = $params[0];
        // TODO
        $excel = new ExcelController();
        $xlsName  =  $params['controller'];
        $xlsCell  = $this->get_list_name();
        //$xlsCell  = array('label');
        $xlsData  = M($xlsName)->select();
        foreach($xlsData as $key=>$val){
            if($val['receiving_demand'] == 0){
                $xlsData[$key]['receiving_demand'] = '派送';
            }else{
                $xlsData[$key]['receiving_demand'] = '自取';
            }
            if($val['turnover_status'] == 0){
                $xlsData[$key]['turnover_status'] = '在职';
            }else{
                $xlsData[$key]['turnover_status'] = '离职';
            }
        }
        $fileName = $xlsName. $params['params']['task_id'];
        $res = $excel->exportExcel($fileName, $xlsName, $xlsCell, $xlsData);
        $data['id'] = $params['params']['task_id'];
        if($res && $params) {
            $data['file_url'] = $res;
            $data['status'] = 1;
            //写入操作日志
            write_log(L('DATA_EXPORT')."Staff".L('SUCCESS'));
        }else{
            $data['status'] = 0;
            
            //写入操作日志            
            write_log(L('DATA_EXPORT')."Staff".L('FAILURE').":".L('CREATE_EXCEL_FAILURE'));
            $params['params']['error_reson'] = L('CREATE_EXCEL_FAILURE');
            $data['params'] = serialize($params);
        }
        if(M('Queue')->save($data)){
            return true;
        }
        //return true;
        //return $res;
        
    }

    /**
     * 导入
     *
     * @author luchaonan 2017/03/03
     */
    public function import() {
        header("Content-type: text/html; charset=utf-8");
        $params = func_get_args();
        // TODO
        $params = $params[0];
        $info = $params['params']['info'];
        $excel = new ExcelController();
        $res = $excel->importExecl($info);
        //print_r($res);
        $map['id'] = $params['params']['task_id'];
        //默认状态为成功
        $map['status'] = 1;

        if($error = $res['error']){
            $params['params']['error_reson'] = $error;
            $map['status'] = 0;
        }
    
        $this->staff_model->startTrans();
        if($res['data']){
            foreach($res['data'] as $value){
                for($i=3;$i<=$value['Rows'];$i++){
                    
                    for($j=0;$j<$value['Cols'];$j++){
                        $xlsCell  = $this->get_list_name();
                        $cellName = $value['Content'][2][$j];
                        $cellValue =  trim($value['Content'][$i][$j]); 
                        foreach($xlsCell as $key=>$vals){
                            if($cellName == $vals[0] || $cellName == $vals[1]){
                                $cellName = $vals[0];
                            }
                        }
                        $data[$cellName] = htmlspecialchars($cellValue);
                        array_walk_recursive($data,'think_filter');
                        
                    }
                    //改变收件需求和离职状态
                    if($data['receiving_demand'] == '自取'){
                        $data['receiving_demand'] = 1;
                    }else{
                        $data['receiving_demand'] = 0;
                    }
                    if($data['turnover_status'] == '离职'){
                        $data['turnover_status'] = 1;
                    }else{
                        $data['turnover_status'] = 0;
                    }
                    //检验数据是否重复存在
                    $find = M($params['controller'])->where($data)->find();
        
                    if (!$find) {
                        // print_r($data);
                        //重新建数组并合并的原因是下面的time影响上面的find
                        $data2['create_time'] = time();
                        $data2['update_time'] = time();
                        $data3 = array_merge($data,$data2);
                        if(!(M($params['controller'])->add($data3))){
                            $this->staff_model->rollback();
                            $map['status'] = 0; 
                            $params['params']['error_reson'] = L("THE").$i.L("ROW").L("FORMAT_ERROR");

                            break;
                        }
                    }

                }
            }
        }
        $this->staff_model->commit();
        if($map['status'] == 0){
            $map['params'] = serialize($params);
            //写入操作日志            
            write_log(L('DATA_IMPORT')."Staff".L('FAILURE').":".$params['params']['error_reson']);
        }else{   
            //写入操作日志
            write_log(L('DATA_IMPORT')."Staff".L('SUCCESS'));
        }
        if(M('Queue')->save($map)){
            return true;
        }
    }

    /**
     * 得到每个表允许导入导出的列名，及导入时需要验证的正则
     *
     * @author luchaonan 2017/03/03
     */
    public function get_list_name(){
        $xlsCell  = array(
            array('zn_name','中文名'),
            array('en_name','英文名'),
            array('alias','别名'),
            array('job_number','工号'),
            array('mobile','手机号'),
            array('extension_no','固话'),
            array('email','邮箱'),
            array('department_name','部门'),
            array('receiving_demand','收件需求'),
            array('seat_detail','座位号'),
            array('turnover_status','离职状态'),
        );
        return $xlsCell;
    }

}
